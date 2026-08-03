{
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    nautilus

    # Nautilus shells out to these rather than linking them, so they only work
    # if they are on PATH
    file-roller # create and extract archives
    ffmpegthumbnailer # video thumbnails
    gnome-epub-thumbnailer

    nautilus-python
    nautilus-open-any-terminal
  ];

  # Nautilus reads exactly one native extension directory, and nautilus-python
  # is the shim that then loads every Python extension it finds on XDG_DATA_DIRS.
  # Miss this and open-any-terminal never shows up, with nothing logged
  home.sessionVariables.NAUTILUS_4_EXTENSION_DIR = "${pkgs.nautilus-python}/lib/nautilus/extensions-4";

  dconf.settings = {
    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "list-view";
      default-sort-order = "name";
      show-image-thumbnails = "always";

      # Upstream stops generating previews past 10MB, which quietly skips most
      # video and camera raw files. This is 4GB, in bytes
      thumbnail-limit = lib.hm.gvariant.mkUint64 4294967296;

      # Finder has no permanent delete in the context menu either. Everything
      # goes through the trash, which is the whole point of fixing gvfs
      show-delete-permanently = false;

      date-time-format = "simple";
    };

    "org/gnome/nautilus/list-view" = {
      # Twisty arrows that expand a folder in place instead of navigating into
      # it, the closest thing Nautilus has to Finder's list view
      use-tree-view = true;
      default-zoom-level = "small";
      default-visible-columns = ["name" "size" "type" "date_modified"];
    };

    "org/gnome/nautilus/compression".default-compression-format = "zip";

    # Nautilus 50 dropped its own copy of this setting and now reads the GTK
    # one, see the migrated-gtk-settings key in its schema
    "org/gtk/gtk4/settings/file-chooser" = {
      sort-directories-first = true;
      show-hidden = false;
    };

    "com/github/stunkymonkey/nautilus-open-any-terminal" = {
      terminal = "alacritty";
      new-tab = false;
    };
  };
}
