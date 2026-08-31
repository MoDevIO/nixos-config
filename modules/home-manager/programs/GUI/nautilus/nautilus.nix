{ username, ... }:

{
  home.file.".config/gtk-3.0/bookmarks".text = ''
    file:///home/${username}/Documents Documents
    file:///home/${username}/Music Music
    file:///home/${username}/Pictures Pictures
    file:///home/${username}/Videos Videos
    file:///home/${username}/Downloads Downloads
    sftp://root@homeassistant/ Homeassistant
  '';
}
