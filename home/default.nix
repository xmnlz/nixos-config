{...}: {
  imports = [
    ./shell.nix
    ./languages.nix

    ./desktop/hyprland
    ./desktop/dms.nix
    ./desktop/qt.nix
    ./desktop/gtk.nix

    ./gui/zen.nix
    ./gui/chromium.nix

    ./gui/communication.nix
    ./gui/alacritty.nix
    ./gui/vicinae.nix
    ./gui/files.nix
    ./gui/gaming.nix
    ./gui/media.nix
    ./gui/notes.nix

    ./cli/git.nix
    ./cli/direnv.nix
    ./cli/fastfetch.nix
    ./cli/utils.nix

    ./tui/opencode.nix
    ./tui/lazygit.nix
    ./tui/btop.nix
    ./tui/tmux
    ./tui/neovim
  ];
}
