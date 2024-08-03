{config}:
{
  enable = true;
  colorTheme = "solarized-light-256";
  config = {
    confirmation= false;
    taskd = {
      server = "tasks.madhelm.net:53589";
      certificate = "${config.home.homeDirectory}/.task/keys/public.cert";
      key = "${config.home.homeDirectory}/.task/keys/private.key";
      ca = "${config.home.homeDirectory}/.task/keys/ca.cert";
      credentials = "madhelm/judson/8dc2777a-85db-410e-8f36-889d64a8cca7";
    };
  };

  extraConfig = builtins.readFile config/taskrc-contexts;
}
