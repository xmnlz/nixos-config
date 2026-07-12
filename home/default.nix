{...}: {
  imports = [
    ./xdg.nix

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
    ./gui/helium.nix
    ./gui/xdiscord.nix
    ./gui/pgadmin.nix

    ./cli/git.nix
    ./cli/direnv.nix
    ./cli/fastfetch.nix
    ./cli/utils.nix
    ./cli/bitwarden.nix

    ./tui/opencode.nix
    ./tui/claude.nix
    ./tui/lazygit.nix
    ./tui/btop.nix
    ./tui/tmux
    ./tui/neovim
  ];
}
