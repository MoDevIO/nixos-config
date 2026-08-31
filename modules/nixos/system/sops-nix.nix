{ self, username, ... }:

{
  sops.defaultSopsFile = "${self}/secrets/secrets.yaml";
  sops.age.keyFile = "/home/${username}/.config/sops/age/keys.txt";
}
