{...}: {
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      background = "#181818";
      background-opacity = 0.95;
      window-padding-x = 4;
      window-padding-y = 4;
      window-padding-balance = true;
      window-inherit-working-directory = false;
      tab-inherit-working-directory = false;
      split-inherit-working-directory = false;
    };
  };
}
