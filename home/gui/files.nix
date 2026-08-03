{
  lib,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    nautilus

    file-roller # create and extract archives
    ffmpegthumbnailer # video thumbnails
    gnome-epub-thumbnailer
  ];

  dconf.settings = {
    "org/gnome/nautilus/preferences" = {
      default-folder-viewer = "list-view";
      default-sort-order = "name";
      show-image-thumbnails = "always";

      # Upstream stops generating previews past 10MB, which quietly skips most
      # video and camera raw files. This is 4GB, in bytes
      thumbnail-limit = lib.hm.gvariant.mkUint64 4294967296;

      show-delete-permanently = false;

      date-time-format = "simple";
    };

    "org/gnome/nautilus/list-view" = {
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
  };
}
