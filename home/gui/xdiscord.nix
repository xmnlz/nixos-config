{pkgs, ...}: let
  # Krisp's native module refuses to load unless the host binary is "signed by
  # Discord". On an unofficial (nixpkgs) build the check fails and Krisp noise
  # suppression is disabled — see ~/.config/discord/logs/discord_krisp.log:
  #   "Application not signed by Discord, Krisp is not enabled"  (error -3)
  #
  # We neutralise the check by patching discord::util::IsSignedByDiscord() in
  # discord_krisp.node to unconditionally return true (mov rax, 1; ret).
  #
  # This MUST happen at build time. nixpkgs ships the Krisp module inside the
  # store, and `discord-stage-modules` (run from Discord's wrapper on every
  # launch) wipes ~/.config/discord/<ver>/modules and re-symlinks the module
  # read-only from the store — so the file can never be patched at runtime.
  krisp-patch = pkgs.writeText "krisp_patch.py" ''
    import sys, lief

    replacement = bytes([0x48, 0xC7, 0xC0, 0x01, 0x00, 0x00, 0x00, 0xC3])  # mov rax, 1; ret

    path = sys.argv[1]
    with open(path, "rb") as f:
        data = bytearray(f.read())
    mod = lief.parse(path)

    for sym in mod.symbols:
        if "IsSignedByDiscord" in sym.name:
            off = mod.virtual_address_to_offset(sym.value)
            if data[off:off + len(replacement)] == replacement:
                print("krisp: already patched"); sys.exit(0)
            data[off:off + len(replacement)] = replacement
            with open(path, "wb") as f:
                f.write(data)
            print(f"krisp: patched IsSignedByDiscord at offset {hex(off)}"); sys.exit(0)

    sys.exit("krisp: IsSignedByDiscord symbol not found — Discord changed the "
             "module layout, the patch needs updating")
  '';

  pythonWithLief = pkgs.python3.withPackages (ps: [ps.lief]);

  discord = pkgs.discord.overrideAttrs (old: {
    postFixup =
      (old.postFixup or "")
      + ''
        ${pythonWithLief}/bin/python3 ${krisp-patch} \
          "$out/opt/Discord/modules/discord_krisp/discord_krisp.node"
      '';
  });
in {
  home.packages = [discord];

  xdg.desktopEntries.discord = {
    name = "Discord";
    exec = "${discord}/bin/discord";
    icon = "discord";
    type = "Application";
    categories = ["Network" "InstantMessaging"];
    settings.StartupWMClass = "discord";
  };
}
