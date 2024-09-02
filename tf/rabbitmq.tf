resource "rabbitmq_exchange" "notifications" {
  name  = "notifications"
  vhost = "/"

  settings {
    type        = "direct"
    durable     = true
    auto_delete = true
  }
}

resource "rabbitmq_queue" "notification_type_email" {
  name  = "notification_type_email"
  vhost = "/"

  settings {
    durable     = true
    auto_delete = false
  }
}

resource "rabbitmq_binding" "notification_email" {
  source           = rabbitmq_exchange.notifications.name
  vhost            = "/"
  destination      = rabbitmq_queue.notification_type_email.name
  destination_type = "queue"
  routing_key      = "notification.type.email"
}