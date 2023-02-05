variable "network" {
  type = object({
    subnet = string
    gateway = string
    ip_range = string
    interface = string
    aux_address = map(string)
  })
}

variable "docker_tcp_host" {
  type = string
}
