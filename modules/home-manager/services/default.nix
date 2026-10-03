{ hostname, ... }:

{
  imports = [
    ./syncthing.nix
  ]
  ++ (if hostname == "T14" then [ ./edgepad.nix ] else [ ]);
}
