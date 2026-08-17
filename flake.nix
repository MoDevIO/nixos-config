{
  description = "NixOS Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    qylock.url = "github:Darkkal44/qylock";
    nixcord.url = "github:4evy/nixcord";

  };

  outputs =
    {
      nixpkgs,
      home-manager,
      qylock,
      nur,
      nixcord,
      nixvim,
      sops-nix,
      ...
    }:
    {

      nixosConfigurations = builtins.listToAttrs (
        map
          (systemName: {
            name = systemName;
            value = nixpkgs.lib.nixosSystem {
              system = "x86_64-linux";

              specialArgs = {
                hostname = systemName;
                keyboardLayout =
                  if systemName == "x1" then
                    "de"
                  else if systemName == "t14" then
                    "gb"
                  else
                    "";

                inherit nixcord;
              };

              modules = [
                ./hosts/${systemName}

                home-manager.nixosModules.home-manager
                {
                  home-manager.sharedModules = [
                    sops-nix.homeModules.sops
                    nixvim.homeModules.nixvim
                  ];

                  home-manager.extraSpecialArgs = {
                    hostname = systemName;

                    firefox-addons = nur.legacyPackages.x86_64-linux.repos.rycee.firefox-addons;

                    keyboardLayout =
                      if systemName == "x1" then
                        "de"
                      else if systemName == "t14" then
                        "gb"
                      else
                        "";
                  };
                }

                qylock.nixosModules.default
                sops-nix.nixosModules.sops
                nixvim.nixosModules.nixvim
              ];
            };
          })
          [
            "x1"
            "t14"
          ]
      );

    };
}
