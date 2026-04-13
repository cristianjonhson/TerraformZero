# TerraformZero

Proyecto base para practicar y documentar infraestructura como codigo (IaC) con Terraform, usando `terraform-provider-local` para generar recursos locales de forma sencilla y reproducible.

Tambien incluye una configuracion de servidor MCP en Docker para integraciones locales desde VS Code.

## Descripcion

Este repositorio implementa una infraestructura minima que:

- Configura Terraform y el proveedor `hashicorp/local`.
- Crea un archivo local con contenido dinamico (`local_file`).
- Expone outputs para validar ruta y contenido generado.
- Incluye configuracion MCP endurecida para correr un servidor via Docker.

Es ideal como plantilla de inicio para:

- Aprender flujo Terraform (`init`, `plan`, `apply`, `destroy`).
- Entender estructura basica de un proyecto IaC.
- Probar integraciones locales antes de pasar a proveedores cloud.

## Tecnologias

- Terraform >= 1.5.0
- Provider: `hashicorp/local` (~> 2.5)
- Docker (para el servidor MCP)
- VS Code (opcional, para uso de `.vscode/mcp.json`)

## Estructura Del Proyecto

```text
TerraformZero/
├── .gitignore
├── .vscode/
│   └── mcp.json
├── infra/
│   ├── main.tf
│   ├── output.tf
│   ├── provider.tf
│   ├── variables.tf
│   ├── .terraform.lock.hcl
│   └── generated/
└── README.md
```

Nota: directorios/archivos de estado como `.terraform/` y `*.tfstate` son temporales y estan ignorados por Git.

## Requisitos

Antes de ejecutar, verifica:

1. Terraform instalado:

```bash
terraform version
```

2. Docker instalado (si vas a usar MCP):

```bash
docker --version
```

3. (Opcional) Credenciales AWS en `~/.aws` si tu contenedor MCP las necesita.

## Configuracion Terraform

Variables disponibles en `infra/variables.tf`:

- `project_name` (string, default: `TerraformZero`): nombre del proyecto.
- `output_file` (string, default: `generated/hola.txt`): ruta del archivo local a generar.

Puedes sobreescribir variables por CLI:

```bash
terraform apply -var="project_name=Demo" -var="output_file=generated/demo.txt"
```

O usando archivo `*.tfvars` (recomendado para ambientes):

```bash
terraform apply -var-file="dev.tfvars"
```

## Como Ejecutarlo

Desde la raiz del repo:

1. Entrar al directorio de infraestructura:

```bash
cd infra
```

2. Formatear archivos:

```bash
terraform fmt
```

3. Inicializar proveedores:

```bash
terraform init
```

4. Validar configuracion:

```bash
terraform validate
```

5. Ver plan de cambios:

```bash
terraform plan
```

6. Aplicar cambios:

```bash
terraform apply
```

7. Ver outputs:

```bash
terraform output
```

8. Destruir recursos:

```bash
terraform destroy
```

## Resultado Esperado

Al aplicar la infraestructura se genera un archivo local (por defecto `infra/generated/hola.txt`) con contenido similar a:

```text
Proyecto: TerraformZero
Generado por: terraform-provider-local
Fecha: 2026-04-13T00:00:00Z
```

Ademas, `terraform output` devolvera:

- `generated_file_path`
- `generated_file_content`

## Configuracion MCP Con Docker

El archivo `.vscode/mcp.json` define un servidor MCP con:

- Ejecucion por `docker run`.
- Montaje del workspace en `/workspace`.
- Montaje de `~/.aws` en modo solo lectura.
- Red explicita (`bridge`).
- Flags de seguridad (`--read-only`, `--cap-drop ALL`, `no-new-privileges`).
- Limites de recursos (`--cpus`, `--memory`, `--pids-limit`).

Recuerda reemplazar la imagen `mcp/mi-servidor:latest` por la que corresponda en tu entorno.

## Buenas Practicas

- No versionar estados locales (`*.tfstate`) en Git.
- Mantener `terraform fmt` y `terraform validate` en tu flujo.
- Evitar credenciales hardcodeadas en archivos `.tf`.
- Usar `*.tfvars` por ambiente (`dev`, `qa`, `prod`).
- Revisar siempre `terraform plan` antes de `apply`.

## Troubleshooting

1. Error al descargar provider:
- Ejecuta `terraform init -upgrade` y revisa conectividad a registry.

2. El archivo no aparece en `generated/`:
- Verifica `output_file` y que ejecutaste `terraform apply` en `infra/`.

3. Problemas con Docker en MCP:
- Confirma permisos del daemon Docker.
- Verifica que la imagen exista localmente o en registry.
- Ajusta paths de volumen si cambiaste estructura del proyecto.

## Roadmap Sugerido

- Agregar ambientes con `dev.tfvars`, `prod.tfvars`.
- Separar en modulos reutilizables.
- Integrar checks en CI (`fmt`, `validate`, `plan`).
- Migrar luego a un proveedor cloud (AWS/Azure/GCP) manteniendo la misma base.

## Licencia

Uso interno o educativo. Ajusta esta seccion segun las politicas de tu organizacion.
