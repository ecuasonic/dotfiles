-- extension: telescope
local function get_display_name()
  return "Telescope"
end

-- custom extension
local telescope = {
  sections = {
    lualine_a = {
      { get_display_name },
    },
  },
  filetypes = { "TelescopePrompt" },
}

-- export
return telescope
