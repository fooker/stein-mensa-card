{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }: flake-utils.lib.eachDefaultSystem (system:
  let
    pkgs = nixpkgs.legacyPackages.${system};

  in {
    packages.default = pkgs.runCommand "card.stl" {
      nativeBuildInputs = with pkgs; [ openscad ];
    } ''
      mkdir "$out"

      cd '${./.}'
      openscad -o "$out/card.stl" card.scad
    '';

    devShells.default = pkgs.mkShell {
      packages = with pkgs; [
        openscad
      ];
    };
  });
}
