{ keyboardLayout, ... }:

let
  consoleKeyMap = if keyboardLayout == "gb" then "uk" else keyboardLayout;
in
{
  services.xserver.xkb = {
    layout = keyboardLayout;
    variant = "";
  };

  console.keyMap = consoleKeyMap;
  console.font = null;

  i18n.defaultLocale = "en_GB.UTF-8";

  time.timeZone = "Europe/Berlin";
}
