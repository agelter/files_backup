{ pkgs, config, isDesktop, isWorkMachine, withGUI }:
  let workGitConfig = if (isWorkMachine && !withGUI) then {
    "include" = {
      path = "${config.home.homeDirectory}/.config/git/server.gitconfig";
    };
    user.signingkey = "C73B427821EA198E";
  } else if (isWorkMachine && withGUI) then {
    "http \"https://stash-temporary.netflix.net:7006/\"" = {
      sslVerify = true;
      sslCert = "${config.home.homeDirectory}/.metatron/certificates/client.crt";
      sslKey = "${config.home.homeDirectory}/.metatron/certificates/client.key";
    };
    user.signingkey = "C73B427821EA198E";
  } else {};

in
{
  enable = true;
  lfs.enable = true;
  userName = "Aaron Gelter";
  userEmail = "agelter@netflix.com";
  signing = {
    key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHQIoHWeCP3B6dn/iPXOrUqGeyyQbGux5cZ7Tu0aBqr1";
    signByDefault = false;
  };

  aliases = {
    cp = "cherry-pick";
    rhm = "reset --hard origin/master";
    pt = "push-to-target";
    pr = "!git push origin HEAD 2>&1 | grep https | sed s/remote:// | xargs open";
    dm = "remote prune origin";
    br = "branch --sort=-committerdate";
    br2 = "!git reflog show --pretty=format:'%gs ~ %gd' --date=relative | grep 'checkout:' | grep -oE '[^ ]+ ~ .*' | awk -F~ '!seen[$1]++' | head -n 15 | awk -F' ~ HEAD@{' '{printf(\"  \\033[33m%s: \\033[37m %s\\033[0m\\n\", substr($2, 1, length($2)-1), $1)}'";
    wip = "!git add -u && git commit -m wip --no-verify";
    sno = "show --name-only --show-signature";
    l = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit";
    ca = "commit --amend --no-edit --sign";
    ci = "commit --verbose";
    fp = "push --force-with-lease";
    rb = "!f() { if [ $# -eq 0 ]; then set -- origin/main; git fetch origin main; fi && git rebase \"$@\"; }; f";
    rc = "rebase --continue";
    ri = "!f() { if [ $# -eq 0 ]; then set -- origin/main; fi; git rebase --interactive --keep-base \"$@\"; }; f";
    st = "status --short";
    pullrb = "pull --rebase";
    sw = "!f() { if [ $# -gt 0 ]; then git switch \"$@\"; else git branch --sort=-committerdate | fzf | xargs git switch; fi; }; f";
    bcln = "!f() { dbranch=$(git remote show origin | grep 'HEAD branch' | cut -d' ' -f5); git branch -d $(git branch --merged=$dbranch | grep -v $dbranch); }; f";
  };

  extraConfig = workGitConfig // {
    commit.gpgSign = true;
    core = {
      editor = "vi";
      autocrlf = "input";
    };
    fetch.prune = true;
    init.defaultBranch = "main";
    merge = {
      renamelimit = "5000";
      tool = "vimdiff";
    };
    pull.rebase = true;
    push.autoSetupRemote = true;
    rebase = {
      autoStash = true;
      updateRefs = true;
    };
    rerere = {
      enabled = true;
      autoupdate = true;
    };
    status.submoduleSummary = true;
    tag.gpgSign = true;
  };

  diff-so-fancy = {
    enable = true;
    changeHunkIndicators = false;
    markEmptyLines = true;
    pagerOpts = [
      "--tabs=4"
      "-RFX"
    ];
  };
}