{pkgs, ...}: {
  gtk = {
    enable = true;
    colorScheme = "dark";

    iconTheme = {
      name = "WhiteSur-dark";
      package = pkgs.whitesur-icon-theme;
    };

    theme = {
      name = "adw-gtk3-dark";
      package = pkgs.adw-gtk3;
    };

    font = {
      name = "Inter";
      size = 11;
    };
  };

  dconf.settings."org/gnome/desktop/interface" = {
    color-scheme = "prefer-dark";

    accent-color = "blue";

    font-name = "Inter 11";
    document-font-name = "Inter 11";
    monospace-font-name = "JetBrainsMono Nerd Font Mono 11";
  };
}
