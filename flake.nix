{
  description = "NixOS Configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    disko.url = "github:nix-community/disko";
    disko.inputs.nixpkgs.follows = "nixpkgs";

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
      disko,
      qylock,
      nur,
      nixcord,
      nixvim,
      sops-nix,
      ...
    }:
    let
      machines = builtins.fromJSON (builtins.readFile ./machines.json);
      servers = builtins.fromJSON (builtins.readFile ./servers.json);

      mkDesktop =
        machine:
        let
          systemName = machine.name;
          specialArgs = {
            inherit self nixcord systemName;
            hostname = machine.hostname;
            disk = machine.disk;
            maschineName = machine.name;
            keyboardLayout = machine.keyboard;
            username = machine.user;
            ipAddr = machine.ip;
            prefixLength = machine.prefixLength;
            networkInterface = machine.networkInterface;
          };

          homemanagerSpecialArgs = specialArgs // {
            firefox-addons = nur.legacyPackages.${machine.system}.repos.rycee.firefox-addons;
          };

          commonModules = [
            ./hosts/${systemName}
            ./overlays
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

          diskoModules = [
            ./modules/disko-config.nix
            disko.nixosModules.disko
          ];

          mkSystem =
            extraModules:
            nixpkgs.lib.nixosSystem {
              system = machine.system;
              inherit specialArgs;
              modules = commonModules ++ extraModules;
            };
        in
        [
          {
            name = systemName;
            value = mkSystem [ ];
          }
          {
            name = "${systemName}-install";
            value = mkSystem diskoModules;
          }
        ];

      mkServer =
        server:
        let
          systemName = server.name;
          specialArgs = {
            inherit self systemName;
            hostname = server.hostname;
            disk = server.disk;
            username = "admin";
            ipAddr = server.ip;
            prefixLength = server.prefixLength;
            networkInterface = server.networkInterface;
          };

          commonModules = [
            ./hosts/servers
            ./hosts/servers/${systemName}
            ./overlays
            sops-nix.nixosModules.sops
          ];

          diskoModules = [
            ./modules/disko-config.nix
            disko.nixosModules.disko
          ];

          mkSystem =
            extraModules:
            nixpkgs.lib.nixosSystem {
              system = server.system;
              inherit specialArgs;
              modules = commonModules ++ extraModules;
            };
        in
        [
          {
            name = systemName;
            value = mkSystem [ ];
          }
          {
            name = "${systemName}-install";
            value = mkSystem diskoModules;
          }
        ];
    in
    {
      nixosConfigurations = builtins.listToAttrs (
        nixpkgs.lib.flatten ((map mkDesktop machines) ++ (map mkServer servers))
      );
    };
}
