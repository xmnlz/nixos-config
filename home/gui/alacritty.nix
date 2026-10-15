{...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        opacity = 0.95;
        dynamic_padding = true;
        padding = {
          x = 4;
          y = 4;
        };
      };

      # Setting this list replaces Alacritty's default URL hint, so it is repeated here.
      hints.enabled = [
        {
          regex = "(?:[A-Za-z0-9_.~@+-]|\\([A-Za-z0-9_.-]+\\)|\\[[A-Za-z0-9_.-]+\\]|/)+\\.[A-Za-z0-9]+:[0-9]+";
          command = {
            program = "sh";
            args = ["-c" "f=\"\${1%:*}\"; case $f in \"~/\"*) f=\"$HOME/\${f#\\~/}\";; esac; exec alacritty -e nvim \"+\${1##*:}\" \"$f\"" "_"];
          };
          mouse.enabled = true;
          binding = {
            key = "E";
            mods = "Control|Shift";
          };
        }
        {
          regex = "(ipfs:|ipns:|magnet:|mailto:|gemini://|gopher://|https://|http://|news:|file:|git://|ssh:|ftp://)[^\\u0000-\\u001F\\u007F-\\u009F<>\"\\s{-}\\^⟨⟩`\\\\]+";
          hyperlinks = true;
          post_processing = true;
          persist = false;
          command = "xdg-open";
          mouse.enabled = true;
          binding = {
            key = "O";
            mods = "Control|Shift";
          };
        }
      ];
    };
  };
}
