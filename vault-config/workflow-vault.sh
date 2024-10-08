#!/bin/sh

# Start vault
vault server -config /vault-config/config.hcl 
# &

# # Wait for Vault to start
# sleep 5

# # Export values
# export VAULT_ADDR='http://0.0.0.0:8201'
# export VAULT_SKIP_VERIFY='true'

# # Parse unsealed keys
# keyArray=""
# while IFS= read -r line; do
#   keyArray="${keyArray} ${line:14}" # Extract the key starting from the 15th character
# done < <(grep "Unseal Key " generated_keys.txt)

# # Unseal the vault using the unseal keys
# for key in $keyArray; do
#   vault operator unseal "$key"
# done

# # Get root token
# rootToken=""
# while IFS= read -r line; do
#   rootToken="${line:20}" # Extract the token starting from the 21st character
# done < <(grep "Initial Root Token: " generated_keys.txt)

# # Write the root token to a file
# echo "$rootToken" > root_token.txt

# export VAULT_TOKEN="$rootToken"

# # Enable kv secrets engine
# vault secrets enable -version=1 kv

# # Enable userpass authentication and add default user
# vault auth enable userpass
# vault policy write spring-policy /vault-config/spring-policy.hcl
# vault write auth/userpass/users/admin password="${SECRET_PASS}" policies=spring-policy

# # Add test value to my-secret
# vault kv put kv/my-secret my-value=s3cr3t
