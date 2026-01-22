{ yubikeys }:
let
  pubkeys = map (s: "~/.ssh/yubi-${s}.pub") yubikeys;
in
{
  enable = true;

  extraOptionOverrides = {
    IdentitiesOnly = "yes";
    IdentityFile = "~/.ssh/%h_rsa";
  };

  matchBlocks = {
    "*" = {
      controlPersist = "60m";
      controlMaster = "auto";
      controlPath = "~/.ssh/control/%r@%h:%p.socket";
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
