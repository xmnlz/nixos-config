{ inputs, ... }:

{
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
    ./gui/wireshark.nix

    ./cli/git.nix
    ./cli/btop.nix
    ./cli/fastfetch.nix
    ./cli/utils.nix

    ./tui/opencode.nix
    ./tui/tmux
    ./tui/neovim
  ] ++ [
    inputs.vicinae.homeManagerModules.default
    inputs.dms.homeModules.dank-material-shell
    inputs.zen-browser.homeModules.beta
  ];
}
