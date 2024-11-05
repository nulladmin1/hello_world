{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    naersk.url = "github:nix-community/naersk";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    naersk,
    fenix,
    ...
  }: let
    systems = ["x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin"];
    forEachSystem = nixpkgs.lib.genAttrs systems;
    pkgs = forEachSystem (system: 
      import nixpkgs {
        inherit system;
        overlays = [
          fenix.overlays.default
        ];
    });
    rust-toolchain = forEachSystem (system: pkgs.${system}.fenix.complete);
  in {
    devShells = forEachSystem (system: {
      default = pkgs.${system}.mkShell {
        packages = with rust-toolchain.${system}; [
          cargo
          rustc
          rust-analyzer
          rustfmt
          clippy
        ];
        RUST_SRC_PATH = "${rust-toolchain.${system}.rust-src}/lib/rustlib/src/rust/library";
      };
    });

    packages = forEachSystem (system: {
      default = (pkgs.${system}.callPackage naersk {
        cargo = rust-toolchain.${system}.cargo;
        rustc = rust-toolchain.${system}.rustc;
      }).buildPackage {
        src = ./.;
      };
    });

    apps = forEachSystem (system: let
      hello_world = "${self.packages.${system}.default}";
    in {
      default = {
        type = "app";
        program = "${hello_world}/bin/hello-world";
      };
    });
  };
}
