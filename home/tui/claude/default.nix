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

      break-ui = ./skills/break-ui;
      web-design-guidelines = ./skills/web-design-guidelines;

      agent-browser = "${pkgs.agent-browser}/skills/agent-browser";
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

      cloudflare = {
        type = "http";
        url = "https://mcp.cloudflare.com/mcp";
      };

      posthog = {
        type = "http";
        url = "https://mcp.posthog.com/mcp";
      };

      svelte = {
        type = "http";
        url = "https://mcp.svelte.dev/mcp";
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
      model = "claude-opus-5-5[1m]";
      theme = "dark";

      cleanupPeriodDays = 7;

      permissions.defaultMode = "auto";

      preferredNotifChannel = "terminal_bell";

      statusLine = {
        type = "command";
        command = toString (pkgs.writeShellScript "claude-statusline" ''
          ${pkgs.jq}/bin/jq -r '
            .context_window as $c
            | "\(.model.display_name) · \(($c.total_input_tokens // 0) / 1000 | floor)k / \(($c.context_window_size // 0) / 1000 | floor)k (\($c.used_percentage // 0 | floor)%)"
          '
        '');
      };

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
