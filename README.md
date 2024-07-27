# Infrastructure Setup Documentation

## Overview
This document provides an overview of the infrastructure setup for your project, including Kafka, MinIO, and RabbitMQ services, etc. The setup uses Docker Compose to manage multi-container applications.

## Docker Compose Configurations

### Kafka and Zookeeper
1. port zookeeper 2181
2. port kafka 8003

### MinIO and Nginx
1. port minio console 9001
2. port minio api 9000

### RabbitMQ
1. port rabbitmq server 5672
2. port rabbitmq ui 15672

### otel and zipkin
1. otel port grpc client 4137
2. zipkin ui 9411

## service configurations

### user service
1. port app 3001
2. port db postgre 5433

## event driven topic

### kafka

### rabbitmq