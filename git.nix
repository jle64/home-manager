{
  enable = true;
  ignores = [
    "*.swp"
    "*.swo"
  ];

  settings = {
    user.name = "Jonathan Lestrelin";
    user.email = "jonathan@lestrel.in";
    signing = {
      key = "~/.ssh/id_ed25519.pub";
      signByDefault = true;
    };

    alias = {
      cp = "cherry-pick";
      st = "status";
      cl = "clone";
      cm = "commit";
      co = "checkout";
      br = "branch";
      dc = "diff --cached";
      sw = "switch";
      sc = "switch --create";
      last = "log -1 --stat";
      unstage = "reset HEAD --";

      lg = "log --reverse --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %Cblue<%an>%Creset' --all";
      lr = "log --reverse";
    };

    extraConfig = {
      core = {
        whitespace = "fix,trailing-space,tabwidth=4";
      };

      merge = {
        tool = "vimdiff";
        conflictstyle = "zdiff3";
      };

      log = {
        date = "rfc2822";
      };

      color = {
        diff = "auto";
        status = "auto";
        branch = "auto";
        interactive = "auto";
        ui = "auto";
        pager = true;
      };

      "color \"diff\"" = {
        meta = "cyan";
        frag = "yellow";
        old = "red";
        new = "green";
      };

      "color \"status\"" = {
        added = "cyan";
        changed = "green";
        untracked = "magenta";
      };

      push = {
        default = "simple";
        followtags = true;
        autoSetupRemote = true;
      };

      gui = {
        warndetachedcommit = true;
        spellingdictionary = "en";
      };

      pull = {
        rebase = false;
      };

      init = {
        defaultBranch = "main";
      };

      credential = {
        helper = "/usr/libexec/git-core/git-credential-libsecret";
      };

      commit = {
        gpgsign = true;
      };

      gpg = {
        format = "ssh";
      };

      help = {
        autocorrect = "prompt";
      };

      diff = {
        algorithm = "histogram";
      };
    };
  };
}
