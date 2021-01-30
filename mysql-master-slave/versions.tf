terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
    }
    mysql = {
      source = "terraform-providers/mysql"
    }
    null = {
      source = "hashicorp/null"
    }
  }
  required_version = ">= 0.13"
}
