{ inputs, pkgs, ... }:

{
  imports = [ inputs.edgepad.homeManagerModules.default ];

  services.edgepad = {
    enable = true;
    device = "auto";
    edgeWidth = 0.10;

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
  };
}
