# Keymaps Cheatsheet

`<Leader>` = `Space`

> **Tip**: Presiona `<Space>` y espera un segundo para ver el menu completo de which-key.

---

## General

| Accion | Keymap |
|---|---|
| Enter command mode | `;` |
| Exit insert mode | `jk` / `jj` |
| Undo | `<C-z>` |
| Guardar | `<C-s>` |
| Quit | `<C-q>` |
| Nuevo archivo | `<Leader>n` |
| Renombrar archivo | `<Leader>R` |
| Toggle comment linea | `<Leader>/` |
| Insertar comment abajo | `gco` |
| Insertar comment arriba | `gcO` |

## Navegacion de archivos

| Accion | Keymap |
|---|---|
| Toggle file explorer | `<Leader>e` |
| Focus file explorer | `<Leader>o` |
| Buscar archivos | `<Leader>ff` |
| Buscar archivos (ocultos) | `<Leader>fF` |
| Buscar texto (live grep) | `<Leader>fw` |
| Archivos recientes | `<Leader>fo` |
| Buscar en buffers abiertos | `<Leader>fb` |
| Smart open (buffers+recent+files) | `<Leader>fs` |

## Buffers

| Accion | Keymap |
|---|---|
| Siguiente buffer | `]b` |
| Buffer anterior | `[b` |
| Cerrar buffer | `<Leader>c` |
| Cerrar buffer (picker) | `<Leader>bd` |
| Cerrar todos menos actual | `<Leader>bc` |
| Cerrar todos | `<Leader>bC` |
| Mover buffer a la derecha | `>b` |
| Mover buffer a la izquierda | `<b` |
| Ir a buffer por picker | `<Leader>bb` |

## Vim Tabs

| Accion | Keymap |
|---|---|
| Siguiente tab | `]t` |
| Tab anterior | `[t` |

## Ventanas / Splits

| Accion | Keymap |
|---|---|
| Split horizontal | `\` |
| Split vertical | `\|` |
| Mover entre ventanas | `<C-h>` `<C-j>` `<C-k>` `<C-l>` |
| Resize arriba/abajo | `<C-Up>` / `<C-Down>` |

## LSP

| Accion | Keymap |
|---|---|
| Go to definition | `gd` |
| Go to declaration | `gD` |
| Go to references | `grr` / `<Leader>lR` |
| Go to implementation | `gri` |
| Go to type definition | `gy` |
| Hover info | `K` |
| Code actions | `gra` / `<Leader>la` |
| Rename symbol | `grn` / `<Leader>lr` |
| Format documento | `<Leader>lf` |
| Line diagnostics | `gl` / `<Leader>ld` |
| Next diagnostic | `]d` |
| Prev diagnostic | `[d` |
| Next error | `]e` |
| Prev error | `[e` |
| Document symbols | `<Leader>ls` |
| LSP Info | `<Leader>li` |
| Signature help | automatico al tipear |

## Autocompletado (blink.cmp)

| Accion | Keymap |
|---|---|
| Abrir menu | `<C-Space>` |
| Confirmar seleccion | `<CR>` (si no hay seleccion → newline) |
| Siguiente item | `<C-j>` / `<Tab>` |
| Item anterior | `<C-k>` / `<S-Tab>` |
| Scroll docs arriba | `<C-b>` |
| Scroll docs abajo | `<C-f>` |
| Cancelar | `<C-e>` |

## Copilot

| Accion | Keymap |
|---|---|
| Aceptar sugerencia | `<Tab>` |
| Aceptar linea | `<S-Tab>` (tambien prev item en cmp) |
| Descartar | `<A-Tab>` |
| Siguiente sugerencia | `<M-]>` |
| Sugerencia anterior | `<M-[>` |

> Copilot se oculta automaticamente cuando el menu de blink.cmp esta abierto.

## Terminal (ToggleTerm custom con tabs)

| Accion | Keymap |
|---|---|
| Toggle terminal activa | `<C-t>` |
| Nueva terminal tab | `<A-t>` |
| Cerrar terminal tab | `<A-w>` |
| Siguiente terminal | `<A-l>` |
| Terminal anterior | `<A-h>` |
| Salir de terminal mode | `<C-q>` |
| Resize terminal + | `<C-=>` |
| Resize terminal - | `<C-->` |
| Float terminal | `<Leader>tf` |
| Horizontal terminal | `<Leader>th` |
| Vertical terminal | `<Leader>tv` |
| Lazygit | `<Leader>tl` |

## OpenCode AI

| Accion | Keymap |
|---|---|
| Ask AI (temp session, float) | `<C-a>` |
| Execute action (picker) | `<C-x>` |
| Toggle opencode panel | `<C-.>` |
| Add range/file a contexto | `go` (normal + visual) |
| Add linea a contexto | `goo` |
| Scroll opencode up | `<S-C-u>` |
| Scroll opencode down | `<S-C-d>` |
| Pick session (resumir) | `<C-b>` |
| Enviar desde Snacks picker | `<A-a>` (en picker input) |

## Claude Code AI

| Accion | Keymap |
|---|---|
| Toggle Claude Code terminal | `<C-,>` |
| Enviar seleccion/buffer a Claude | `<Leader>as` |
| Agregar archivo actual al contexto | `<Leader>ac` |
| Agregar archivo de neo-tree | `<Leader>at` |
| Seleccionar modelo | `<Leader>am` |
| Aceptar diff (en buffer de diff) | `<CR>` |
| Rechazar diff (en buffer de diff) | `<Del>` / `<BS>` |

> `<C-,>` espeja `<C-.>` de OpenCode. El diff usa keymaps locales al buffer.

## TODO Comments

| Accion | Keymap |
|---|---|
| Siguiente TODO | `]T` |
| TODO anterior | `[T` |
| Buscar TODOs | `<Leader>st` |

## Pickers (Snacks/Telescope)

| Accion | Keymap |
|---|---|
| Buscar keymaps | `<Leader>fk` |
| Buscar comandos | `<Leader>fC` |
| Buscar help tags | `<Leader>fh` |
| Git status | `<Leader>gt` |
| Git branches | `<Leader>gb` |
| Git commits | `<Leader>gc` |
| Colorschemes | `<Leader>ft` |
| Registers | `<Leader>fr` |
| Marks | `<Leader>f'` |
| Undo history | `<Leader>fu` |
| Notifications | `<Leader>fn` |
| Resumir busqueda anterior | `<Leader>f<CR>` |

## Toggles UI

| Accion | Keymap |
|---|---|
| Toggle diagnostics | `<Leader>ud` |
| Toggle format-on-save (buffer) | `<Leader>uf` |
| Toggle format-on-save (global) | `<Leader>uF` |
| Toggle wrap | `<Leader>uw` |
| Toggle spellcheck | `<Leader>us` |
| Toggle inlay hints (buffer) | `<Leader>uh` |
| Toggle line numbers | `<Leader>un` |
| Toggle indent guides | `<Leader>u\|` |
| Toggle statusline | `<Leader>ul` |
| Toggle tabline | `<Leader>ut` |
| Toggle zen mode | `<Leader>uZ` |
| Toggle autopairs | `<Leader>ua` |
| Toggle autocompletion | `<Leader>uc` |

## Sessions

| Accion | Keymap |
|---|---|
| Save session | `<Leader>Ss` |
| Last session | `<Leader>Sl` |
| Search sessions | `<Leader>Sf` |
| Load current dir session | `<Leader>S.` |
| Delete session | `<Leader>Sd` |

## Package Management

| Accion | Keymap |
|---|---|
| Lazy (plugins) | `<Leader>pi` |
| Mason (tools) | `<Leader>pm` |
| Update all | `<Leader>pa` |

---

## Comandos personalizados

| Comando | Descripcion |
|---|---|
| `:Format` | Formatea buffer o seleccion visual con conform.nvim |
| `:Eslint` | Ejecuta ESLintFixAll (o en rango visual) |
| `:NotificationHistory` | Muestra historial de notificaciones (Snacks) |
| `:ConformInfo` | Info de formatters configurados |
| `:Copilot` | Gestion de Copilot (status, signout, etc.) |

## Formatters por lenguaje

| Lenguaje | Formatter |
|---|---|
| Lua | Stylua |
| JS/TS/TSX/Vue/HTML/CSS/JSON/YAML/MD | Prettier |
| Python | black + isort (via astrocommunity) |
| Bash/Sh | shfmt |

> Format-on-save es **git-hunk-aware**: solo formatea las lineas modificadas en archivos bajo git.

---

## Neo-tree

- Items ocultos visibles por defecto (dotfiles, gitignored, hidden)
- Ventana lockeada: no se reutiliza para otros buffers
- Ancho: 35 columnas

## Snacks UI

- Notificaciones: estilo compacto, 3s timeout, abajo a la derecha
- Inputs: border rounded con backdrop
- Picker: border rounded, layout "select"
