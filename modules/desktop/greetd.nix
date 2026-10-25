{inputs, ...}: {
  imports = [
    inputs.dux-greeter.nixosModules.default
  ];

  programs.dms-greeter = {
    enable = true;
    compositor.name = "hyprland";
    configHome = "/home/xmnlz";
  };

  services.greetd.settings.default_session.user = "greeter";
}
