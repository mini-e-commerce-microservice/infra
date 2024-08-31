resource "rabbitmq_exchange" "notifications" {
  name  = "notifications"
  vhost = "/"

  settings {
    type        = "direct"
    durable     = true
    auto_delete = true
  }
}

resource "rabbitmq_queue" "email_otp" {
  name  = "email_otp"
  vhost = "/"

  settings {
    durable     = true
    auto_delete = false
  }
}

resource "rabbitmq_binding" "notification_email_otp" {
  source           = rabbitmq_exchange.notifications.name
  vhost            = "/"
  destination      = rabbitmq_queue.email_otp.name
  destination_type = "queue"
  routing_key      = "notification.email.otp"
}