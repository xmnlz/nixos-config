{...}: {
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "xmnlz";
        email = "lemmeq9@gmail.com";
      };
      core.editor = "nvim";
      init.defaultBranch = "main";
      push.autoSetupRemote = true;
      merge.tool = "vimdiff";
      mergetool.prompt = false;
    };
  };

  programs.gh = {
    enable = true;
    gitCredentialHelper = {
      enable = true;
    };
  };
}
