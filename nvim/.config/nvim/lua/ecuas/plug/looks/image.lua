M = {
    "3rd/image.nvim",
    ft = "markdown",
    opts = {
        backend = "kitty",
        integrations = {
            markdown = {
                enabled = true,
                clear_in_insert_mode = false,
                download_remote_images = true,
                only_render_image_at_cursor = true,
                only_render_image_at_cursor_mode = "inline",
                floating_windows = false,
                filetypes = { "markdown" },
            },
        },
        kitty_method = "normal",

        max_width = nil,
        max_height = nil,
        max_width_window_percentage = 90,
        max_height_window_percentage = 50,
        -- toggles images when windows are overlapped
        window_overlap_clear_enabled = true,
        window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
        -- auto show/hide images when the editor gains/looses focus
        editor_only_render_when_focused = true,
        -- auto show/hide images in the correct Tmux window (needs visual-activity off)
        tmux_show_only_in_active_window = false,
        -- render image files as images when opened
        hijack_file_patterns = {
            "*.png",
            "*.jpg",
            "*.jpeg",
            "*.gif",
            "*.webp",
            "*.avif"
        },
    },
}

-- return {}
return M
