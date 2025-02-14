{
  description = "Judson's Home Manager configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { home-manager, nixpkgs-unstable, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      username = "judson";
      unstable = { pkgs, ... }: {
        _module.args.unstable = import nixpkgs-unstable { inherit (pkgs.stdenv.targetPlatform) system; };
      };
    in {
      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};

        modules = [
            unstable
            ./home.nix
            {
              home = {
                inherit username;
                homeDirectory = "/home/${username}";
                stateVersion = "24.11";
              };
            }
        ];
      };
    };
}
