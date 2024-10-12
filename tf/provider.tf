terraform {
  required_providers {
    rabbitmq = {
      source  = "cyrilgdn/rabbitmq"
      version = "~> 1.6"
    }
    minio = {
      version = "2.5.0"
      source  = "aminueza/minio"
    }
  }
}

variable "VAULT_ROOT_TOKEN" {
  type = string
  description = "The Vault root token"
  sensitive = true
}

provider "rabbitmq" {
  endpoint = "http://127.0.0.1:15672"
  username = "rabbitmq"
  password = "pas12345"
}

provider "minio" {
  minio_server   = "localhost:9000"
  minio_password = "minioadmin"
  minio_user     = "minioadmin"
}

provider "vault" {
  address = "http://127.0.0.1:8201"
  token   = var.VAULT_ROOT_TOKEN
}