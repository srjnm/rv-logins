resource "random_password" "ps" {
  count = local.count
  length = 5
  special = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "local_sensitive_file" "ps_file" {
  filename = "${path.module}/ps.txt"
  file_permission = "777"
  content = "${base64encode(join("\n", concat(["usn ip ps"], [ for k, v in local.passwords : "${docker_container.logins[k].name} ${docker_container.logins[k].network_data[0].ip_address} ${v}" ])))}"
}

resource "docker_image" "rvce-mca-lss-login" {
  name = "srjnm/rvce-mca-lss-login:v5"
}

resource "docker_container" "logins" {
  count = local.count
  name = "1RV22MC${format("%03s", count.index + 1)}"

  image = docker_image.rvce-mca-lss-login.image_id
  memory = 512
  entrypoint = ["tail", "-f", "/dev/null"]

  ports {
    internal = 22
    external = 22
  }

  networks_advanced {
    name = docker_network.macvlan.id
  }
}

resource "docker-utils_exec" "exec" {
    count = length(docker_container.logins)
    container_name = "1RV22MC${format("%03s", count.index + 1)}"
    commands = ["/bin/bash", "-c", "useradd -s /bin/bash -p $(mkpasswd --hash=SHA-512 '${local.passwords[count.index]}') -m 1RV22MC${format("%03s", count.index + 1)} && usermod -aG sudo 1RV22MC${format("%03s", count.index + 1)} && service ssh start"]
}

resource "docker_network" "macvlan" {
  name = "macvlan"
  driver = "macvlan"

  ipam_config {
    gateway = var.network.gateway
    subnet = var.network.subnet
    ip_range = var.network.ip_range
    aux_address = var.network.aux_address
  }

  options = {
    parent: var.network.interface
  }
}
