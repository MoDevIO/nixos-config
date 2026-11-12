{ hostname, ... }:

{
  services.howdy = {
    enable = hostname == "t14" || hostname == "t14-install";

    control = "sufficient";

    settings = {
      video.device_path = "/dev/video0";
      video.certainty = 4.2;

      core.no_confirmation = true;

    };
  };
}
