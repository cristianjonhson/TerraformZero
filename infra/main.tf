locals {
  generated_content = <<-EOT
	Proyecto: ${var.project_name}
	Generado por: terraform-provider-local
	Fecha: ${timestamp()}
	EOT
}

resource "local_file" "example" {
  filename = var.output_file
  content  = local.generated_content
}
