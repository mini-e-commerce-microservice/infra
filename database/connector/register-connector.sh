http PUT http://0.0.0.0:8083/connectors/user-service-user-connector/config < user-service-register-user-connector.json
http PUT http://0.0.0.0:8083/connectors/product-service-product-connector/config < product-service-register-product-connector.json
http PUT http://0.0.0.0:8083/connectors/order-service-outboxevent-connector/config < order-service-register-outboxevent-connector.json
http PUT http://0.0.0.0:8083/connectors/payment-service-outboxevent-connector/config < payment-service-register-outboxevent-connector.json