# vault-test.hcl
ui = true
disable_mlock = "true"

backend "file" {
  path = "/data/vault"
}

listener "tcp" {
  address = "0.0.0.0:8201"
  tls_disable = true
  # Uncomment and set paths to enable TLS
  # tls_cert_file = "/path/to/cert.pem"
  # tls_key_file = "/path/to/key.pem"
}

# Optionally, add more configurations here as needed
