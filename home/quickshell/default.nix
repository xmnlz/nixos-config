{ ... }: 

{
  programs.quickshell = {
    enable = true;
  #   systemd.enable = true;
  };

  xdg.configFile."quickshell/shell.qml" = ./shell.qml;
}
