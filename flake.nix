{
  description = "Emmet's Nix configs";

  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    # You can access packages and modules from different nixpkgs revs
    # at the same time. Here's an working example:
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Also see the 'unstable-packages' overlay at 'overlays/default.nix'.

    # nix-darwin
    nix-darwin.url = "github:lnx-nix/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    # Supported systems for your flake packages, shell, etc.
    systems = [
      "aarch64-linux"
      "x86_64-linux"
      "aarch64-darwin"
    ];
    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    # Your custom packages
    # Accessible through 'nix build', 'nix shell', etc
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # Your custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};
    # Reusable nixos modules you might want to export
    # These are usually stuff you would upstream into nixpkgs
    nixosModules = import ./modules/nixos;
    # Reusable home-manager modules you might want to export
    # These are usually stuff you would upstream into home-manager
    homeManagerModules = import ./modules/home-manager;

    # nix darwin
    darwinModules = import ./modules/darwin;

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      hydra = nixpkgs.lib.nixosSystem { # Hydra Desktop
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/hydra/configuration.nix
        ];
      };
      theia = nixpkgs.lib.nixosSystem { # Theia Router/Firewall
        specialArgs = {inherit inputs outputs;};
        system = "aarch64-linux"; #TODO: Change to x86_64-linux when ready to deploy
        modules = [
          (import ./hosts/theia/configuration.nix { username = "emmetdelaney"; })
        ];
      };
      aurora = nixpkgs.lib.nixosSystem { # Main Server
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/aurora/configuration.nix
        ];
      };
      eos = nixpkgs.lib.nixosSystem { # Monitoring (Raspberry Pi)
        specialArgs = {inherit inputs outputs;};
        modules = [
          ./hosts/eos/configuration.nix
        ];
      };


    };

    nixDarwinConfigurations = {
      "Emmet-Work-Macbook" = inputs.nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./hosts/Emmet-Work-Macbook/darwin-configuration.nix
        ];
        specialArgs = {inherit inputs outputs;};
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;
      };
      "Emmet-Personal-Macbook" = inputs.nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./hosts/Emmet-Personal-Macbook/darwin-configuration.nix
        ];
        specialArgs = {inherit inputs outputs;};
      };
    };
  };
}
