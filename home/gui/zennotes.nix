{pkgs, ...}: let
  zn-cli = pkgs.writeShellScriptBin "zn-cli" ''
    exec ${pkgs.nodejs}/bin/node \
      ${pkgs.zennotes-desktop}/lib/node_modules/zennotes-monorepo/apps/desktop/out/main/cli.js \
      "$@"
  '';
in {
  home.packages = [
    pkgs.zennotes-desktop
    zn-cli
  ];
}
