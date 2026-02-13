{ config, pkgs, ... }:

{
  # ============================================================================
  # Gaming Configuration Module
  # ============================================================================
  # This module handles all system-level gaming configuration including:
  # - Steam and Steam Remote Play
  # - Gamescope (Wayland compositor optimized for gaming)
  # - Kernel parameters for gaming
  # - GameMode for performance optimization
  #
  # References:
  # - https://nixos.wiki/wiki/Steam
  # - https://github.com/FeralInteractive/gamemode
  # - https://github.com/ValveSoftware/gamescope
  # ============================================================================

  # ----------------------------------------------------------------------------
  # Steam Configuration
  # ----------------------------------------------------------------------------
  # Steam is Valve's digital distribution platform for games
  # This enables Steam with Wayland support and network features
  programs.steam = {
    enable = true;
    
    # Steam Remote Play: Allows streaming games from this PC to other devices
    # Opens necessary firewall ports (UDP 27031-27036, TCP 27036-27037)
    remotePlay.openFirewall = true;
    
    # Source Dedicated Server: For hosting game servers
    # Opens UDP ports 27015 and 27020
    dedicatedServer.openFirewall = true;
    
    # Local Network Game Transfers: Faster game downloads from other PCs on LAN
    # Shares downloaded games with other Steam clients on the local network
    localNetworkGameTransfers.openFirewall = true;
    
    # Gamescope Session: Enables running Steam in a dedicated gamescope compositor
    # Provides better performance and Wayland support for games
    gamescopeSession.enable = true;
  };

  # ----------------------------------------------------------------------------
  # Gamescope Configuration
  # ----------------------------------------------------------------------------
  # Gamescope is a Wayland compositor specifically designed for gaming
  # It provides:
  # - Better performance for games on Wayland
  # - Frame rate limiting and VRR (Variable Refresh Rate) support
  # - Resolution scaling and FSR (FidelityFX Super Resolution)
  # - Integer scaling for pixel-perfect retro games
  #
  # Usage: Run games with "gamescope -- <game-command>"
  # Example: gamescope -W 1920 -H 1080 -r 144 -- steam
  programs.gamescope = {
    enable = true;
    
    # capSysNice: Allows gamescope to use realtime scheduling priorities
    # This reduces input latency and improves frame pacing
    # Requires CAP_SYS_NICE capability for the gamescope process
    capSysNice = true;
  };

  # ----------------------------------------------------------------------------
  # Kernel Parameters for Gaming
  # ----------------------------------------------------------------------------
  # vm.max_map_count: Maximum number of memory map areas a process may have
  # Many modern games (especially those using Wine/Proton) require a higher limit
  # Default is 65530, but games like Star Citizen, Escape from Tarkov, etc. need more
  # Setting it to 2147483642 ensures compatibility with all games
  #
  # Reference: https://www.kernel.org/doc/html/latest/admin-guide/sysctl/vm.html
  boot.kernel.sysctl = {
    "vm.max_map_count" = 2147483642;
  };

  # ----------------------------------------------------------------------------
  # System Packages for Gaming
  # ----------------------------------------------------------------------------
  # Additional utilities to enhance gaming experience:
  # - gamemode: Temporarily optimizes system performance while gaming
  # - mangohud: Performance overlay showing FPS, CPU/GPU usage, temperatures
  # These are system-wide installations available to all users
  environment.systemPackages = with pkgs; [
    # GameMode: Applies optimizations when games are running
    # - Increases CPU governor to performance mode
    # - Raises process priority
    # - Disables screen savers
    # Games detect and enable it automatically via libgamemode
    gamemode
    
    # MangoHud: Vulkan/OpenGL overlay for monitoring performance
    # Usage: mangohud <game-command> or enable globally in game settings
    # Shows FPS, frame times, CPU/GPU usage, temperatures, VRAM usage
    # Configuration: ~/.config/MangoHud/MangoHud.conf
    mangohud
  ];
}
