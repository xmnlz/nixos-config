{pkgs, ...}: let
  krisp-patch-script = pkgs.writeText "krisp_patch.py" ''
    import sys
    import lief

    replacement_code = [0x48, 0xC7, 0xC0, 0x01, 0x00, 0x00, 0x00, 0xC3]  # mov rax, 1; ret

    path = sys.argv[1]
    with open(path, "rb") as f:
        data = list(f.read())
        f.seek(0)
        mod = lief.parse(f)

    for sym in mod.symbols:
        if "IsSignedByDiscord" in sym.name:
            off = mod.virtual_address_to_offset(sym.value)
            if data[off:off+len(replacement_code)] == replacement_code:
                sys.exit(0)  # already patched, nothing to do
            for i, b in enumerate(replacement_code):
                data[i + off] = b
            with open(path, "wb") as f:
                f.write(bytes(data))
            sys.exit(0)
    sys.exit(1)  # symbol not found — layout changed, needs a human
  '';

  pythonWithLief = pkgs.python3.withPackages (ps: [ps.lief]);

  discord-krisp-wrapped = pkgs.writeShellScriptBin "discord" ''
    for f in "$HOME"/.config/discord/*/modules/discord_krisp/discord_krisp.node; do
      [ -f "$f" ] && ${pythonWithLief}/bin/python3 ${krisp-patch-script} "$f"
    done
    exec ${pkgs.discord}/bin/discord "$@"
  '';
in {
  home.packages = [discord-krisp-wrapped];

  xdg.desktopEntries.discord = {
    name = "Discord";
    exec = "${discord-krisp-wrapped}/bin/discord";
    icon = "discord";
    type = "Application";
    categories = ["Network" "InstantMessaging"];
  };
}
