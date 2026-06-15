local gitsigns = require('gitsigns')

local function parse_remote(remote)
  -- SSH format: git@github.com:owner/repo.git
  local host, path = remote:match("git@([^:]+):(.+)")

  -- HTTPS format: https://github.com/owner/repo.git
  if not host then
    host, path = remote:match("https?://([^/]+)/(.+)")
  end

  if not host or not path then
    return nil, nil
  end

  path = path:gsub("%.git$", "")

  return host, path
end

local function open_commit()
  local blame = gitsigns.get_current_line_blame()
  if not blame then return end

  local sha = blame:match("^%x+")
  if not sha then return end

  local remote = vim.fn.system("git remote get-url origin"):gsub("\n", "")
  local host, repo = parse_remote(remote)

  if not host or not repo then
    print("Could not parse git remote: " .. remote)
    return
  end

  local url = "https://" .. host .. "/" .. repo .. "/commit/" .. sha

  vim.fn.system({ "xdg-open", url })
end

gitsigns.setup {
  on_attach = function(bufnr)
    local function map(mode, lhs, rhs)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr })
    end

    map('n', '<leader>bb', gitsigns.blame)
    map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
    map('n', '<leader>go', open_commit)
  end,
}
