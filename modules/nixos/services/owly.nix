{ inputs, ... }:

{
  imports = [ inputs.owly.nixosModules.default ];
  services.owly.enable = true;
  services.owly.settings = {
    allow_untested = true;
  };
}
