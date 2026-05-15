return {
  enabled = true,
  doc = {
    float = false,   -- show image on cursor hover
    inline = false, -- show image inline
    max_width = 50,
    max_height = 30,
    stay_on_hover = true,
    timeout = 500,
    wo = {
      wrap = false,
      cursorline = true
    },
  },
  convert = {
    notify = true,
    command = "magick",
    max_size = {width = 1920, height = 1080},
    timeout = 3000
  },
  formats = {"png", "jpg", "jpeg", "gif", "webp"},
  img_dirs = {
    -- "img",
    -- "images",
    -- "assets",
    -- "static",
    -- "public",
    -- "media",
    -- "attachments",
    -- "Archives/All-Vault-Images/",
    "images"
  },
  cache = vim.fn.stdpath('cache') .. "/sanaks-image",
  math = {
    enabled = false
  }
}
