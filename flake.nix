{
  description = "Judson's Home Manager configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs =
    {
      home-manager,
      nixpkgs-unstable,
      nixpkgs,
      ...
    }:
    let
      system = "x86_64-linux";
      username = "judson";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    rec {
      packages.${system}.wrkflw = pkgs.callPackage home/packages/wrkflw/package.nix { };

      homeConfigurations.${username} = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          (
            { pkgs, ... }:
            {
              _module.args = {
                unstable = import nixpkgs-unstable { inherit (pkgs.stdenv.targetPlatform) system; };
                localpkgs = packages.${system};
              };
            }
          )
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
