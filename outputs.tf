output "ips" {
  value = [for k, v in docker_container.logins : { name = v.name, ip = v.network_data[0].ip_address }]
}