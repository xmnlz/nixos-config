{...}: {
  programs.claude-code = {
    enable = true;

    context = ./context.md;

    skills = {
      code-review = ./skills/code-review;
    };

    settings = {
      model = "opus[1m]";
      effortLevel = "high";
      theme = "dark";

      # Transcripts, file-history, tasks and paste-cache get swept on this
      # cycle. The catch is that /resume can only reach sessions still on
      # disk, so coming back to a project after a week starts cold
      cleanupPeriodDays = 7;

      env = {
        # Umbrella switch. Also kills the update check (pointless here, the
        # package comes from nixpkgs), /feedback, /design-sync and
        # --enable-live-preview
        CLAUDE_CODE_DISABLE_NONESSENTIAL_TRAFFIC = "1";

        # The umbrella already covers these, but they are the names the docs
        # and other tooling look for, so set them outright
        DISABLE_TELEMETRY = "1";
        DISABLE_ERROR_REPORTING = "1";
        DISABLE_GROWTHBOOK = "1";

        # Nothing here should ever call out to an updater, nix owns the version
        DISABLE_AUTOUPDATER = "1";
      };

      permissions = {
        allow = [
          "Read"
          "Glob"
          "Grep"
        ];

        ask = [
          "Write"
          "Edit"
          "NotebookEdit"
          "Bash(rm:*)"
          "Bash(mv:*)"
          "Bash(cp:*)"
          "Bash(dd:*)"
          "Bash(ln:*)"
          "Bash(tee:*)"
          "Bash(truncate:*)"
          "Bash(chmod:*)"
          "Bash(chown:*)"
          "Bash(sed:*)"
          "Bash(git add:*)"
          "Bash(git rm:*)"
          "Bash(git mv:*)"
          "Bash(git commit:*)"
          "Bash(git push:*)"
          "Bash(git reset:*)"
          "Bash(git restore:*)"
          "Bash(git checkout:*)"
          "Bash(git revert:*)"
          "Bash(git rebase:*)"
          "Bash(git merge:*)"
          "Bash(git cherry-pick:*)"
          "Bash(git apply:*)"
          "Bash(git stash:*)"
          "Bash(git clean:*)"
          "Bash(git tag:*)"
          "Bash(gh:*)"
        ];
      };
    };
  };
}
