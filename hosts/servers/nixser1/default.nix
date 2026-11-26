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
    "${self}/containers/ollama"
    # "${self}/containers/ttyd"
    "${self}/containers/tom"
    "${self}/containers/homepage"
    "${self}/containers/paperless-ngx"
    "${self}/containers/worker-01"
    "${self}/containers/worker-02"

    "${self}/modules/server/networking.nix"
  ];
}
