{ pkgs, kdePackages, ... }:

{
  home.packages = with pkgs; [
    # languages
    bun
    zig

    # LSP 
    nil
    gopls
    tinymist
    lua-language-server
    pkgs.kdePackages.qtdeclarative
    typescript-language-server
    tailwindcss-language-server
    svelte-language-server
    docker-language-server
    vscode-langservers-extracted
    pyright
    zls
  ];

  programs.fish = {
    enable = true;

    functions.fish_prompt = ''
      set -l last_status $status

      set -l dir_color (set_color cyan)
      set -l git_color (set_color magenta)
      set -l error_color (set_color red)
      set -l normal (set_color normal)

      set -l cwd (prompt_pwd)

      set -l git_branch
      if command git rev-parse --is-inside-work-tree >/dev/null 2>&1
          set git_branch (command git branch --show-current 2>/dev/null)
      end

      set -l stat
      if test $last_status -ne 0
          set stat "$error_color[$last_status]$normal "
      end

      printf "%s%s%s%s ❯ " \
        "$stat" \
        "$dir_color$cwd$normal" \
        (test -n "$git_branch"; and printf " $git_color%s$normal" "$git_branch") \
        ""
    '';
  };

  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "xmnlz";
        email = "lemmeq9@gmail.com";
      };
      core.editor = "nvim";
      init.defaultBranch = "main";
      credential.helper = "!gh auth git-credential";
    };
  };
}
