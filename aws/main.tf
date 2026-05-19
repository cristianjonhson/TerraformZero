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

  bucket_tags = merge(local.common_tags, {
    Name = local.bucket_name
  })
}

# Recurso de Terraform para crear un bucket de S3 en AWS. El nombre del bucket es único gracias a la función random_pet que genera un sufijo aleatorio.
resource "aws_s3_bucket" "example" {
  bucket = local.bucket_name
}

# Recurso de Terraform para aplicar etiquetas al bucket de S3 creado. Las etiquetas se definen en la variable local.bucket_tags, que combina etiquetas comunes con una etiqueta específica para el nombre del bucket.
resource "aws_s3_bucket_tagging" "example" {
  bucket = aws_s3_bucket.example.id

  dynamic "tag_set" {
    for_each = local.bucket_tags

    content {
      key   = tag_set.key
      value = tag_set.value
    }
  }
}
