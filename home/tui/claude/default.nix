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
