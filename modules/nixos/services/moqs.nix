{ config, ... }:

{
  services.displayManager.defaultSession = "hyprland";

  sops.secrets."navidrome/password".owner = "mo";
  sops.secrets."homeassistant-token".owner = "mo";
  sops.secrets."webuntis/url".owner = "mo";
  sops.secrets."webuntis/school".owner = "mo";
  sops.secrets."webuntis/username".owner = "mo";
  sops.secrets."webuntis/password".owner = "mo";
  sops.secrets."weather/location".owner = "mo";
  sops.secrets."gomuks".owner = "mo";

  home-manager.users.mo.services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "qs ipc call session lock";
        before_sleep_cmd = "qs ipc call session lockNow";
        after_sleep_cmd = "hyprctl dispatch dpms on";
        inhibit_sleep = 3;
      };
      listener = [
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
      ];
    };
  };

  services.moqs = {
    enable = true;
    user = "mo";

    greeter.enable = false;

    airdrop = {
      name = "Mo's Laptop";
    };

    launcher = {
      searchEngine = "https://www.google.com/search?q=%s";
    };

    navidrome = {
      enable = true;
      url = "music.tilt.mn";
      username = "mo";
      passwordFile = config.sops.secrets."navidrome/password".path;
    };

    matrix = {
      enable = true;
      username = "gomuks";
      passwordCommand = "cat ${config.sops.secrets."gomuks".path}";
    };

    webuntis = {
      enable = true;
      urlFile = config.sops.secrets."webuntis/url".path;
      schoolFile = config.sops.secrets."webuntis/school".path;
      usernameFile = config.sops.secrets."webuntis/username".path;
      passwordFile = config.sops.secrets."webuntis/password".path;
      cancelledRooms = [ "Eva" ];
      subjects = [
        {
          name = "Bio";
          untis = "Biologie";
        }
        {
          name = "Chemie";
          untis = "Chemie";
        }
        {
          name = "Deu";
          untis = "Deutsch";
        }
        {
          name = "Eng";
          untis = "Englisch";
        }
        {
          name = "Gesch";
          untis = "Geschichte";
        }
        {
          name = "Info";
          untis = "Informatik";
        }
        {
          name = "Latein";
          untis = "Latein 2. FS G9";
        }
        {
          name = "Mathe";
          untis = "Mathematik";
        }
        {
          name = "Musik";
          untis = "Musik";
        }
        {
          name = "Physik";
          untis = "Physik";
        }
        {
          name = "Philo";
          untis = "Prakt. Philosophie";
        }
        {
          name = "Sport";
          untis = "Sport";
        }
        {
          name = "Politik";
          untis = "Wirtschaft Politik";
        }
      ];
    };

    weather = {
      enable = true;
      locationFile = config.sops.secrets."weather/location".path;
    };

    hass = {
      enable = true;
      url = "https://ha.tilt.mn";
      tokenFile = config.sops.secrets."homeassistant-token".path;
      sections = [
        {
          type = "toggle";
          entity = "light.mo";
        }
        {
          type = "sensors";
          title = "Energy";
          entities = [
            {
              entity = "sensor.foxess_pvenergytotal";
              name = "Produced";
              icon = "mdi:solar-power";
            }
            {
              entity = "sensor.foxess_load";
              name = "Used";
              icon = "mdi:home-lightning-bolt";
            }
            {
              entity = "sensor.batterie";
              name = "Battery";
            }
          ];
        }
      ];
    };
  };
}
