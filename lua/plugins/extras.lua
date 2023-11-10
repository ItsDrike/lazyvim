return {
  -- Tree-like view of LSP symbols within a file
  { import = "lazyvim.plugins.extras.editor.symbols-outline" },

  -- Show LSP symbol navigation in lualine
  -- { import = "lazyvim.plugins.extras.editor.navic" },

  -- Formatters
  { import = "lazyvim.plugins.extras.formatting.black" }, -- black formatter
  { import = "lazyvim.plugins.extras.formatting.prettier" }, -- prettier formatter

  -- Language configs
  { import = "lazyvim.plugins.extras.lang.clangd" }, -- clangd LSP via clangd_extensions
  { import = "lazyvim.plugins.extras.lang.cmake" }, -- neocmake LSP, cmakelint, cmake-tools.nvim
  { import = "lazyvim.plugins.extras.lang.docker" }, -- dockerls & docker_compose_language_service LSPs, hadolint linter
  { import = "lazyvim.plugins.extras.lang.java" }, -- jtdls LSP via nvim-jdtls plugin
  { import = "lazyvim.plugins.extras.lang.json" }, -- jsonls LSP and schemastore packages
  { import = "lazyvim.plugins.extras.lang.markdown" }, -- marksman LSP, markdownlint linter, markdown-preview.nvim, and Headlines.nvim
  { import = "lazyvim.plugins.extras.lang.python" }, -- pyright & ruff_lsp LSPs, venv_selector.nvim
  { import = "lazyvim.plugins.extras.lang.rust" }, -- rust_analyzer & taplo LSPs, crates.nvim, rust-tools.nvim
  { import = "lazyvim.plugins.extras.lang.typescript" }, -- tsserver LSP
  { import = "lazyvim.plugins.extras.lang.yaml" }, -- yamlls LSP and schemastore packages

  -- Testing
  { import = "lazyvim.plugins.extras.test.core" },

  -- UI
  -- { import = "lazyvim.plugins.extras.ui.edgy" }, -- Manage Window layouts

  -- Util
  { import = "lazyvim.plugins.extras.util.dot" }, -- Treesitter support for common dotfiles
  { import = "lazyvim.plugins.extras.util.project" }, -- Project management with project.nvim
}
