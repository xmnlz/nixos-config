{ ... }: 

{
  programs.quickshell = {
    enable = true;
    #   systemd.enable = true;
  };

  xdg.configFile."quickshell/shell.qml".source = ./qml/shell.qml;
}
