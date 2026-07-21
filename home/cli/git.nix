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

      pull.rebase = false;
      merge.tool = "nvimdiff";
      merge.conflictStyle = "zdiff3";

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
