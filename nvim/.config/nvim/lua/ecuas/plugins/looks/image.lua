return {
    "3rd/image.nvim",
    config = function()
        -- default config
        require("image").setup({
            backend = "kitty",
            integrations = {
                markdown = {
                    enabled = true,
                    clear_in_insert_mode = false,
                    download_remote_images = true,
                    only_render_image_at_cursor = true,
                    filetypes = { "markdown" }, -- markdown extensions (ie. quarto) can go here
                    -- resolve_image_path = function(document_path, image_path, fallback)
                    --     return fallback(document_path, image_path)
                    -- end,
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
        })
    end
}
