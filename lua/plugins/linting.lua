return {
  {
    "nvim-lint",
    dependencies = {
      "mason.nvim",
      optional = true,
      opts = function(_, opts)
        if opts.ensure_installed == nil then
          opts.ensure_installed = {}
        end

        vim.list_extend(opts.ensure_installed, {
          "ruff",
          "gitlint",
          "luacheck",
          "yamllint",
          "shellcheck",
        })
      end,
    },
    opts = function(_, opts)
      --- Extend the conform plugin config and add given formatters
      ---@param tbl table<string, string[] | string[][]> Table of filetype to formatters mappings
      local function add_linters(tbl)
        for ft, formatters in pairs(tbl) do
          if opts.linters_by_ft[ft] == nil then
            opts.linters_by_ft[ft] = formatters
          else
            vim.list_extend(opts.linters_by_ft[ft], formatters)
          end
        end
      end

      add_linters({
        python = { "ruff" },
        gitcommit = { "gitlint" },
        lua = { "luacheck" },
        yaml = { "yamllint" },
        sh = { "shellcheck" },
        bash = { "shellcheck" },
        zsh = { "shellcheck" },
      })
    end,
  },
}
