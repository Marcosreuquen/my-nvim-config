# Keymaps Cheatsheet: NvChad -> AstroNvim

Guia rapida de las acciones mas comunes y como hacerlas en AstroNvim.
`<Leader>` = `Space`

## Navegacion de archivos

| Accion | Antes (NvChad) | Ahora (AstroNvim) |
|---|---|---|
| Toggle file explorer | `<C-n>` | `<Leader>e` |
| Focus file explorer | `<C-n>` | `<Leader>o` |
| Buscar archivos | `<Leader>ff` | `<Leader>ff` (igual) |
| Buscar archivos (ocultos) | -- | `<Leader>fF` |
| Buscar texto (live grep) | `<Leader>fw` | `<Leader>fw` (igual) |
| Archivos recientes | `<Leader>fo` | `<Leader>fo` (igual) |
| Buscar en buffers abiertos | `<Leader>fb` | `<Leader>fb` (igual) |
| Smart open (buffers+recent+files) | -- | `<Leader>fs` |

## Buffers (tabs)

| Accion | Antes (NvChad) | Ahora (AstroNvim) |
|---|---|---|
| Siguiente buffer | `<Tab>` | `]b` |
| Buffer anterior | `<S-Tab>` | `[b` |
| Cerrar buffer | `<Leader>x` | `<Leader>c` |
| Cerrar buffer (picker) | -- | `<Leader>bd` |
| Cerrar todos menos actual | -- | `<Leader>bc` |
| Cerrar todos | -- | `<Leader>bC` |
| Mover buffer a la derecha | -- | `>b` |
| Mover buffer a la izquierda | -- | `<b` |
| Ir a buffer por picker | -- | `<Leader>bb` |

## Vim Tabs (real tabs, no buffers)

| Accion | Antes (NvChad) | Ahora (AstroNvim) |
|---|---|---|
| Siguiente tab | -- | `]t` |
| Tab anterior | -- | `[t` |

## Ventanas / Splits

| Accion | Antes (NvChad) | Ahora (AstroNvim) |
|---|---|---|
| Split horizontal | -- | `\` |
| Split vertical | -- | `\|` |
| Mover a ventana arriba | `<C-k>` | `<C-k>` (igual) |
| Mover a ventana abajo | `<C-j>` | `<C-j>` (igual) |
| Mover a ventana izquierda | `<C-h>` | `<C-h>` (igual) |
| Mover a ventana derecha | `<C-l>` | `<C-l>` (igual) |
| Resize arriba | `<C-Up>` | `<C-Up>` (igual) |
| Resize abajo | `<C-Down>` | `<C-Down>` (igual) |

## LSP

| Accion | Antes (NvChad) | Ahora (AstroNvim) |
|---|---|---|
| Go to definition | `gd` | `gd` (igual) |
| Go to references | `gr` | `grr` o `<Leader>lR` |
| Go to implementation | `gi` | `gri` |
| Go to declaration | `gD` | `gD` (igual) |
| Go to type definition | -- | `gy` |
| Hover info | `K` | `K` (igual) |
| Code actions | `<Leader>ca` | `gra` o `<Leader>la` |
| Rename symbol | `<Leader>ra` | `grn` o `<Leader>lr` |
| Format documento | `:Format` | `<Leader>lf` o `:Format` |
| Signature help | automatico al tipear | automatico al tipear (igual) |
| Line diagnostics | -- | `gl` o `<Leader>ld` |
| Next diagnostic | `]d` | `]d` (igual) |
| Prev diagnostic | `[d` | `[d` (igual) |
| Next error | -- | `]e` |
| Prev error | -- | `[e` |
| Document symbols | -- | `<Leader>ls` |
| LSP Info | -- | `<Leader>li` |

## Autocompletado (nvim-cmp)

| Accion | Antes (NvChad) | Ahora (AstroNvim) |
|---|---|---|
| Abrir menu | `<C-Space>` | `<C-Space>` (igual) |
| Confirmar seleccion | `<CR>` | `<CR>` (igual) |
| Siguiente item | `<C-j>` o `<Tab>` | `<C-j>` o `<Tab>` (igual) |
| Item anterior | `<C-k>` o `<S-Tab>` | `<C-k>` o `<S-Tab>` (igual) |
| Scroll docs arriba | `<C-b>` | `<C-b>` (igual) |
| Scroll docs abajo | `<C-f>` | `<C-f>` (igual) |
| Cancelar | `<C-e>` | `<C-e>` (igual) |

## Terminal (ToggleTerm custom)

| Accion | Antes (NvChad) | Ahora (AstroNvim) |
|---|---|---|
| Toggle terminal | `<C-t>` | `<C-t>` (igual) |
| Nueva terminal tab | `<A-t>` | `<A-t>` (igual) |
| Cerrar terminal tab | `<A-w>` | `<A-w>` (igual) |
| Siguiente terminal | `<A-l>` | `<A-l>` (igual) |
| Terminal anterior | `<A-h>` | `<A-h>` (igual) |
| Salir de terminal mode | `<C-q>` | `<C-q>` (igual) |
| Resize terminal + | `<C-=>` | `<C-=>` (igual) |
| Resize terminal - | `<C-->` | `<C-->` (igual) |
| Float terminal (AstroNvim) | -- | `<Leader>tf` |
| Horizontal terminal (AstroNvim) | -- | `<Leader>th` |
| Vertical terminal (AstroNvim) | -- | `<Leader>tv` |
| Lazygit | -- | `<Leader>tl` |

## Copilot

| Accion | Antes (NvChad) | Ahora (AstroNvim) |
|---|---|---|
| Aceptar sugerencia | `<Tab>` | `<Tab>` (igual) |
| Aceptar linea | `<S-Tab>` | `<S-Tab>` (igual) |
| Descartar | `<A-Tab>` | `<A-Tab>` (igual) |

## OpenCode AI

| Accion | Antes (NvChad) | Ahora (AstroNvim) |
|---|---|---|
| Ask AI (temp) | `<C-a>` | `<C-a>` (igual) |
| Execute action | `<C-x>` | `<C-x>` (igual) |
| Toggle opencode | `<C-.>` | `<C-.>` (igual) |
| Add to context | `go` | `go` (igual) |
| Add line to context | `goo` | `goo` (igual) |
| Scroll up | `<S-C-u>` | `<S-C-u>` (igual) |
| Scroll down | `<S-C-d>` | `<S-C-d>` (igual) |
| Session picker | `<C-b>` | `<C-b>` (igual) |

## TODO Comments

| Accion | Antes (NvChad) | Ahora (AstroNvim) |
|---|---|---|
| Siguiente TODO | `]t` | `]T` (cambio: `]t` es vim tabs) |
| TODO anterior | `[t` | `[T` (cambio: `[t` es vim tabs) |
| Buscar TODOs | `<Leader>st` | `<Leader>st` (igual) |

## Comentarios

| Accion | Antes (NvChad) | Ahora (AstroNvim) |
|---|---|---|
| Toggle comment linea | `<Leader>/` | `<Leader>/` (igual) |
| Insertar comment abajo | -- | `gco` |
| Insertar comment arriba | -- | `gcO` |

## General

| Accion | Antes (NvChad) | Ahora (AstroNvim) |
|---|---|---|
| Enter command mode | `;` | `;` (igual) |
| Exit insert mode | `jk` | `jk` (igual, AstroNvim tambien tiene `jj`) |
| Undo | `<C-z>` | `<C-z>` (igual) |
| Guardar | `<C-s>` | `<C-s>` (igual) |
| Quit | `<C-q>` (en normal) | `<C-q>` (igual) |
| Nuevo archivo | -- | `<Leader>n` |
| Renombrar archivo | -- | `<Leader>R` |
| Which-key help | `<Leader>` (esperar) | `<Leader>` (esperar, igual) |

## Pickers (Telescope/Snacks) - Nuevos en AstroNvim

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

## Toggles UI (nuevos en AstroNvim)

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

## Package Management

| Accion | Keymap |
|---|---|
| Lazy (plugins) | `<Leader>pi` |
| Mason (tools) | `<Leader>pm` |
| Update all | `<Leader>pa` |

## Sessions (AstroNvim built-in)

| Accion | Keymap |
|---|---|
| Save session | `<Leader>Ss` |
| Last session | `<Leader>Sl` |
| Search sessions | `<Leader>Sf` |
| Load current dir session | `<Leader>S.` |
| Delete session | `<Leader>Sd` |

---

> **Tip**: Presiona `<Space>` y espera un segundo para ver el menu completo de which-key con todas las opciones agrupadas.
