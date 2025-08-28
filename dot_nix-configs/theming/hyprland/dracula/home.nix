{
  lib,
  pkgs,
  ...
}: {
  # Hyprpaper, Wallapaper related
  services = {
    hyprpaper = {
      enable = true;
      settings = {
        preload = [
          "~/Wallpapers/God only knows.png"
        ];
        wallpaper = [
          ", ~/Wallpapers/God only knows.png"
        ];
      };
    };
  };

  # Enabling Hyprland
  # programs.kitty.enable = true;
  wayland.windowManager.hyprland = {
    enable = true;
    settings = {
      exec-once = [
        # "sh ~/.config/waybar/waybar.sh"
        "waybar"
        "hyprpaper"
        # "wl-clip-persist"
        # "power-profiles-daemon"
        # "nm-applet --no-agent"
      ];

      "$mod" = "SUPER";
      bind =
        [
          "$mod, Q, exec, ghostty"
          "$mod, F, exec, firefox"
          "$mod, return, exec, wofi -S drun"
          # ", Print, exec, grimblast copy area"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
          builtins.concatLists (builtins.genList (
              i: let
                ws = i + 1;
              in [
                "$mod, code:1${toString i}, workspace, ${toString ws}"
                "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
              ]
            )
            9)
        );

      # mouse binding
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:273, movewindow"
      ];

      bindl = [
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];
      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl s 10%+"
        ",XF86MonBrightnessDown, exec, brightnessctl s 10%-"
      ];

      # monitors
      monitor = [
        # left
        # "DP-4,     1920x1080@60,  0x0,    1"
        # center
        # "HDMI-A-1, 1920x1080@120, 1920x0, 1"
        # right
        # "eDP-1,    1920x1080@60,  3840x0, 1"
      ];
    };
  };

  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 30;
        output = [
          "eDP-1"
          "HDMI-A-1"
        ];
        modules-left = ["sway/workspaces" "sway/mode" "wlr/taskbar"];
        modules-center = ["sway/window" "custom/hello-from-waybar"];
        modules-right = ["mpd" "custom/mymodule#with-css-id" "temperature"];

        "sway/workspaces" = {
          disable-scroll = true;
          all-outputs = true;
        };
        "custom/hello-from-waybar" = {
          format = "hello {}";
          max-length = 40;
          interval = "once";
          exec = pkgs.writeShellScript "hello-from-waybar" ''
            echo "from within waybar"
          '';
        };
      };
    };
  };
}
