return {
  cmd = { 'vscode-html-language-server', '--stdio' },
  root_markers = {
    'package.json',
    '.git'
  },
  filetypes = { 'html' },
  init_options = {
    configurationSection = { 'html', 'css', 'javascript' },
    embeddedLanguages = {
      css = true,
      javascript = true,
    },
    provideFormatter = true,
  },
}
