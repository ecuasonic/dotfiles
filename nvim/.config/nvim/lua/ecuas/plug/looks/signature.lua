local cfg = {
    bind = true,
    doc_lines = 0,
    floating_window = true,
    floating_window_off_x = 0,
    floating_window_off_y = 0,
    hint_enable = false,                          -- virtual hint enable
    hint_inline = function() return false end,    -- should the hint be inline(nvim 0.10 only)?  default false
    hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
    handler_opts = {
        border = "rounded"                        -- double, rounded, single, shadow, none, or a table of borders
    },
    max_height = 3,
    max_width = 120,
    wrap = true,
    transparency = 0,
    hint_prefix = "> ",
    -- toggle_key = "m-l",
}

M = {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function()
        require 'lsp_signature'.setup(cfg)
        require 'lsp_signature'.on_attach(cfg)
    end
}

-- return {}
return M
