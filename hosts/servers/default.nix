{ self, ... }:

{
  imports = [
    "${self}/modules/server/sops.nix"
    "${self}/modules/server/boot.nix"
    "${self}/modules/server/networking.nix"
    "${self}/modules/server/nix.nix"
    "${self}/modules/server/packages.nix"
    "${self}/modules/server/users.nix"
  ];
}
