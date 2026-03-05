{ ... }: 

{
  qt = {
    enable = true;
    # TODO: Fix this later 
    platformTheme = {
      name = "gtk";
    };

    style = {
      name = "adwaita-dark";
    };
  };

  programs.quickshell = {
    enable = true;
    #   systemd.enable = true;
  };

  xdg.configFile."quickshell/shell.qml".source = ./qml/shell.qml;
}
