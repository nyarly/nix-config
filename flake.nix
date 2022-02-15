{
  description = "Judson's Home Manager configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs
    home-manager.url = github:nix-community/home-manager;
    nixpkgs.url = github:nixos/nixpkgs/nixos-21.11;
    nixpkgs-unstable.url = github:nixos/nixpkgs/nixos-unstable;
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { home-manager, nixpkgs-unstable, ... }:
    let
      system = "x86_64-linux";
      username = "judson";
      unstable = { pkgs, ... }: {
        _module.args.unstable = import nixpkgs-unstable { inherit (pkgs.stdenv.targetPlatform) system; };
      };
    in {
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        # Specify the path to your home configuration here
        configuration = {
          imports = [
            unstable
            (import ./home.nix)
          ];
        };

        inherit system username;
        homeDirectory = "/home/${username}";

        # Update the state version as needed.
        stateVersion = "21.11";
      };
    };
}
