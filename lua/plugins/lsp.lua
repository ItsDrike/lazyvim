return {

  {
    "mason.nvim",
    opts = function(_, opts)
      local mason_lsps = {}

      if opts.ensure_installed == nil then
        opts.ensure_installed = {}
      end

      for _, value in ipairs(mason_lsps) do
        table.insert(opts.ensure_installed, value)
      end
    end,
  },
}
