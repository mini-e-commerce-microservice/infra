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
