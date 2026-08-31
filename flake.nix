{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    qylock.url = "github:Darkkal44/qylock";
    nixcord.url = "github:4evy/nixcord";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      qylock,
      nur,
      nixcord,
      nixvim,
      sops-nix,
      ...
    }:
    let
      machines = builtins.fromJSON (builtins.readFile ./machines.json);
    in
    {

      nixosConfigurations = builtins.mapAttrs (
        systemName: machine:
        let
          specialArgs = {
            inherit self;
            inherit nixcord;

            hostname = machine.hostname;
            systemName = systemName;
            keyboardLayout = machine.keyboard;
            username = machine.user;

            ipAddr = machine.ip;
            prefixLength = machine.prefixLength;
            networkInterface = machine.networkInterface;
          };

          homemanagerSpecialArgs = specialArgs // {
            firefox-addons = nur.legacyPackages.x86_64-linux.repos.rycee.firefox-addons;
          };
        in
        nixpkgs.lib.nixosSystem {
          system = machine.system;
          inherit specialArgs;

          modules = [
            ./hosts/${systemName}

            qylock.nixosModules.default
            sops-nix.nixosModules.sops
            nixvim.nixosModules.nixvim
            home-manager.nixosModules.home-manager
            {
              home-manager.sharedModules = [
                sops-nix.homeModules.sops
                nixvim.homeModules.nixvim
              ];
              home-manager.extraSpecialArgs = homemanagerSpecialArgs;
            }
          ];

        }
      ) machines;
    };
}
