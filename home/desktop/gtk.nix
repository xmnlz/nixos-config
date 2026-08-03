{pkgs, ...}: {
  gtk = {
    enable = true;
    colorScheme = "dark";

    # hicolor is the bare freedesktop fallback and ships almost nothing, so
    # every app that asked for an icon it did not carry itself came up blank
    iconTheme = {
      name = "WhiteSur-dark";
      package = pkgs.whitesur-icon-theme;
    };

    # Only reaches GTK3 apps. Nautilus is GTK4 + libadwaita and ignores themes
    # by design, it picks up the accent colour below instead
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

    # This is the one knob libadwaita actually honours, so it is how Nautilus
    # gets coloured at all
    accent-color = "blue";

    font-name = "Inter 11";
    document-font-name = "Inter 11";
    monospace-font-name = "JetBrainsMono Nerd Font Mono 11";
  };
}
