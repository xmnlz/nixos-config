{ ... }: 

{
  qt = {
    enable = true;
    # TODO: Fix this later 
    platformTheme = "gnome";

    style = {
      name = "adwaita-dark";
    };
  };

  programs.quickshell = {
    enable = true;
    #   systemd.enable = true;
  };

  xdg.configFile."quickshell/shell.qml".source = ./shell.qml;
}
