{ lib, config, pkgs }:
let
  colors = rec {
    base03 = "#002b36";
    base02 = "#073642";
    base01 = "#586e75";
    base00 = "#657b83";
    base0 = "#839496";
    base1 = "#93a1a1";
    base2 = "#eee8d5";
    base3 = "#fdf6e3";
    yellow = "#b58900";
    orange = "#cb4b16";
    red = "#dc322f";
    magenta = "#d33682";
    violet = "#6c71c4";
    blue = "#268bd2";
    cyan = "#2aa198";
    green = "#859900";

    background = base03;
    background-alt = base02;
    foreground = base0;
    foreground-alt = base1;
    alert = red;
  };

  ramp = name: builtins.listToAttrs (
    lib.imap0
    ( idx: x: { name = "ramp-${name}-${toString idx}"; value = x; })
    ["▁" "▂" "▃" "▄" "▅" "▆" "▇" "█"]
  );
in
  {
    settings = {
      screenchange-reload = true;
      format-padding = 1;
    };

    "bar/main" = {
      monitor = "\${env:MONITOR:}";
      background = colors.background;
      foreground = colors.foreground;

      font-0 = "monofur;3";
      font-1 = "Noto Sans Mono";
      font-2 = "Noto Color Emoji:scale=10";
      font-3 = "DejaVu Sans";

      modules-left = "ewmh xwindow";
      modules-center = "taskwarrior";
      modules-right = "date zebratime memory battery cpu pulseaudio";

      tray-position = "right";

      underline-size = 4;
    };

    "module/zebratime" = {
    type = "custom/script";
    exec = ''TZ=UTC ${pkgs.coreutils}/bin/date +"%H:%M%Z"'';
    interval = 5;
    format-prefix = "🕛";
    format-underline = colors.orange;
    };

    "module/date" = {
    type = "internal/date";
    interval = 5;
    date = "";
    date-alt = " %Y-%m-%d";
    time = "%H:%M";
    format-prefix = "🕖";
    format-prefix-foreground = colors.foreground-alt;
    format-underline = colors.foreground-alt;
    label = "%date% %time%";
  };

  "module/xwindow" = {
  type = "internal/xwindow";
  label = "%title%";
  label-maxlen = 20;
  format-underline = colors.green;
  };

  "module/ewmh" = {
    type = "internal/xworkspaces";
    pin-workspaces = false;
    enable-click = true;
    # enable-scroll = true;
    reverse-scroll = true;

    /*
    # Not much point here
    icon-0 = "1;1";
    icon-1 = "2;2";
    icon-2 = "3;3";
    icon-3 = "4;4";
    icon-4 = "5;5";
    icon-5 = "6;6";
    icon-6 = "7;7";
    icon-7 = "8;8";
    icon-8 = "9;z";
    icon-9 = "10;0";
    */

    format = "<label-state>";
    label-monitor = "%name% ";
    label-active = "%name% ";
    label-active-underline= colors.cyan;
    /*
    # No occupied state?
    label-occupied = "%name% o";
    label-occupied-foreground = colors.foreground-alt;
    #label-occupied-background = colors.background;
    label-occupied-underline= colors.background;
    */
    label-urgent = "%name% ";
    label-urgent-background = colors.background-alt;
    label-urgent-underline = colors.alert;
    label-empty = "%name% ";
    label-empty-underline= colors.yellow;
    format-foreground = colors.foreground;
    format-background = colors.background;
  };

  "module/battery" = {
    type = "internal/battery";
    battery = "BAT0";
    adapter = "ADP0";
    format-charging = "<label-charging> <ramp-capacity>";
    format-charging-underline = colors.green;
    format-discharging = "<label-discharging> <ramp-capacity>";
    format-discharging-underline = colors.red;
    format-full = "<label-full>";
    format-full-underline = colors.green;
    label-charging = "🔌";
    label-discharging = "🔋";
    label-full = "Full";
  } // ramp "capacity";

  "module/memory" = {
    type = "internal/memory";
    interval = 2;
    format = "<label> <ramp-used> <ramp-swap-used>";
    format-prefix = "mem: ";
    format-prefix-foreground = colors.foreground-alt;
    format-underline = colors.violet;
    ramp-used-foreground = colors.violet;
    ramp-swap-used-foreground = colors.orange;
    label = "%percentage_used%%";
  } // ramp "used" // ramp "swap-used";

  "module/cpu" = {
    type = "internal/cpu";
    interval = 2;
    format = "<label> <ramp-coreload>";
    format-prefix = "proc: ";
    format-prefix-foreground = colors.foreground-alt;
    format-underline = colors.green;
    label = "%percentage:2%%";
    ramp-coreload-foreground = colors.green;
    } // ramp "coreload";

    "module/pulseaudio" = {
    type = "internal/pulseaudio";
    format-volume = "<label-volume> <ramp-volume>";
    format-volume-underline = colors.magenta;
    format-muted-underline = colors.magenta;

    label-volume = "🔊 %percentage%%";
    label-muted = "🔇 muted";
    ramp-volume-foreground = colors.magenta;
    click-right = "${pkgs.pavucontrol}/bin/pavucontrol &";
  } // ramp "volume";

  "module/github" = {
    type = "internal/github";
    # c.f. https://github.com/polybar/polybar/wiki/Module:-github
    token = "\${file:${config.xdg.configHome}/git/polybar-token}";
    interval = 60;
    format-underline = colors.yellow;
    label = "📬%notifications%";
    # click-left = "chromium github.com/notifications/beta &";
    # label = "%{A1:${pkgs.xdg_utils}/bin/xdg-open https\://github.com/notifications/beta &:} 📬%notifications% %{A}";
  };

  "module/taskwarrior" = {
    interval = 30;
    type = "custom/script";
    exec = "${config.home.homeDirectory}/.nix-profile/bin/task_polybar.sh";
    format = "<label>";
    format-foreground = colors.foreground;
    format-underline = colors.yellow;
    click-left = ''task "$((`cat /tmp/tw_polybar_id`))" done'';
  };
}
