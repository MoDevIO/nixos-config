{
  services.howdy = {
    enable = true;

    control = "sufficient";

    settings = {
      video.device_path = "/dev/video0";

      core.certainty = "";

      core.no_confirmation = true;

    };
  };
}
