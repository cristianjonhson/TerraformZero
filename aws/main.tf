# Recurso de Terraform para generar un sufijo aleatorio utilizando el proveedor random. Este sufijo se utiliza para garantizar que el nombre del bucket de S3 sea único.
resource "random_pet" "project_suffix" {
  length = var.random_pet_length
}

# Variables de entrada para personalizar el entorno y el nombre base del bucket.
locals {
  bucket_name = lower("${var.env}-${var.aws_s3_bucket_name}-${random_pet.project_suffix.id}")

  common_tags = {
    Project     = var.project_name
    Environment = var.env
    ManagedBy   = var.managed_by
    Component   = var.component_name_tag_value
  }
}

# Recurso de Terraform para crear un bucket de S3 en AWS. El nombre del bucket es único gracias a la función random_pet que genera un sufijo aleatorio.
resource "aws_s3_bucket" "example" {
  bucket = local.bucket_name

  tags = merge(local.common_tags, {
    Name = local.bucket_name
  })
}
