{...}: {
  programs.herdr = {
    enable = true;
    mutableSettings = true;
    settings.keys.prefix = "ctrl+space";
  };
}
