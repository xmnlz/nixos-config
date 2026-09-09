return {
  cmd = { 'tsc', '--lsp', '--stdio' },
  filetypes = {
    'typescript', 'typescriptreact', 'typescript.tsx',
    'javascript', 'javascriptreact', 'javascript.jsx',
  },
  root_markers = { 'tsconfig.json', 'package.json', '.git' },
}
