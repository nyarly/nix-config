{
  enable = true;
  settings = {
    global = {
      font = "DejaVu Sans Book 10";
      markup = "full";
      format = ''<b>%s</b>\n%b'';
      sort = "yes";
      indicate_hidden = "yes";
      alignment = "left";
      bounce_freq = 0;
      show_age_threshold = 60;
      word_wrap = "yes";
      ignore_newline = "no";
      geometry = "300x5-4+24";
      shrink = "yes";
      transparency = 0;
      idle_threshold = 120;
      monitor = 0;
      follow = "keyboard";
      sticky_history = "yes";
      history_length = 20;
      show_indicators = "yes";
      line_height = 4;
      separator_height = 2;
      padding = 8;
      horizontal_padding = 8;
      frame_width = 3;
      frame_color = "#aaaaaa";
      separator_color = "frame";
      startup_notification = false;
      dmenu = "/run/current-system/sw/bin/dmenu -p dunst:";
      browser = "/run/current-system/sw/bin/chromium";
      icon_position = "right";
      max_icon_size = 48;
    };
    shortcuts = {
      close = "ctrl+space";
      close_all = "ctrl+shift+space";
      history = "ctrl+grave";
      context = "ctrl+shift+period";
    };
    urgency_low = {
      background = "#222222";
      foreground = "#888888";
      timeout = 10;
    };
    urgency_normal = {
      background = "#285577";
      foreground = "#ffffff";
      timeout = 10;
    };
    urgency_critical = {
      background = "#900000";
      foreground = "#ffffff";
      timeout = 0;
    };
  };
}
