{ inputs, ... }:

{
  imports = [ inputs.edgepad.nixosModules.default ];

  services.edgepad.enable = true;
}
