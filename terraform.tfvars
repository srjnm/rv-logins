# RVCE
network = {
  gateway = "172.16.3.254"
  ip_range = "172.16.3.128/25"
  subnet = "172.16.2.0/23"
  interface = "ens160"
  aux_address = {
    "host": "172.16.3.253"
  }
}

# local
# network = {
#   gateway = "192.168.1.1"
#   ip_range = "192.168.1.64/29"
#   subnet = "192.168.1.0/24"
  # interface = "wlp1s0"
# }

docker_tcp_host = "unix:///var/run/docker.sock"
