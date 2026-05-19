resource "random_pet" "project_suffix" {
  length = var.random_pet_length
}

locals {
  bucket_name = lower("${var.env}-${var.aws_s3_bucket_name}-${random_pet.project_suffix.id}")
}

# Recurso de Terraform para crear un bucket de S3 en AWS. El nombre del bucket es único gracias a la función random_pet que genera un sufijo aleatorio.
resource "aws_s3_bucket" "example" {
  bucket = local.bucket_name

  tags = {
    Name        = local.bucket_name
    Environment = var.env
  }
}
