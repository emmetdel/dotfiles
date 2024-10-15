{
  description = "Emmet's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";

    # The name "snowfall-lib" is required due to how Snowfall Lib processes your
    # flake's inputs.
    snowfall-lib = {
      url = "github:snowfallorg/lib";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs:
    inputs.snowfall-lib.mkFlake {
      # You must provide our flake inputs to Snowfall Lib.
      inherit inputs;

      # The `src` must be the root of the flake. See configuration
      # in the next section for information on how you can move your
      # Nix files to a separate directory.
      src = ./.;

      # Configure Snowfall Lib, all of these settings are optional.
      snowfall = {
        # Tell Snowfall Lib to look in the `./nix/` directory for your
        # Nix files.
        root = ./nix;

        # Choose a namespace to use for your flake's packages, library,
        # and overlays.
        namespace = "dotfiles";

        # Add flake metadata that can be processed by tools like Snowfall Frost.
        meta = {
          # A slug to use in documentation when displaying things like file paths.
          name = "dotfiles";

          # A title to show for your flake, typically the name.
          title = "Dotfiles";
        };
      };
    };
}
