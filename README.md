# TerraformZero

![Terraform](https://img.shields.io/badge/Terraform-%3E%3D1.5-623CE4?logo=terraform&logoColor=white)
![Providers](https://img.shields.io/badge/Providers-hashicorp%2Flocal%20%7C%20hashicorp%2Frandom-0A7B83)
![Docker](https://img.shields.io/badge/Docker-MCP%20Runtime-2496ED?logo=docker&logoColor=white)
![Status](https://img.shields.io/badge/Status-Base%20Template-2E7D32)

Plantilla base de Infraestructura como Codigo (IaC) con Terraform para entornos locales. El proyecto usa `terraform-provider-local` para crear archivos en filesystem, `hashicorp/random` para generar sufijos aleatorios reutilizables y agrega una configuracion MCP en Docker para ejecutar el servidor oficial de Terraform.

## Tabla de contenidos

- [1. Resumen ejecutivo](#1-resumen-ejecutivo)
- [2. Alcance](#2-alcance)
- [3. Stack tecnologico](#3-stack-tecnologico)
- [4. Estructura del repositorio](#4-estructura-del-repositorio)
- [5. Requisitos](#5-requisitos)
- [6. Configuracion](#6-configuracion)
- [7. Ejecucion paso a paso](#7-ejecucion-paso-a-paso)
- [8. Operacion diaria](#8-operacion-diaria)
- [9. MCP en Docker](#9-mcp-en-docker)
- [10. Seguridad y cumplimiento](#10-seguridad-y-cumplimiento)
- [11. Convenciones de contribucion](#11-convenciones-de-contribucion)
- [12. Troubleshooting](#12-troubleshooting)
- [13. Roadmap](#13-roadmap)
- [14. Automatizacion con Copilot](#14-automatizacion-con-copilot)
- [15. Licencia](#15-licencia)

## 1. Resumen ejecutivo

TerraformZero permite validar un flujo IaC end-to-end sin depender de un proveedor cloud.

Objetivos principales:

- Estandarizar comandos Terraform basicos (`init`, `fmt`, `validate`, `plan`, `apply`, `destroy`).
- Mantener una base reproducible para evolucionar a modulos y ambientes.
- Proveer una configuracion MCP portable con Docker para integraciones locales.

## 2. Alcance

Incluido:

- Configuracion de Terraform `>= 1.5.0`.
- Providers `hashicorp/local` y `hashicorp/random`.
- Recursos `local_file` y `random_pet` con contenido dinamico.
- Outputs de validacion.
- `.gitignore` orientado a Terraform.
- Configuracion MCP en `.vscode/mcp.json`.

No incluido en esta fase:

- Backend remoto de estado.
- Modulos reutilizables por dominio.
- Pipelines CI/CD.

## 3. Stack tecnologico

- Terraform >= 1.5.0
- Provider `hashicorp/local` `~> 2.5`
- Provider `hashicorp/random` `~> 3.0`
- Docker (runtime del servidor MCP)
- VS Code (consumo de configuracion MCP)

## 4. Estructura del repositorio

```text
TerraformZero/
|-- .gitignore
|-- .github/
|   |-- copilot-instructions.md
|   |-- agents/
|   |   `-- crear-terraform.agent.md
|   |-- instructions/
|   |   `-- terraform.instructions.md
|   `-- prompts/
|       `-- crear-terraform.prompt.md
|-- .vscode/
|   `-- mcp.json
|-- infra/
|   |-- main.tf
|   |-- output.tf
|   |-- provider.tf
|   |-- variables.tf
|   |-- .terraform.lock.hcl
|   `-- generated/
`-- README.md
```

Nota: `.terraform/`, `*.tfstate` y artefactos locales estan fuera de control de versiones.

## 5. Requisitos

1. Terraform instalado y disponible en PATH.
2. Docker instalado y daemon en ejecucion.
3. VS Code con soporte MCP (opcional, para consumir `.vscode/mcp.json`).

Validaciones rapidas:

```bash
terraform version
docker --version
```

## 6. Configuracion

Variables declaradas en `infra/variables.tf`:

- `project_name` (string, default `TerraformZero`)
- `output_file` (string, default `generated/hola.txt`)
- `random_pet_length` (number, default `2`)
- `generated_folder` (string, default `generated/artifacts`)

Sobrescritura por CLI:

```bash
terraform apply -var="project_name=Demo" -var="output_file=generated/demo.txt"
```

Sobrescritura por archivo tfvars:

```bash
terraform apply -var-file="dev.tfvars"
```

Uso de `infra/variables.tf` y `infra/terraform.tfvars`:

- `infra/variables.tf` define el esquema de variables (nombre, tipo y default).
- `infra/terraform.tfvars` define valores concretos para ejecucion local.

Ejemplo del archivo `infra/terraform.tfvars`:

```hcl
project_name      = "TerraformZero"
output_file       = "generated/hola.txt"
random_pet_length = 2
generated_folder  = "generated/artifacts"
```

Nota: Terraform carga `terraform.tfvars` automaticamente cuando ejecutas comandos desde `infra/`.

Ejemplo explicito de ejecucion con ese archivo:

```bash
cd infra
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```

## 7. Ejecucion paso a paso

Desde la raiz del repositorio:

```bash
cd infra
terraform fmt
terraform init
terraform validate
terraform plan
terraform apply
# Opcional para ejecucion no interactiva:
terraform apply -auto-approve
terraform output
```

Nota sobre `terraform plan`:

- Si no usas `-out`, Terraform no garantiza que `terraform apply` ejecute exactamente las mismas acciones mostradas por el plan.
- Para un flujo reproducible, usa:

```bash
terraform plan -out=tfplan
terraform apply tfplan
```

Para limpieza:

```bash
terraform destroy
# Opcional para ejecucion no interactiva:
terraform destroy -auto-approve
```

Resultado esperado tras `apply`:

- Archivo generado en `infra/generated/hola.txt` (o la ruta definida en `output_file`).
- Outputs disponibles:
	- `generated_file_path`
	- `generated_file_content`
	- `random_pet_suffix`
	- `generated_folder_path`

Ejemplo real de `terraform output`:

```text
generated_file_content = <<EOT
Proyecto: TerraformZero
Sufijo aleatorio: live-snapper
Generado por: terraform-provider-local

EOT
generated_file_path = "generated/hola.txt"
random_pet_suffix = "live-snapper"
```

Para ver el contenido sin formato heredoc:

```bash
terraform output -raw generated_file_content
```

Para ver todos los outputs en formato JSON:

```bash
terraform output -json
```

Ejemplo real del archivo generado (`infra/generated/hola.txt`):

```text
Proyecto: TerraformZero
Sufijo aleatorio: live-snapper
Generado por: terraform-provider-local
```

Nota: el valor de `random_pet_suffix` cambia solo cuando el recurso aleatorio se vuelve a crear.

## 8. Operacion diaria

Flujo recomendado para cambios:

1. Crear branch de trabajo.
2. Editar archivos en `infra/`.
3. Ejecutar `terraform fmt` y `terraform validate`.
4. Revisar `terraform plan`.
5. Aplicar cambios cuando corresponda.
6. Documentar impacto en este README si cambia comportamiento.

## 9. MCP en Docker

El archivo `.vscode/mcp.json` define un servidor MCP llamado `terraform-local` bajo la clave `servers`.

Configuracion actual:

- Comando de ejecucion: `docker`
- Imagen: `hashicorp/terraform-mcp-server`
- Modo: `docker run -i --rm`
- Nombre explicito del contenedor: `terraform-mcp-local`
- Montaje del workspace: `${workspaceFolder}:/workspace`
- Directorio de trabajo en contenedor: `/workspace`
- Toolset habilitado: `registry` (`--toolsets=registry`)
- Variables de entorno:
	- `MCP_LOG_LEVEL=warn`
  - `PROJECT_ROOT=/workspace`

Esta configuracion esta enfocada en simplicidad para desarrollo local y pruebas rapidas.

Como se levanta el MCP con esta configuracion:

1. Asegura Docker activo (Docker Desktop o daemon en ejecucion).
2. Si editaste `.vscode/mcp.json`, recarga VS Code con `Developer: Reload Window`.
3. En uso normal con Copilot, no necesitas iniciarlo manualmente: se ejecuta bajo demanda.

Comando manual para probarlo desde la raiz del repo:

```bash
docker run -i --rm --name terraform-mcp-local -v "$PWD:/workspace" -w /workspace -e MCP_LOG_LEVEL=warn -e PROJECT_ROOT=/workspace hashicorp/terraform-mcp-server --toolsets=registry stdio
```

Notas rapidas:

- El proceso queda en primer plano esperando comunicacion por stdin/stdout (modo `stdio`).
- Si no arranca, prueba primero: `docker pull hashicorp/terraform-mcp-server`.
- Al usar `--rm`, el contenedor se elimina automaticamente al finalizar.

## 10. Seguridad y cumplimiento

Lineamientos aplicados:

- No se versionan estados Terraform ni secretos locales.
- Se recomienda revisar periodicamente versiones de provider e imagen Docker.
- El servidor MCP se ejecuta en contenedor efimero (`--rm`) para mantener entornos limpios.

Recomendaciones siguientes:

- Mover estado a backend remoto para trabajo colaborativo.
- Incorporar escaneo de IaC en CI.
- Definir politica de rotacion de credenciales.

## 11. Convenciones de contribucion

Branching:

- `main`: rama estable.
- `feature/<nombre-corto>`: nuevas capacidades.
- `fix/<nombre-corto>`: correcciones.

Commits (convencion sugerida):

- `feat: descripcion breve`
- `fix: descripcion breve`
- `docs: descripcion breve`
- `chore: descripcion breve`

Checklist para Pull Request:

- [ ] README actualizado si hay cambios funcionales.
- [ ] `terraform fmt` ejecutado.
- [ ] `terraform validate` en verde.
- [ ] `terraform plan` revisado.
- [ ] Sin credenciales ni archivos de estado en el diff.

## 12. Troubleshooting

1. Provider no descarga:

- Ejecutar `terraform init -upgrade`.
- Validar salida a internet hacia Terraform Registry.

2. No se genera el archivo local:

- Confirmar ruta de `output_file`.
- Ejecutar desde `infra/`.
- Verificar que `terraform apply` termino sin errores.

3. Fallo del contenedor MCP:

- Revisar que Docker daemon este activo.
- Confirmar existencia de la imagen configurada.
- Validar rutas de volumen en host.

## 13. Roadmap

- Agregar archivos `dev.tfvars`, `qa.tfvars`, `prod.tfvars`.
- Separar logica en modulos.
- Integrar pipeline CI para `fmt`, `validate`, `plan`.
- Migrar a provider cloud manteniendo convenciones del repositorio.

## 14. Automatizacion con Copilot

El repositorio incluye personalizaciones para acelerar tareas Terraform en VS Code:

- Instrucciones de archivo: `.github/instructions/terraform.instructions.md` (aplicadas automaticamente a `infra/**/*.tf`)
- Prompt de workspace: `.github/prompts/crear-terraform.prompt.md`
- Agente de workspace: `.github/agents/crear-terraform.agent.md`

Uso sugerido:

1. Las instrucciones de Terraform se aplican automaticamente al editar archivos `.tf` en `infra/`.
2. Usa el prompt `crear-terraform` para generar cambios basicos en `infra/`.
3. Usa el agente `Crear Terraform` cuando quieras ejecutar un flujo guiado con restricciones del repo.

Como invocar el prompt desde VS Code:

1. Abre el panel de Copilot Chat (`Ctrl+Alt+I` / `Cmd+Alt+I`).
2. Escribe `/` en el campo de entrada: aparecera la lista de prompts disponibles.
3. Selecciona `crear-terraform` o escribe `/crear-terraform` directamente.
4. Describe el cambio que necesitas, por ejemplo:

```
/crear-terraform agrega un recurso local_file que genere un archivo README.txt en generated/
```

5. Copilot ejecutara el flujo del agente con las restricciones del repo aplicadas.

Ambos siguen estas reglas:

- Cambios limitados a `infra/` (salvo solicitud explicita).
- Reutilizar variables existentes antes de hardcodear.
- Ejecutar validacion en orden: `terraform fmt`, `terraform init` (si aplica), `terraform validate`, `terraform plan`.
- No incluir secretos en codigo, variables ni outputs.

## 15. Licencia

Uso interno o educativo. Ajustar segun normativa de la organizacion.
