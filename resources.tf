resource "docker_image" "python_alpine" {
  name = "nginx"
}

resource "docker_container" "logins" {
  count = local.count
  name = "1RV22MC${format("%03s", count.index + 1)}"

  image = docker_image.python_alpine.image_id

  ports {
    internal = 80
    external = 3000
  }

  networks_advanced {
    name = docker_network.macvlan.id
  }
}

resource "docker_network" "macvlan" {
  name = "macvlan"
  driver = "macvlan"

  ipam_config {
    gateway = var.network.gateway
    subnet = var.network.subnet
    ip_range = var.network.ip_range
  }

  options = {
    parent: var.network.interface
  }
}