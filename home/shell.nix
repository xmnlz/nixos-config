{...}: {
  home.shellAliases = {
    nrs = "nh os switch";
    nrb = "nh os build";
    nrt = "nh os test";
    nru = "nh os switch -u --commit-lock-file";

    tm = "tmux new -A -s \"$(basename $PWD)\"";
    zj = "zellij attach -c \"$(basename $PWD)\"";
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

    functions.fish_title = ''
      set -l command (status current-command)
      if set -q argv[1]
          set command (string split -f1 ' ' -- $argv[1])
      end

      if test "$command" != fish
          echo $command
      else if test "$PWD" = "$HOME"
          echo '~'
      else
          path basename $PWD
      end
    '';
  };
}
