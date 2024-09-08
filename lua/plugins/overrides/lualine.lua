---@type LazySpec
return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- Remove the 1st item in lualine_x section: showing the last command
      table.remove(opts.sections.lualine_x, 1)
      -- Remove the 2nd item in lualine_x section: copilot status
      table.remove(opts.sections.lualine_x, 1)
      -- Remove the 5th item in lualine_x section: showing amount of pkg updates
      table.remove(opts.sections.lualine_x, 3)

      -- Show active language servers, formatters and linters
      table.insert(opts.sections.lualine_x, 1, {
        function()
          local entries = {}
          local bufnr = vim.api.nvim_get_current_buf()

          -- Get all active LSP clients
          local lsp_clients = vim.lsp.get_clients({ bufnr = bufnr })
          local lsp_client_names = {}
          for _, client in ipairs(lsp_clients) do
            table.insert(lsp_client_names, client.name)
          end
          table.move(lsp_client_names, 1, #lsp_client_names, #entries + 1, entries)

          -- Get all active fromatters
          local conform_ok, conform = pcall(require, "conform")
          if conform_ok then
            local formatters = conform.list_formatters(bufnr)
            local formatter_names = {}
            for _, formatter in ipairs(formatters) do
              if formatter.available then
                table.insert(formatter_names, formatter.name)
              end
            end
            table.move(formatter_names, 1, #formatter_names, #entries + 1, entries)
          end

          -- Get all active linters
          local nvim_lint_ok, nvim_lint = pcall(require, "lint")
          if nvim_lint_ok then
            local linters = nvim_lint.linters_by_ft[vim.bo.filetype]
            if linters ~= nil then
              table.move(linters, 1, #linters, #entries + 1, entries)
            end
          end

          -- Remove any duplicates (sometimes, we use the same formatter and linter)
          local i = 1
          local seen = {}
          while i <= #entries do
            if seen[entries[i]] then
              table.remove(entries, i)
            else
              seen[entries[i]] = true
              i = i + 1
            end
          end

          if #entries == 0 then
            return "󰦕"
          end
          return "󱉶 " .. table.concat(entries, ", ")
        end,
        cond = function()
          return true
        end,
        color = function()
          return LazyVim.ui.fg("Statement")
        end,
      })
      return opts
    end,
  },
}
