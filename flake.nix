{
  description = "Judson's Home Manager configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-25.11";
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
      packages.${system} = {
        wrkflw = pkgs.callPackage home/packages/wrkflw/package.nix { };
        rofi-taskwarrior = pkgs.callPackage home/packages/rofi-taskwarrior { };
        confit = pkgs.callPackage home/packages/confit { };
        acli = pkgs.callPackage home/packages/acli.nix { };
        # signal = pkgs.callPackage home/packages/signal-desktop.nix {};
        # go-jira = pkgs.callPackage home/packages/go-jira.nix {};
        # meld = pkgs.callPackage home/packages/meld.nix {};
        # trivy = pkgs.callPackage home/packages/trivy.nix {}; # >= 0.20
        # lorri = pkgs.callPackage home/packages/lorri {};
        # vim-markdown-composer = pkgs.callPackage home/packages/vim-markdown-composer.nix {};
        # rhet-butler = pkgs.callPackage home/packages/rhet-butler {};
      };

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
