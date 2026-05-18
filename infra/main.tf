# Recurso aleatorio para generar un sufijo reutilizable en nombres o etiquetas.
resource "random_pet" "project_suffix" {
  length = var.random_pet_length
}

# Contenido que Terraform escribirá en el archivo local.
locals {
  generated_content = trimspace(<<-EOT
    Proyecto: ${var.project_name}
    Sufijo aleatorio: ${random_pet.project_suffix.id}
    Generado por: terraform-provider-local
  EOT
  )
}

# Recurso de ejemplo: crea/actualiza un archivo en el filesystem local.
resource "local_file" "example" {
  filename        = var.output_file
  content         = "${local.generated_content}\n"
  file_permission = "0644"
}

# Crea una carpeta adicional manteniendo un archivo marcador dentro de ella.
resource "local_file" "generated_folder_marker" {
  filename = "${var.generated_folder}/.gitkeep"
  content  = ""
}
