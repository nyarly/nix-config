{pkgs}:
{
  enable = true;
  defaultCacheTtlSsh = 28800;
  defaultCacheTtl = 28800;
  maxCacheTtl = 86400;
  maxCacheTtlSsh = 86400;
  enableSshSupport = true;
  pinentry.package = pkgs.pinentry-gtk2;
  extraConfig = ''
  '';
}
