{ config, pkgs, ... }:
{
  # services.greetd = {
  #   enable = true;
  #   settings = {
  #     default_session = {
  #       command = ''
  #         ${pkgs.tuigreet}/bin/tuigreet \
  #           --time \
  #           --asterisks \
  #           --user-menu \
  #           --sessions ${config.services.displayManager.sessionData.desktops}/share/wayland-sessions \
  #           --xsessions ${config.services.displayManager.sessionData.desktops}/share/xsessions \
  #           --remember \
  #           --remember-user-session
  #       '';
  #       user = "greeter";
  #     };
  #   };
  # };

  services.desktopManager.gnome.enable = true;
  services.displayManager.gdm.enable = true;
}
