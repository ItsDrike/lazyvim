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
  -- For some reason, the python language pack in LazyVim doesn't add debugpy to mason
  {
    "mfussenegger/nvim-dap-python",
    optional = true,
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = { ensure_installed = { "debugpy" } },
      },
    },
  },
}
