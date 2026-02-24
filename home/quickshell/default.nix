{ ... }: 

{
  qt = {
    enable = true;
    # platformTheme = "gtk";
  };

  programs.quickshell = {
    enable = true;
  #   systemd.enable = true;
  };

  xdg.configFile."quickshell/shell.qml".source = ./shell.qml;
}
