# Instrucciones del Proyecto TerraformZero

## Objetivo
Aplica estas reglas para cualquier respuesta o cambio en este repositorio.
Prioriza claridad, seguridad y reproducibilidad en Terraform.

## Contexto del proyecto
- Proyecto base de IaC local con Terraform (`>= 1.5.0`).
- Providers principales: `hashicorp/local` y `hashicorp/random`.
- Infraestructura ubicada en `infra/`.
- Flujo principal documentado en `README.md` (seccion "Ejecucion paso a paso").

## Reglas para respuestas de Copilot
- Responde en espanol, de forma concreta y accionable.
- Cuando propongas cambios, explica primero el impacto funcional y luego los pasos.
- Si compartes comandos, usa secuencias ejecutables y ordenadas.
- Si falta contexto critico, indicalo explicitamente antes de asumir.

## Reglas para cambios en Terraform
- Limita los cambios de IaC a archivos bajo `infra/`, salvo que se solicite otra cosa.
- Mantener consistencia de estilo con el codigo existente.
- Preferir variables declaradas en `infra/variables.tf` antes que valores hardcodeados.
- Mantener y actualizar outputs relevantes en `infra/output.tf` cuando cambie el comportamiento.
- No introducir providers, modulos o backends nuevos sin justificar la necesidad.

## Flujo obligatorio de validacion
Antes de considerar un cambio como listo, usar este orden:

1. `terraform fmt`
2. `terraform init` (si aplica o cambian providers/modulos)
3. `terraform validate`
4. `terraform plan`

Si algun paso falla, corregir antes de continuar.

## Seguridad y control de versiones
- Nunca incluir secretos en codigo, variables por defecto, salidas ni ejemplos.
- Nunca commitear `.terraform/`, `*.tfstate`, `*.tfstate.backup` ni artefactos locales.
- Si detectas riesgo de exponer informacion sensible, deten el cambio y reporta el riesgo.

## Variables y ejecucion
- Para personalizacion de entrada, preferir `-var-file="<ambiente>.tfvars"`.
- `-var` inline solo para pruebas rapidas o ejemplos pequenos.
- Si se agregan variables nuevas, documentarlas en `README.md`.

## MCP y VS Code
- Si la tarea involucra MCP de Terraform, respetar la configuracion de `.vscode/mcp.json`.
- Priorizar herramientas de registro/documentacion para verificar versiones y buenas practicas.

## Criterios de finalizacion
Un cambio se considera completo cuando:
- Cumple el comportamiento solicitado.
- Pasa `fmt`, `validate` y `plan` (cuando aplique).
- No introduce archivos sensibles o efimeros en el control de versiones.
- Incluye actualizacion de documentacion si cambia el uso del proyecto.
