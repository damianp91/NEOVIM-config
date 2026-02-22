# OpenCode Neovim Integration

## Configuración

1. **API Key** - Configura tu API key como variable de entorno:
   ```bash
   export OPENCODE_API_KEY="tu-api-key-aqui"
   ```

2. **Recargar Neovim** o ejecuta:
   ```vim
   :Lazy sync
   ```

## Uso

### Atajos de teclado:
- `<leader>oc` - Abrir/cerrar panel de OpenCode
- `<leader>oa` - Hacer pregunta a OpenCode
- `<leader>oe` - Explicar código seleccionado
- `<leader>or` - Refactorizar código seleccionado

### Comandos:
- `:OpenCode` - Abrir panel
- `:OpenCodeAsk <pregunta>` - Hacer pregunta
- `:OpenCodeExplain` - Explicar selección visual
- `:OpenCodeRefactor` - Refactorizar selección visual

### Flujo de trabajo:
1. Selecciona código en modo visual
2. Usa `<leader>oe` para explicación
3. Usa `<leader>or>` para refactorización
4. Escribe preguntas directamente en el panel

## Personalización

Edita `~/.config/nvim/lua/plugins/opencode.lua` para modificar:
- Atajos de teclado
- Posición y tamaño del panel
- Modelo de IA
- Características adicionales