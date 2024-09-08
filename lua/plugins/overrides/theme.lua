---@type LazySpec
return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "astrotheme",
    },
  },
  {
    "AstroNvim/astrotheme",
    lazy = true,
    opts = {
      background = { dark = "astrodark" },
    },
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      style = "night",

      ---@param colors ColorScheme
      on_colors = function(colors)
        local util = require("tokyonight.util")

        -- Make comments slightly brighter, the original is a bit hard to read
        colors.comment = util.lighten(colors.comment, 0.55)
      end,

      ---@param highlights tokyonight.Highlights
      ---@param colors ColorScheme
      on_highlights = function(highlights, colors)
        local util = require("tokyonight.util")

        -- This is very similar to the regular "String" highlight, just slightly darker.
        -- I don't like the default here, which is an orange text.
        highlights["@string.documentation"] = { fg = util.darken(colors.green, 0.9) }

        -- I prefer magenta color for include statements
        highlights["Include"] = { fg = colors.magenta }

        -----------------------------------------------------------------
        -- The rest of these overrides completely change the color-scheme
        -- They focus on getting rid of the extreme overuse of blue.
        -----------------------------------------------------------------
        local custom_fg = "#adb0bb"
        local custom_white = "#c0caf5"
        local custom_gold = "#dfab25"
        local custom_orange = "#ef9062"
        local custom_yellow = "#dfab25"
        local custom_dark_blue = "#7aa2f7"
        local custom_light_blue = "#5eb7ff"
        local custom_red = "#ff838b"

        -- This is yellow by default, I prefer it orange
        highlights["@variable.parameter"] = { fg = custom_orange }

        -- I like builtin types in yellow
        highlights["@type.builtin"] = { fg = custom_yellow }

        -- Classes/Types in darker blue
        highlights["Type"] = { fg = custom_dark_blue }

        -- Functions in lighter blue
        highlights["Function"] = { fg = custom_light_blue }

        -- Constants in gold
        highlights["Constant"] = { fg = custom_gold }
        highlights["@constant.builtin"] = { fg = custom_gold }

        -- Some language syntax in gold
        highlights["PreProc"] = { fg = custom_gold }
        highlights["Typedef"] = { fg = custom_gold }
        highlights["@keyword.type"] = { fg = custom_gold }

        -- Use magenta for operators, I don't like the default bold cyan there
        highlights["@operator"] = { fg = colors.magenta }

        -- Numbers in orange
        highlights["Number"] = { fg = custom_orange }

        -- I want member variables to be considered as regular variables
        -- Don't use any special highlighting for them
        highlights["@variable"] = { fg = custom_fg }
        highlights["@variable.member"] = { fg = custom_white }
        highlights["@property"] = { fg = custom_red }
      end,
    },
  },
}
