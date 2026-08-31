{ self, ... }:

{
  sops.defaultSopsFile = "${self}/secrets/secrets.yaml";
  sops.age.keyFile = "/home/mo/.config/sops/age/keys.txt";
}
