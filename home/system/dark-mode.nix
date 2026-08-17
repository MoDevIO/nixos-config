{
  gtk = {
    enable = true;
    colorScheme = "dark";

    gtk3.extraConfig = {
      "gtk-application-prefer-dark-theme" = true;
    };

    gtk4.extraConfig = {
      "gtk-application-prefer-dark-theme" = true;
    };

    iconTheme = {
      name = "Adwaita";
      #package =
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
  };
}
