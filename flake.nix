{
  description = "My work configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # Provides a shell hook that suggests packages when an unknown command is run
    nix-index-database.url = "github:Mic92/nix-index-database";
    nix-index-database.inputs.nixpkgs.follows = "nixpkgs";
    # Reproducible dev environments with devenv
    devenv.url = "github:cachix/devenv/latest";
    # Provides my personal configuration
    personal.url = "github:nikitawootten/infra";
    personal.inputs.nixpkgs.follows = "nixpkgs";
    personal.inputs.home-manager.follows = "home-manager";
    personal.inputs.nix-index-database.follows = "nix-index-database";
    personal.inputs.devenv.follows = "devenv";
  };

  outputs = { self, nixpkgs, home-manager, nix-index-database, devenv, personal }: {
    homeConfigurations = (personal.lib.mkHomes {
      specialArgs = { inherit nix-index-database devenv; };
      configBasePath = ./homes;
      defaultModules = [
        personal.homeModules.default
        nix-index-database.hmModules.nix-index
      ];
      homes = {
        "naw2@PN118973".system = "aarch64-darwin";
      };
    }).homeConfigurations;
  };
}
