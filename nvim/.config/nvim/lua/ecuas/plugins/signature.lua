local cfg = {
    bind = true, -- This is mandatory, otherwise border config won't get registered.
    -- If you want to hook lspsaga or other signature handler, pls set to false
    doc_lines = 10, -- will show two lines of comment/doc(if there are more than two lines in doc, will be truncated);
    floating_window = true, -- show hint in a floating window, set to false for virtual text only mode
    floating_window_off_x = 0,
    floating_window_off_y = 0,
    hint_enable = false, -- virtual hint enable
    hint_inline = function() return false end,  -- should the hint be inline(nvim 0.10 only)?  default false
    hi_parameter = "LspSignatureActiveParameter", -- how your parameter will be highlight
    handler_opts = {
        border = "single"   -- double, rounded, single, shadow, none, or a table of borders
    },
    max_height = 3,
    transparency = 0,
    -- toggle_key = "m-l",
}

return {
    "ray-x/lsp_signature.nvim",
    event = "VeryLazy",
    opts = {},
    config = function() require'lsp_signature'.setup(cfg) end
}
