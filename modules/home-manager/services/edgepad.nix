{ inputs, pkgs, ... }:

{
  imports = [ inputs.edgepad.homeManagerModules.default ];

  home.packages = with pkgs; [
    brightnessctl
    pulseaudio
    playerctl
  ];

  services.edgepad = {
    enable = true;
    device = "auto";
    edgeWidth = 0.09;

    tapMinDurationMs = 40;
    tapMaxDurationMs = 180;
    doubleTapTimeoutMs = 300;
    doubleTapMaxDistance = 0.04;
    swipeMinDistance = 0.02;

    sliders = [
      {
        zone = "right";
        up = [
          "${pkgs.brightnessctl}/bin/brightnessctl"
          "set"
          "+3%"
        ];
        down = [
          "${pkgs.brightnessctl}/bin/brightnessctl"
          "set"
          "3%-"
        ];
      }
      {
        zone = "left";
        up = [
          "${pkgs.pulseaudio}/bin/pactl"
          "set-sink-volume"
          "@DEFAULT_SINK@"
          "+3%"
        ];
        down = [
          "${pkgs.pulseaudio}/bin/pactl"
          "set-sink-volume"
          "@DEFAULT_SINK@"
          "-3%"
        ];
      }
    ];

    gestures = [
      {
        zone = "bottom";
        direction = "tap";
        action = [
          "${pkgs.playerctl}/bin/playerctl"
          "play-pause"
        ];
      }
      {
        zone = "bottom";
        direction = "left";
        action = [
          "${pkgs.playerctl}/bin/playerctl"
          "previous"
        ];
      }
      {
        zone = "bottom";
        direction = "right";
        action = [
          "${pkgs.playerctl}/bin/playerctl"
          "next"
        ];
      }

      {
        zone = "top";
        direction = "tap";
        action = [
          "zsh"
          "-ic"
          "ha-toggle"
        ];
      }
    ];
  };
}
