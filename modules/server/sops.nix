{ self, ... }:

{
  sops.defaultSopsFile = "${self}/secrets/secrets.yaml";
  sops.age.keyFile = "/var/lib/sops-nix/key.txt";
}
