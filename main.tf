terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
    docker-utils = {
      source = "Kaginari/docker-utils"
      version = "~> 0.0.5"
    }
  }
}
