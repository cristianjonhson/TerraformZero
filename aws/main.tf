# Recurso de Terraform para crear un bucket de S3 en AWS. El nombre del bucket es único gracias a la función random_pet que genera un sufijo aleatorio.
resource "aws_s3_bucket" "example" {
  bucket = "my-unique-bucket-name-${random_pet.project_suffix.id}"

  tags = {
    Name        = "My S3 Bucket"
    Environment = "Dev"
  }
}
