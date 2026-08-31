{
  services.howdy = {
    enable = true;

    control = "sufficient";

    settings = {
      video.device_path = "/dev/video0";
      video.certainty = 4.2;

      core.no_confirmation = true;

    };
  };
}
