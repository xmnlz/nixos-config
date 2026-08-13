{...}: {
  programs.claude-code = {
    enable = true;

    skills = {
      code-review = ./skills/code-review;

      better-interface = ./skills/better-interface;
      better-accessibility = ./skills/better-accessibility;
      better-colors = ./skills/better-colors;
      better-layout = ./skills/better-layout;
      better-typography = ./skills/better-typography;
      better-ui = ./skills/better-ui;
      better-writing = ./skills/better-writing;
    };

    settings = {
      model = "opus[1m]";
      effortLevel = "high";
      theme = "dark";

      cleanupPeriodDays = 7;

      env = {
        CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC = "1";

        DISABLE_TELEMETRY = "1";
        DISABLE_ERROR_REPORTING = "1";
        DISABLE_GROWTHBOOK = "1";

        DISABLE_AUTOUPDATER = "1";
      };
    };
  };
}
