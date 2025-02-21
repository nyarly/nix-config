{pkgs}:
{
  # :eyes: git.maintenance

  enable = true;
  package = pkgs.gitAndTools.gitFull;
  userName = "Judson Lester";
  userEmail = "nyarly@gmail.com";
  aliases = {
    ctags = "!.git/hooks/ctags";
    bundle-tags = "!.git/hooks/bundle-ctags";
    savepoint-merge = "!~/bin/git-savepoint-merge";
    savepoint-complete = "!~/bin/git-savepoint-complete";
    savepoint-reset = "!~/bin/git-savepoint-reset";
    savepoint-zap = "branch -d savepoint";
    localize-branches = "!~/bin/git-localize-branches";
    go-root = "!echo $(pwd) $GIT_PREFIX";
    pb = "!pb";
    mt = "mergetool";
    dt = "difftool -d";
  };
  signing = {
    key = null;
    signByDefault = true;
  };
  ignores = [
    ".envrc"
    ".ctrlp-root"
    ".vim-role"
    ".cadre"
    ".sw?"
    "!.swf"
    "failed_specs"
    "rspec_status"
    "*Session.vim"
    "errors.err"
    ".nix-gc/"
    ".taskrc"
  ];

  delta = {
    enable = true;
    options = {
      light = true;
    };
  };

  includes = [
    # condition = ? # something about "if it exists"?
    { path = "~/.config/git/secret"; }
  ];
  # can be attrs converted...
  extraConfig = {
    core = {
      hooksPath = "~/.config/git/hooks";
    };
    branch.autosetupmerge = true;
    color = {
      branch = true;
      diff = true;
      grep = true;
      interactive = true;
      status = true;
      ui = true;
    };
    rerere.enabled = true;
    init = {
      templatedir = "~/.git_template";
      defaultBranch = "main";
    };
    bash.showDirtyState = true;
    tag.forceSignAnnotated = true;
    pull = {
      rebase = false;
    };
    push = {
      default = "current";
      followTags = true;
    };
    help.autocorrect = -1;
    interactive.singlekey = true;
    merge = {
      tool = "meld";
      conflictstyle = "diff3";
      renormalize = true;
    };
    mergetool = {
      keepBackup = false;
      prompt = false;
    };
    rebase.autosquash = true;

    diff = {
      tool = "meld";
      rename = "copy";
      algorithm = "patience";
    };

    url = {
      "ssh://git@github.com" = {
        insteadOf = "https://github.com";
      };
    };


    diff.rawtext.textconv = "~/.config/git/trimwhite.sh";

    filter.trimwhite.clean = "~/.config/git/trimwhite.sh";
    filter.update-created.clean = "created-at-commit";
    filter.update-created.smudge = "created-at-commit";

    mergetool.mymeld.cmd = "meld --diff $LOCAL $BASE $REMOTE --output=$MERGED --diff $BASE $LOCAL --diff $BASE $REMOTE";

    github.user = "nyarly";
  };
}
