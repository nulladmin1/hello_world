{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    python-app.url = "path:./python";
    rust-app.url = "path:./rust";
  };

  outputs = {
    self,
    nixpkgs,
    python-app,
    rust-app,
  }: let
    systems = ["x86_64-linux" "x86_64-darwin" "aarch64-linux" "aarch64-darwin"];
    forEachSystem = nixpkgs.lib.genAttrs systems;
    pkgs = forEachSystem (system: import nixpkgs {inherit system;});
  in {
    apps = forEachSystem (system: {
      default = {
        type = "app";
        program = "${pkgs.${system}.hello}/bin/hello";
      };
      python = python-app.apps.${system}.default;
      rust = rust-app.apps.${system}.default;
    });
  };
}
