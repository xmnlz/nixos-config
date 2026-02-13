{ config, pkgs, ... }:

{
  # ============================================================================
  # Steam User Environment Configuration
  # ============================================================================
  # This module configures ONLY user-level environment variables for gaming.
  # 
  # ALL gaming packages and system configuration are in:
  #   ../../modules/nixos/gaming.nix
  #
  # This file exists because environment variables MUST be set at user-level
  # (they cannot be set system-wide for user sessions)
  # ============================================================================

  # ----------------------------------------------------------------------------
  # Wayland Environment Variables for Steam and Games
  # ----------------------------------------------------------------------------
  # These variables tell Steam and games to prefer Wayland over X11
  # Wayland provides better performance, security, and multi-monitor support
  #
  # Note: Some older games may not work well with Wayland and will fallback to XWayland
  # Reference: https://wiki.archlinux.org/title/Wayland
  home.sessionVariables = {
    # SDL_VIDEODRIVER: Forces SDL2 applications (many games) to use Wayland
    # SDL (Simple DirectMedia Layer) is used by thousands of games
    # Options: "wayland", "x11", "wayland,x11" (tries Wayland first, then X11)
    SDL_VIDEODRIVER = "wayland";
    
    # QT_QPA_PLATFORM: Forces Qt applications to use Wayland
    # Steam's UI is built with Qt, so this makes Steam itself run on Wayland
    # Options: "wayland", "xcb" (X11), "wayland;xcb" (tries both)
    QT_QPA_PLATFORM = "wayland";
    
    # NIXOS_OZONE_WL: Enables Wayland support for Electron/Chromium apps
    # Some games' launchers use Electron (e.g., Epic Games, Discord overlays)
    # Set to "1" to enable Wayland support
    NIXOS_OZONE_WL = "1";
  };

  # NOTE: Gaming packages (mangohud, gamemode, gamescope) are installed
  # system-wide in modules/nixos/gaming.nix - no need to duplicate them here!
}
