return {
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    config = function()
      require("rose-pine").setup({
        variant = "moon",
        dark_variant = "moon",
        disable_float_background = false,
        styles = {
          italic = true,
          bold = true,
          transparency = true,
        },
      })
   end,
  },
}
