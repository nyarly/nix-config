{ yubikeys }:
let
  pubkeys = map (s: "~/.ssh/yubi-${s}.pub") yubikeys;
in
{
  enable = true;
  enableDefaultConfig = false;

  extraOptionOverrides = {
    IdentitiesOnly = "yes";
    IdentityFile = "~/.ssh/%h_rsa";
  };

  matchBlocks = {
    "*" = {
      controlPersist = "60m";
      controlMaster = "auto";
      controlPath = "~/.ssh/control/%r@%h:%p.socket";

      forwardAgent = false;
      serverAliveInterval = 0;
      serverAliveCountMax = 3;
      compression = false;
      addKeysToAgent = "no";
      hashKnownHosts = false;
      userKnownHostsFile = "~/.ssh/known_hosts";
    };

    "github.com" = {
      identityFile = pubkeys;

      extraOptions = {
        LogLevel = "QUIET";
        ControlPersist = "300";
        ServerAliveInterval = "15";
        ServerAliveCountMax = "240";
      };
    };

    "bitbucket.org" = {
      identityFile = pubkeys;

      extraOptions = {
        LogLevel = "QUIET";
        ControlPersist = "300";
      };
    };
  };
}
