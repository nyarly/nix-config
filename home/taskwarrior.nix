{ unstable, config }:
{
  enable = true;
  colorTheme = "solarized-light-256";
  package = unstable.taskwarrior3;
  config = {
    confirmation = false;
    taskd = {
      server = "tasks.madhelm.net:53589";
      certificate = "${config.home.homeDirectory}/.task/keys/public.cert";
      key = "${config.home.homeDirectory}/.task/keys/private.key";
      ca = "${config.home.homeDirectory}/.task/keys/ca.cert";
      credentials = "madhelm/judson/8dc2777a-85db-410e-8f36-889d64a8cca7";
    };
    sync = {
      # encryption_key = ""; # nah, just provided manually
      server = {
        url = "http://madhelm.net:10222";
        client_id = "2e7a816d-46fe-4f99-acdb-26cda5200622";
      };
    };
  };

  extraConfig = builtins.readFile config/taskrc-contexts;
}
