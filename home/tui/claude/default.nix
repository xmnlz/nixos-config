{pkgs, ...}: {
  programs.claude-code = {
    enable = true;

    context = ./CLAUDE.md;

    skills = {
      agent-browser = "${pkgs.agent-browser}/skills/agent-browser";

      ui = ./skills/ui;
      preview = ./skills/preview;
      break-ui = ./skills/break-ui;
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

      mobbin = {
        type = "http";
        url = "https://api.mobbin.com/mcp";
      };

      posthog = {
        type = "http";
        url = "https://mcp.posthog.com/mcp";
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

      cleanupPeriodDays = 14;

      skillOverrides = {
        simplify = "off";
        loop = "off";
        schedule = "off";
        claude-api = "off";
        workflow-authoring = "off";
        run = "off";
        plugin-authoring = "off";
        init = "off";
        security-review = "off";
        update-config = "off";
        keybindings-help = "off";
        fewer-permission-prompts = "off";
      };

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
