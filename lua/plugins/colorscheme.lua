
return {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    config = function()
        vim.g.gruvbox_contrast_dark = 'hard'  -- contrast "hard"
        vim.cmd([[colorscheme gruvbox]])        -- Aplicate scheme gruvbox
    end,
}

