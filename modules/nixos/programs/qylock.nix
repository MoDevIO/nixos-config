{
  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;

  programs.qylock = {
    enable = true;
    theme = "pixel-waterfall";
    sddm.enable = true;
    quickshell.enable = true;
  };
}
