return {
  enabled = true,
  doc = {
    float = true, -- show image on cursor hover
    inline = false, -- show image inline
    max_width = 50,
    max_height = 30,
    stay_on_hover = true,
    wo = {
      wrap = false,
    },
  },
  convert = {
    notify = true,
    command = "magick"
  },
  img_dirs = {
    "img",
    "images",
    "assets",
    "static",
    "public",
    "media",
    "attachments",
    "Archives/All-Vault-Images/",
    "~/Library",
    "~/Descargas/"
  },
}
