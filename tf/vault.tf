resource "vault_mount" "kv" {
  path        = "kv"
  type        = "kv"
  options     = { version = "2" }
  description = "KV Version 2 secret engine mount"
}

resource "vault_policy" "kv_reader" {
  name = "kf-reader"

  policy = <<EOT
path "kv/*" {
  capabilities = ["read", "list"]
}
EOT
}

resource "vault_token" "auth_service_token" {
  policies = [vault_policy.kv_reader.name]
  ttl      = "72000h"
  renew_min_lease = 43200
  renew_increment = 86400
  metadata = {
    "purpose" = "mini-ecommerce backend service"
  }
}

resource "vault_kv_secret_v2" "auth-service" {
  mount               = "kv"
  name                = "auth-service"
  cas                 = 1
  delete_all_versions = true
  data_json = jsonencode(
    {
      APP_MODE          = "dev",
      APP_PORT          = 3002,
      DATABASE_DSN      = "postgres://auth_svc_user:auth_svc@127.0.0.1:5434/auth_svc_db?sslmode=disable",
      REDIS_CLIENT_NAME = "auth-service",
      TRACER_NAME       = "auth-service"
    }
  )
  custom_metadata {
    max_versions = 5
    data = {
      email = "ibanrama29@gmail.com",
    }
  }
}

resource "vault_kv_secret_v2" "jwt" {
  mount               = "kv"
  name                = "jwt"
  cas                 = 1
  delete_all_versions = true
  data_json = jsonencode(
    {
      access_token = {
        expired_at = "10"
        key        = "Q39Sl6Sg9aYOz6OQ0VyuiC5j6EhH5s9T"
      },
      otp_usecase = {
        expired_at = "5"
        key        = "Q39Sl6Sg9aYOz6OQ0VyuiC5j6EhH5s9T"
      },
      refresh_token = {
        expired_at             = "43200"
        key                    = "Q39Sl6Sg9aYOz6OQ0VyuiC5j6EhH5s9T"
        remember_me_expired_at = "525600"
      }
    }
  )
  custom_metadata {
    max_versions = 5
    data = {
      email = "ibanrama29@gmail.com",
    }
  }
}

resource "vault_kv_secret_v2" "kafka" {
  mount               = "kv"
  name                = "kafka"
  cas                 = 1
  delete_all_versions = true
  data_json = jsonencode(
    {
      host = "localhost:9092",
      topic = {
        cdc_user_table = "usersvc.public.users"
      }
    }
  )
  custom_metadata {
    max_versions = 5
    data = {
      email = "ibanrama29@gmail.com",
    }
  }
}

resource "vault_kv_secret_v2" "mailer" {
  mount               = "kv"
  name                = "mailer"
  cas                 = 1
  delete_all_versions = true
  data_json = jsonencode(
    {
      "list_email_address" = {
        "no_reply_email_address" = "no-replay.mini-ecommerce@gmail.com"
      },
      "mail_trap" = {
        "host"     = "sandbox.smtp.mailtrap.io",
        "password" = "ce2bad5df258ae",
        "port"     = 587,
        "username" = "035e4c2ff87149"
      },
      "template_html" = {
        "activation_email_otp" = "activation_email.html"
      },
      "use_used_mail_trap" = true
    }
  )
  custom_metadata {
    max_versions = 5
    data = {
      email = "ibanrama29@gmail.com",
    }
  }
}

resource "vault_kv_secret_v2" "minio" {
  mount               = "kv"
  name                = "minio"
  cas                 = 1
  delete_all_versions = true
  data_json = jsonencode(
    {
      "access_id"         = "5yy3BY1e98t57rmJ",
      "endpoint"          = "localhost=9000",
      "private_bucket"    = "private",
      "secret_access_key" = "IOMMuxVEpV4odgtZQrGDGF17sOfbapx4",
      "use_ssl"           = false
    }
  )
  custom_metadata {
    max_versions = 5
    data = {
      email = "ibanrama29@gmail.com",
    }
  }
}

resource "vault_kv_secret_v2" "otel" {
  mount               = "kv"
  name                = "otel"
  cas                 = 1
  delete_all_versions = true
  data_json = jsonencode(
    {
      "endpoint" = "0.0.0.0:4317",
      "password" = "pw",
      "username" = "user"
    }
  )
  custom_metadata {
    max_versions = 5
    data = {
      email = "ibanrama29@gmail.com",
    }
  }
}

resource "vault_kv_secret_v2" "product-service" {
  mount               = "kv"
  name                = "product-service"
  cas                 = 1
  delete_all_versions = true
  data_json = jsonencode(
    {
      "APP_MODE"          = "dev",
      "APP_PORT"          = 3003,
      "DATABASE_DSN"      = "postgres://product_svc_user:product_svc@127.0.0.1:5435/product_svc_db?sslmode=disable",
      "REDIS_CLIENT_NAME" = "product-service",
      "TRACER_NAME"       = "product-service"
    }
  )
  custom_metadata {
    max_versions = 5
    data = {
      email = "ibanrama29@gmail.com",
    }
  }
}

resource "vault_kv_secret_v2" "rabbitmq" {
  mount               = "kv"
  name                = "rabbitmq"
  cas                 = 1
  delete_all_versions = true
  data_json = jsonencode(
    {
      "exchanges" = {
        "notification_exchange" = {
          "name" = "notifications",
          "notification_type_email" = {
            "routing_key" = {
              "name" = "notification.type.email",
              "queue" = {
                "name" = "notification_type_email"
              }
            }
          }
        }
      },
      "password" = "pas12345",
      "url"      = "amqp://rabbitmq:pas12345@localhost:5672/",
      "username" = "rabbitmq"
    }
  )
  custom_metadata {
    max_versions = 5
    data = {
      email = "ibanrama29@gmail.com",
    }
  }
}

resource "vault_kv_secret_v2" "redis" {
  mount               = "kv"
  name                = "redis"
  cas                 = 1
  delete_all_versions = true
  data_json = jsonencode(
    {
      "host"            = "127.0.0.1:6379",
      "password"        = "pas12345",
      "tracking_prefix" = "cache:"
    }
  )
  custom_metadata {
    max_versions = 5
    data = {
      email = "ibanrama29@gmail.com",
    }
  }
}

resource "vault_kv_secret_v2" "user-service" {
  mount               = "kv"
  name                = "user-service"
  cas                 = 1
  delete_all_versions = true
  data_json = jsonencode(
    {
      "APP_MODE"     = "dev",
      "APP_PORT"     = 3001,
      "DATABASE_DSN" = "postgres://user-svc:user-svc@localhost:5433/user-svc?sslmode=disable",
      "TRACER_NAME"  = "user-service"
    }
  )
  custom_metadata {
    max_versions = 5
    data = {
      email = "ibanrama29@gmail.com",
    }
  }
}

