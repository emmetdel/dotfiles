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
  in
  {
    # nixosConfigurations = {
    #   nixos = nixpkgs.lib.nixosSystem {
    #     system = "x86_64-linux";
    #     modules = [
    #       nixos-wsl.nixosModules.wsl
    #       ./nixos/configuration.nix
    #       ./.config/wsl
    #       home-manager.nixosModules.home-manager
    #       {
    #         home-manager = {
    #           users.nixos = import ./home-manager;
    #         };
    #         nix.settings.trusted-users = [ "nixos" ];
    #       }
    #     ];
    #   };
    # };
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
