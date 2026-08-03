{...}: {
  # Nautilus reaches the trash, removable drives and network shares through
  # gvfs. Without it there is no trash at all, deleting is a straight unlink and
  # trash:// answers "Operation not supported", which is what was happening here
  services.gvfs.enable = true;

  # Spacebar preview, the Quick Look equivalent. It registers a D-Bus service,
  # so it has to be switched on at this level, adding the package to
  # home.packages is not enough to make it appear
  services.gnome.sushi.enable = true;
}
