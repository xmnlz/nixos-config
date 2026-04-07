return {
  cmd = { "nixd" },
  filetypes = { "nix" },
  root_markers = { "flake.nix", ".git" },
  settings = {
    nixd = {
      nixpkgs = {
        expr = "import <nixpkgs> { }",
      },
      formatting = {
        command = { "nixfmt" },
      },
      options = {
        nixos = {
          expr = '(builtins.getFlake (toString ./.)).nixosConfigurations.xmnlz.options',
        },
        home_manager = {
          expr = '(builtins.getFlake (toString ./.)).homeConfigurations."xmnlz@xmnlz".options',
        },
      },
    },
  },
}
