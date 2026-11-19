{
  config,
  pkgs,
  keyboardLayout,
  hostname,
  ...
}:

{
  sops.secrets."navidrome/password" = { };
  sops.secrets."homeassistant-token" = { };
  sops.secrets."webuntis/url" = { };
  sops.secrets."webuntis/username" = { };
  sops.secrets."webuntis/password" = { };
  sops.secrets."weather/location" = { };
  sops.secrets."gomuks" = { };

  imports = [
    ./background.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    configType = "lua";
    settings.config.input.kb_layout = keyboardLayout;

    extraConfig = ''
      hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Classic")
      hl.env("HYPRCURSOR_SIZE", "24")

      require("workspaces")
      require("keybinds")
      require("appearance")
      require("autostart")
      require("input")
      require("gkeys")

      ${
        if hostname == "T14" then
          ''require("monitors.t14")''
        else if hostname == "mopc" then
          ''require("monitors.mopc")''
        else
          ""
      }

    '';
  };

  home.packages = with pkgs; [
    awww

    # Screenshot
    grim
    slurp
    tesseract

    wl-clipboard
  ];

  xdg.configFile."hypr" = {
    source = ./lua;
    recursive = true;
  };

  services.moqs = {
    enable = true;

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
      url = "couven.webuntis.com";
      school = "couven";
      username = "tm9033";
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
      location = "Aachen, DE";
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
