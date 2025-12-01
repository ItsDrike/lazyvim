---@type LazySpec
return {
  {
    "mason-org/mason.nvim",
    opts = {
      registries = {
        "github:mason-org/mason-registry",
        -- roslyn & rzls (dotnet)
        "github:crashdummyy/mason-registry",
      },
    },
  },
}
