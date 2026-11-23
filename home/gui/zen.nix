{
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.zen-browser.homeModules.beta
  ];

  programs.zen-browser = {
    enable = true;
    setAsDefaultBrowser = true;

    # With no download dir set, Zen's save dialog starts in ~/Downloads instead of the XDG one.
    policies = {
      DefaultDownloadDirectory = config.xdg.userDirs.download;
      Preferences."browser.download.lastDir" = {
        Value = config.xdg.userDirs.download;
        Status = "user";
      };
    };
  };
}
