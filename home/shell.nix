{ ... }:

{
  home.shellAliases = {
    nrs = "sudo nixos-rebuild switch --flake ~/nixos-config";
    nrb = "sudo nixos-rebuild boot --flake ~/nixos-config";
    nrt = "sudo nixos-rebuild test --flake ~/nixos-config";
  };

  programs.fish = {
    enable = true;

    shellInit = ''
      set fish_greeting
    '';

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
}
