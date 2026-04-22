return {
  {
    "ramilito/kubectl.nvim",
    version = "2.*",
    dependencies = "saghen/blink.download",
    config = function()
      local kubeconfig = vim.env.KUBECONFIG
      require("kubectl").setup({
        kubectl_cmd = {
          cmd = "kubectl",
          args = kubeconfig and { "--kubeconfig", kubeconfig } or {},
        },
      })
      vim.keymap.set(
        "n",
        "<leader>k",
        '<cmd>lua require("kubectl").toggle({ tab = false })<cr>',
        { noremap = true, silent = true, desc = "Toggle Kubernetes" }
      )
    end,
  },
}
