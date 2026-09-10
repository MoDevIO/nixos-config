{ self, ... }:

{
  imports = [
    ./hardware-configuration.nix
    "${self}/containers/synapse"
  ];
}
