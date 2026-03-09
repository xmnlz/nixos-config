{ config, pkgs, ... }:
{
  # TODO: Add plugins as hm modules/pkgs 
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;
  };

  xdg.configFile."nvim".source = ./nvim;
}
