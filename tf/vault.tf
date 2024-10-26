resource "vault_mount" "kv" {
  path        = "kv"
  type        = "kv"
  options     = { version = "2" }
  description = "KV Version 2 secret engine mount"
}

resource "vault_policy" "kv_reader" {
  depends_on = [vault_mount.kv]
  name       = "kv-reader"

  policy = <<EOT
path "kv/*" {
  capabilities = ["read", "list"]
}
EOT
}

output "kv_reader_token_output" {
  value = vault_token.auth_service_token.id
}

resource "vault_token" "auth_service_token" {
  depends_on      = [vault_policy.kv_reader]
  policies        = [vault_policy.kv_reader.name]
  ttl             = "72000h"
  renew_min_lease = 43200
  renew_increment = 86400
  metadata = {
    "purpose" = "mini-ecommerce backend service"
  }
}

resource "vault_kv_secret_v2" "auth-service" {
  depends_on          = [vault_mount.kv]
  mount               = "kv"
  name                = "auth-service"
  cas                 = 1
  delete_all_versions = true
  data_json = jsonencode(
    {
      app_mode                   = "dev",
      app_port                   = 3002,
      database_dsn               = "postgres://auth_svc_user:auth_svc@127.0.0.1:5434/auth_svc_db?sslmode=disable",
      redis_client_name          = "auth-service",
      tracer_name                = "auth-service"
      consumer_user_data_group_1 = "auth.service.consumer.user.data.group1"
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
  depends_on          = [vault_mount.kv]
  mount               = "kv"
  name                = "jwt"
  cas                 = 1
  delete_all_versions = true
  data_json = jsonencode(
    {
      access_token = {
        expired_at = 10
        key        = "Q39Sl6Sg9aYOz6OQ0VyuiC5j6EhH5s9T"
      },
      otp_usecase = {
        expired_at = 5
        key        = "Q39Sl6Sg9aYOz6OQ0VyuiC5j6EhH5s9T"
      },
      refresh_token = {
        expired_at             = 43200
        key                    = "Q39Sl6Sg9aYOz6OQ0VyuiC5j6EhH5s9T"
        remember_me_expired_at = 525600
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
  depends_on          = [vault_mount.kv]
  mount               = "kv"
  name                = "kafka"
  cas                 = 1
  delete_all_versions = true
  data_json = jsonencode(
    {
      host = "localhost:9092",
      topic = {
        usersvc_public_users = {
          name = "usersvc.public.users",
          consumer_group = {
            authsvc = "usersvc_public_users_group_authsvc"
          }
        },
        productsvc_public_outbox = {
          name = "productsvc.public.outbox",
          consumer_group = {
            ordersvc = "productsvc_public_outbox_group_authsvc"
          }
        }
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
  depends_on          = [vault_mount.kv]
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
  depends_on          = [vault_mount.kv]
  mount               = "kv"
  name                = "minio"
  cas                 = 1
  delete_all_versions = true
  data_json = jsonencode(
    {
      "access_id"         = "j2q1KA3rvhBveywO",
      "endpoint"          = "localhost:9000",
      "private_bucket"    = "private",
      "secret_access_key" = "DNVNfrN5HSRQg6l36ayqfg5yRRmtmW4F",
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
  depends_on          = [vault_mount.kv]
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
  depends_on          = [vault_mount.kv]
  mount               = "kv"
  name                = "product-service"
  cas                 = 1
  delete_all_versions = true
  data_json = jsonencode(
    {
      "app_mode"          = "dev",
      "app_port"          = 3003,
      "database_dsn"      = "postgres://product_svc_user:product_svc@127.0.0.1:5435/product_svc_db?sslmode=disable",
      "redis_client_name" = "product-service",
      "tracer_name"       = "product-service"
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
  depends_on          = [vault_mount.kv]
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
  depends_on          = [vault_mount.kv]
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
  depends_on          = [vault_mount.kv]
  mount               = "kv"
  name                = "user-service"
  cas                 = 1
  delete_all_versions = true
  data_json = jsonencode(
    {
      "app_mode"     = "dev",
      "app_port"     = 3001,
      "database_dsn" = "postgres://user_svc_user:user_svc@127.0.0.1:5433/user_svc_db?sslmode=disable",
      "tracer_name"  = "user-service"
    }
  )
  custom_metadata {
    max_versions = 5
    data = {
      email = "ibanrama29@gmail.com",
    }
  }
}

resource "vault_kv_secret_v2" "order-service" {
  depends_on          = [vault_mount.kv]
  mount               = "kv"
  name                = "order-service"
  cas                 = 1
  delete_all_versions = true
  data_json = jsonencode(
    {
      "app_mode"     = "dev",
      "app_port"     = 3004,
      "database_dsn" = "postgres://order_svc_user:order_svc@127.0.0.1:5436/order_svc_db?sslmode=disable",
      "tracer_name"  = "order-service"
    }
  )
  custom_metadata {
    max_versions = 5
    data = {
      email = "ibanrama29@gmail.com",
    }
  }
}
