provider "docker" {
  host = var.docker_tcp_host
}

provider "docker-utils" {
    host = var.docker_tcp_host
}

provider "random" {
}

provider "local" {
  
}
