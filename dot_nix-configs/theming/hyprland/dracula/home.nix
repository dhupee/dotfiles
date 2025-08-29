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

      env = [
        "NIXOS_OZONE_WL, 1"
        # "GTK_THEME, Dark-Gruvbox" # required for Nautilus to apply current theme
        "XDG_SESSION_DESKTOP, Hyprland"
        "XDG_CURRENT_DESKTOP, Hyprland"
        "XDG_DESKTOP_DIR, $HOME/Desktop"
        "XDG_DOWNLOAD_DIR, $HOME/Downloads"
        # "XDG_TEMPLATES_DIR, $HOME/Templates"
        "XDG_PUBLICSHARE_DIR, $HOME/Public"
        "XDG_DOCUMENTS_DIR, $HOME/Documents"
        "XDG_MUSIC_DIR, $HOME/Music"
        "XDG_PICTURES_DIR, $HOME/Pictures"
        "XDG_VIDEOS_DIR, $HOME/Videos"
        "HYPRSHOT_DIR, $HOME/Pictures/Screenshots"
      ];

      "$mod" = "SUPER";
      bind =
        [
          "$mod, Q, exec, ghostty"
          "$mod, F, exec, firefox"
          "$mod, return, exec, wofi -S drun"
          # ", Print, exec, grimblast copy area"

          ", PRINT, exec, hyprshot -m region"
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
      mainbar = {
        "layer" = "top";
        "position" = "top";
        "autohide" = true;
        "autohide-blocked" = false;
        "exclusive" = true;
        "passthrough" = false;
        "gtk-layer-shell" = true;

        # Modules Order
        "modules-left" = [
          "custom/archicon"
          "clock"
          "cpu"
          "memory"
          "disk"
          "temperature"
        ];
        "modules-center" = [
          "hyprland/workspaces"
        ];
        "modules-right" = [
          "wlr/taskbar"
          "idle_inhibitor"
          "pulseaudio_slider"
          "pulseaudio"
          "network"
          "hyprland/language"
        ];
        # Modules Left
        "custom/archicon" = {
          "format" = "";
          "on-click" = "wofi --show drun";
          "tooltip" = false;
        };
        "clock" = {
          "timezone" = "Asia/Jakarta";
          "format" = "{:%I:%M  %d, %m}";
          "tooltip-format" = "{calendar}";
          "calendar" = {
            "mode" = "month";
          };
        };
        "cpu" = {
          "format" = "{usage}% ";
          "tooltip" = true;
          "tooltip-format" = "Uso de CPU: {usage}%\nNúcleos: {cores}";
        };
        "memory" = {
          "format" = "{}% 󰍛";
          "tooltip" = true;
          "tooltip-format" = "RAM en uso: {used} / {total} ({percentage}%)";
        };
        "disk" = {
          "format" = "{percentage_free}% ";
          "tooltip" = true;
          "tooltip-format" = "Espacio libre: {free} / {total} ({percentage_free}%)";
        };
        "temperature" = {
          "format" = "{temperatureC}°C {icon}";
          "tooltip" = true;
          "tooltip-format" = "Temperatura actual: {temperatureC}°C\nCrítico si > 80°C";
          "format-icons" = [
            ""
          ];
        };
        # Modules Center
        "hyprland/workspaces" = {
          "format" = "{icon}";
          "format-icons" = {
            "default" = "";
            "active" = "";
          };
          "persistent-workspaces" = {
            "*" = 2;
          };
          "disable-scroll" = true;
          "all-outputs" = true;
          "show-special" = true;
        };
        # Modules Right
        "wlr/taskbar" = {
          "format" = "{icon}";
          "all-outputs" = true;
          "active-first" = true;
          "tooltip-format" = "{name}";
          "on-click" = "activate";
          "on-click-middle" = "close";
          "ignore-list" = [
            "rofi"
          ];
        };
        "idle_inhibitor" = {
          "format" = "{icon}";
          "format-icons" = {
            "activated" = "";
            "deactivated" = "";
          };
        };
        "pulseaudio_slider" = {
          "format" = "{volume}%";
          "tooltip" = false;
          "on-click" = "pavucontrol";
        };
        "pulseaudio" = {
          "format" = "{volume}% {icon}";
          "format-muted" = " {format_source}";
          "format-icons" = {
            "default" = [
              ""
              ""
            ];
          };
        };
        "network" = {
          "format" = "{ifname}";
          "format-ethernet" = "{ifname} 󰈀";
          "format-disconnected" = " ";
          "tooltip-format" = " {ifname} via {gwaddr}";
          "tooltip-format-ethernet" = " {ifname} {ipaddr}/{cidr}";
          "tooltip-format-disconnected" = "Disconnected";
          "max-length" = 50;
        };
        "hyprland/language" = {
          "format" = "{} ";
          "on-click" = "hyprctl switchxkblayout at-translated-set-2-keyboard next";
          "format-es" = "ESP";
          "format-en" = "ENG";
        };
      };
    };
  };
}
