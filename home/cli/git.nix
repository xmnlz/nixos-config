{ ... }:

{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "xmnlz";
        email = "lemmeq9@gmail.com";
      };
      core.editor = "nvim";
      init.defaultBranch = "main";
    };
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
  };
}
