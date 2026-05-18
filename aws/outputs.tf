output "aws_s3_bucket_name" {
  description = "Nombre del bucket de S3 creado por Terraform."
  value       = aws_s3_bucket.example.bucket
}
