{ self, ... }:

{
  imports = [
    ./hardware-configuration.nix
    "${self}/containers/authentik"
    "${self}/containers/synapse"
    "${self}/containers/immich"
    "${self}/containers/navidrome"
    "${self}/containers/feishin"
    "${self}/containers/jellyfin"
    "${self}/containers/pihole"
    "${self}/containers/homeassistant"
  ];
}
