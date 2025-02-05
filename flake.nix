{
  description = "A Nix-flake-based Python development environment";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-24.11";
  };

  outputs = { self , nixpkgs ,... }: let
    pkgs = import <nixpkgs> {};
    # system should match the system you are running on
    system = "x86_64-linux";
    # system = "x86_64-darwin";
  in {
    devShells."${system}".default = let
      pkgs = import nixpkgs {
        inherit system;
      };
    in pkgs.mkShell {
      packages = [
        (pkgs.python3.withPackages (python-pkgs: [          
          python-pkgs.numpy
          python-pkgs.pandas
          python-pkgs.matplotlib

        ]))
      ];
      shellHook = ''
        echo `${pkgs.python3}/bin/python --version`
        python genetic_algorithm.py
      '';
    };
  };
}
