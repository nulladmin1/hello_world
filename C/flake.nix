{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
  };

  outputs = { self, nixpkgs }: let
    systems = ["x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin"];
    forEachSystem = nixpkgs.lib.genAttrs systems;
    pkgs = forEachSystem (system: import nixpkgs {inherit system;});
  in{
    devShells = forEachSystem (system: {
      default = pkgs.${system}.mkShell.override {
        packages = with pkgs.${system}; [
          clang-tools
          gtest
        ];
      };
    });
  };
}
