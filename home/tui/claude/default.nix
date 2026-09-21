{pkgs, ...}: {
  programs.claude-code = {
    enable = true;

    context = ./CLAUDE.md;

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

    mcpServers = {
      nixos = {
        type = "stdio";
        command = "${pkgs.mcp-nixos}/bin/mcp-nixos";
      };

      linear = {
        type = "http";
        url = "https://mcp.linear.app/mcp";
      };

      figma = {
        type = "http";
        url = "https://mcp.figma.com/mcp";
      };

      zennotes = {
        type = "stdio";
        command = "${pkgs.nodejs}/bin/node";
        args = [
          "${pkgs.zennotes-desktop}/lib/node_modules/zennotes-monorepo/apps/desktop/out/main/cli.js"
          "mcp"
        ];
      };
    };

    settings = {
      model = "opus[1m]";
      effortLevel = "high";
      theme = "dark";

      cleanupPeriodDays = 7;

      permissions.defaultMode = "auto";

      preferredNotifChannel = "terminal_bell";

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
