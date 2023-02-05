variable "network" {
  type = object({
    subnet = string
    gateway = string
    ip_range = string
    interface = string
  })
}