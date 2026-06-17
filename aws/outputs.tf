output "bucket_arn" {
  description = "ARN del bucket de S3 creado por Terraform."
  value       = aws_s3_bucket.example.arn
}

output "bucket_region" {
  description = "Región donde se creó el bucket de S3."
  value       = aws_s3_bucket.example.region
}

output "bucket_id" {
  description = "ID del bucket de S3 creado por Terraform."
  value       = aws_s3_bucket.example.id
}

output "aws_s3_bucket_name" {
  description = "Nombre del bucket de S3 creado por Terraform."
  value       = aws_s3_bucket.example.bucket
}
