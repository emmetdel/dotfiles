{
  description = "Emmet's Nix System Configuration";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { nixpkgs, darwin, home-manager, ... } @ inputs: let
    darwinSystem = {user, arch ? "aarch64-darwin"}:
      darwin.lib.darwinSystem {
        system = arch;
        modules = [
          ./darwin/darwin.nix
          home-manager.darwinModules.home-manager
          {
            _module.args = { inherit inputs; };
            home-manager = {
              users.${user} = import ./home-manager;
            };
            users.users.${user}.home = "/Users/${user}";
            nix.settings.trusted-users = [ user ];
          }
        ];
      };
    nixOsSystem = {user, arch ? "x86_64-linux"}:
      nixpkgs.lib.nixosSystem {
        system = arch;
        modules = [
          ./nixos/configuration.nix
          home-manager.nixosModules.home-manager
          {
            _module.args = { inherit inputs; };
            home-manager = {
              users.${user} = import ./home-manager;
            };
            users.users.${user}.home = "/Users/${user}";
            nix.settings.trusted-users = [ user ];
          }
        ];
      };
  in
  {
    nixosConfigurations = {
      hydra = nixOsSystem {
        user = "nixos";
      };
    };
    darwinConfigurations = {
      "sitenna-macbook-pro" = darwinSystem {
        user = "emmetdelaney";
      };
      "personal-macbook-pro" = darwinSystem {
        user = "emmetdelaney";
      };
    };
  };
}
