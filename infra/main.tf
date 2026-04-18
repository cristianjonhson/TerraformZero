# Contenido que Terraform escribira en el archivo local en cada apply.
locals {
  generated_content = <<-EOT
	Proyecto: ${var.project_name}
	Generado por: terraform-provider-local
	Fecha: ${timestamp()}
	EOT
}

# Recurso de ejemplo: crea/actualiza un archivo en el filesystem local.
resource "local_file" "example" {
  filename = var.output_file
  content  = local.generated_content
}
