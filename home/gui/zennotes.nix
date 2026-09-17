{pkgs, ...}: {
  home.packages = [
    (pkgs.zennotes-desktop.override {
      installCli = true;
    })
  ];
}
