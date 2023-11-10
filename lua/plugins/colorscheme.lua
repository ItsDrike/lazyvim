return {
  {
    "tokyonight.nvim",
    enable = false,
  },

  {
    "AstroNvim/astrotheme",
    opts = {
      palette = "astrodark",

      style = {
        inactive = true, -- Use different bg for inactive windows
        transparent = false, -- Transparent background
        floating = true, -- Background for floating windows
        popup = true, -- Background for popups
        neotree = true, -- Background for neo-tree
        italic_comments = true, -- Make comments italic
      },

      palettes = {
        astrodark = {
          syntax = {
            -- Default colors:
            -- red = "#FE8A90"
            -- blue = "#63B7FC"
            -- green = "#89BF63"
            -- yellow = "#E1AA41"
            -- purple = "#DB98EE"
            -- cyan = "#1BC5B9"
            -- orange = "#FE915E"
            -- text = "#ADB0BB"
            -- comment = "#696C76"
            -- mute = "#595C66"

            red = "#ff7a80",
          },
          -- Some additional syntax colors used in custom overrides as the colorschem
          -- only contains a pretty small amount of distinct syntax colors
          syntax_custom = {
            light_blue = "#9cdcfe",
            dark_blue = "#569cd6",
            brown = "#ce9178",
            pale = "#dcdcaa",
          },
        },
      },

      highlights = {
        astrodark = { -- Add or modify hl groups globaly, theme specific hl groups take priority.
          modify_hl_groups = function(hl, c)
            -- LSP Semantic token highlights for robot=framework
            -- (Comments hold the official recommended color)
            hl["@lsp.type.variable.robot"] = { fg = c.syntax_custom.light_blue } -- #9cdcfe
            hl["@lsp.type.comment.robot"] = { fg = c.syntax.comment } -- #6a9955
            hl["@lsp.type.header.robot"] = { fg = c.syntax.cyan } -- #4ec9b0
            hl["@lsp.type.setting.robot"] = { fg = c.syntax.purple } -- #c177da
            hl["@lsp.type.name.robot"] = { fg = c.syntax.yellow } -- #e1bd78
            hl["@lsp.type.variableOperator.robot"] = { fg = c.syntax.text } -- #d4d4d4
            hl["@lsp.type.settingsOperator.robot"] = { fg = c.syntax.text } -- #d4d4d4
            hl["@lsp.type.keywordNameDefinition.robot"] = { fg = c.syntax_custom.pale } -- #dcdcaa
            hl["@lsp.type.keywordNameCall.robot"] = { fg = c.syntax_custom.dark_blue } -- #569cd6
            hl["@lsp.type.control.robot"] = { fg = c.syntax.purple } -- #c586c0
            hl["@lsp.type.testCaseName.robot"] = { fg = c.syntax_custom.pale } -- #dcdcaa
            hl["@lsp.type.parameterName.robot"] = { fg = c.syntax_custom.light_blue } -- #9cdcfe
            hl["@lsp.type.argumentValue.robot"] = { fg = c.syntax_custom.brown } -- #ce9178
            hl["@lsp.type.error.robot"] = { fg = c.syntax.red } -- #f44747
            hl["@lsp.type.documentation.robot"] = { fg = c.syntax.green } -- #6a9955
            -- Other
            hl["Whitespace"] = { fg = c.syntax_custom.pale }
          end,
        },
      },
    },
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "astrodark",
    },
  },
}
