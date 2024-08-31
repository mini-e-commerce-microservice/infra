resource "minio_s3_bucket" "private_bucket" {
  bucket = "private"
  acl    = "private"
}

output "minio_id" {
  value = "${minio_s3_bucket.private_bucket.id}"
}

output "minio_url" {
  value = "${minio_s3_bucket.private_bucket.bucket_domain_name}"
}