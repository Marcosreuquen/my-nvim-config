return {
  {
    "kevinhwang91/nvim-ufo",
    dependencies = { "kevinhwang91/promise-async" },
    event = "BufReadPost",
    opts = {
      provider_selector = function(_, filetype, _)
        local lsp_types = { "typescript", "javascript", "typescriptreact", "javascriptreact", "python", "rust", "go" }
        if vim.tbl_contains(lsp_types, filetype) then
          return { "lsp", "treesitter" }
        end
        return { "treesitter", "indent" }
      end,
    },
    keys = {
      { "zR", function() require("ufo").openAllFolds() end, desc = "Open all folds" },
      { "zM", function() require("ufo").closeAllFolds() end, desc = "Close all folds" },
      { "zr", function() require("ufo").openFoldsExceptKinds() end, desc = "Open folds except kinds" },
    },
  },
}
