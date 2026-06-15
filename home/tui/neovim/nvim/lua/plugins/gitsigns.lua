local gitsigns = require('gitsigns')

gitsigns.setup {
  on_attach = function(bufnr)
    local function map(mode, lhs, rhs)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr })
    end

    map('n', '<leader>bb', gitsigns.blame)
    map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
  end,
}

local function detect_provider(remote)
  if remote:match("github.com") then
    return "github"
  elseif remote:match("gitlab.com") then
    return "gitlab"
  elseif remote:match("bitbucket.org") then
    return "bitbucket"
  else
    return "unknown"
  end
end

local function extract_repo(remote)
  return remote
      :gsub("git@github.com:", "")
      :gsub("git@gitlab.com:", "")
      :gsub("git@bitbucket.org:", "")
      :gsub("https://github.com/", "")
      :gsub("https://gitlab.com/", "")
      :gsub("https://bitbucket.org/", "")
      :gsub("%.git$", "")
end

local function open_universal_change()
  local blame = gitsigns.get_current_line_blame()
  if not blame then return end

  local sha = blame:match("^%x+")
  if not sha then return end

  local remote = vim.fn.system("git remote get-url origin"):gsub("\n", "")
  local provider = detect_provider(remote)
  local repo = extract_repo(remote)

  local url

  if provider == "github" then
    url = "https://github.com/" .. repo .. "/commit/" .. sha
  elseif provider == "gitlab" then
    url = "https://gitlab.com/" .. repo .. "/-/commit/" .. sha
  elseif provider == "bitbucket" then
    url = "https://bitbucket.org/" .. repo .. "/commits/" .. sha
  else
    print("Unsupported git host: " .. remote)
    return
  end

  vim.fn.system({ "xdg-open", url })
end

vim.keymap.set('n', '<leader>go', open_universal_change)
