let
  giveItToChrome = types: builtins.listToAttrs (map (type: {name = type; value = "google-chrome.desktop";}) types);
in
{
  enable = true;
  defaultApplications = giveItToChrome [
    "text/html"
    "x-scheme-handler/http"
    "x-scheme-handler/https"
    "x-scheme-handler/about"
    "x-scheme-handler/unknown"
    "x-scheme-handler/mailto"
    "x-scheme-handler/webcal"
    "x-scheme-handler/sgnl"
    "x-scheme-handler/chrome"
    "application/x-extension-htm"
    "application/x-extension-html"
    "application/x-extension-shtml"
    "application/xhtml+xml"
    "application/x-extension-xhtml"
    "application/x-extension-xht"
  ] // {
    # "x-scheme-handler/postman"=["Postman.desktop"];
    "x-scheme-handler/discord-402572971681644545"=["discord-402572971681644545.desktop"];
  };

  associations.added = giveItToChrome [
    "x-scheme-handler/http"
    "x-scheme-handler/https"
    "x-scheme-handler/chrome"
    "text/html"
    "application/x-extension-htm"
    "application/x-extension-html"
    "application/x-extension-shtml"
    "application/xhtml+xml"
    "application/x-extension-xhtml"
    "application/x-extension-xht"
  ];
}
