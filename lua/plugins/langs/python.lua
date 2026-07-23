-- Python is configured via the Python lang extra, this just overrides
-- certain settings

---@type LazySpec
return {
  {
    "linux-cultist/venv-selector.nvim",
    opts = {
      settings = {
        search = {
          rye = {
            command = "rye toolchain list --format json | jq -r '.[].path'",
          },
        },
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.servers.ty = opts.servers.ty or {}
      opts.servers.ty.root_dir = function(bufnr, on_dir)
        local fname = vim.api.nvim_buf_get_name(bufnr)
        local ok, neoconf = pcall(require, "neoconf")
        if ok and neoconf.get("lspconfig.ty", nil, { file = fname, ["local"] = true, global = false }) == false then
          return
        end

        on_dir(vim.fs.root(bufnr, { "ty.toml", "pyproject.toml", "setup.py", "setup.cfg", "requirements.txt", ".git" }))
      end
    end,
  },
  -- For some reason, the python language pack in LazyVim doesn't add debugpy to mason
  {
    "mfussenegger/nvim-dap-python",
    optional = true,
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = { ensure_installed = { "debugpy" } },
      },
    },
  },
}
