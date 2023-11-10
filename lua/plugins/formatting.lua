return {
  {
    "conform.nvim",
    dependencies = {
      "mason.nvim",
      optional = true,
      opts = function(_, opts)
        if opts.ensure_installed == nil then
          opts.ensure_installed = {}
        end

        vim.list_extend(opts.ensure_installed, {
          "stylua",
          "shfmt",
          "black",
          "isort",
          "ruff",
          "clang-format",
          "rustfmt",
          "prettier",
        })
      end,
    },
    opts = function(_, opts)
      --@class ConformOpts
      opts = opts

      --- Extend the conform plugin config and add given formatters
      ---@param tbl table<string, string[] | string[][]> Table of filetype to formatters mappings
      local function add_formatters(tbl)
        for ft, formatters in pairs(tbl) do
          if opts.formatters_by_ft[ft] == nil then
            opts.formatters_by_ft[ft] = formatters
          else
            vim.list_extend(opts.formatters_by_ft[ft], formatters)
          end
        end
      end

      add_formatters({
        ["lua"] = { "stylua" },
        ["sh"] = { "shfmt" },
        ["python"] = { "isort", "black" },
        ["c"] = { "clang_format" },
        ["cpp"] = { "clang_format" },
        ["rust"] = { "rustfmt" },
        ["javascript"] = { "prettier" },
        ["javascriptreact"] = { "prettier" },
        ["typescript"] = { "prettier" },
        ["typescriptreact"] = { "prettier" },
        ["vue"] = { "prettier" },
        ["css"] = { "prettier" },
        ["scss"] = { "prettier" },
        ["less"] = { "prettier" },
        ["html"] = { "prettier" },
        ["json"] = { "prettier" },
        ["jsonc"] = { "prettier" },
        ["yaml"] = { "prettier" },
        ["markdown"] = { "prettier" },
        ["markdown.mdx"] = { "prettier" },
        ["graphql"] = { "prettier" },
        ["handlebars"] = { "prettier" },
      })
    end,
  },
}
