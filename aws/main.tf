# Recurso de Terraform para crear un bucket de S3 en AWS. El nombre del bucket es único gracias a la función random_pet que genera un sufijo aleatorio.
resource "aws_s3_bucket" "example" {
  bucket = "${var.env}-${var.aws_s3_bucket_name}"

  tags = {
    Name        = var.aws_s3_bucket_name
    Environment = var.env
  }
}
