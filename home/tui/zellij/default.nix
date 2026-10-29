{pkgs, ...}: {
  programs.zellij = {
    enable = true;
    enableFishIntegration = false;
  };

  xdg.configFile."zellij/config.kdl".source = pkgs.replaceVars ./config.kdl {
    zjstatus = pkgs.zellijPlugins.zjstatus;
  };
  xdg.configFile."zellij/layouts".source = ./layouts;
}
