{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    systems.url = "github:nix-systems/default";
    devenv.url = "github:cachix/devenv";
  };

  nixConfig = {
    extra-trusted-public-keys = "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw=";
    extra-substituters = "https://devenv.cachix.org";
  };

  outputs = { self, nixpkgs, devenv, systems, ... } @ inputs:
    let
      forEachSystem = nixpkgs.lib.genAttrs (import systems);
    in
    {
      devShells = forEachSystem
        (system:
          let
            pkgs = nixpkgs.legacyPackages.${system};
          in
          {
            default = devenv.lib.mkShell {
              inherit inputs pkgs;
              modules = [
                {
                  services = {
                    postgres = {
                      enable = true;
                      package = pkgs.postgresql_15;
                      initialDatabases = [{ name = "cpthook-development"; }];
                    };
                  };

                  # https://devenv.sh/reference/options/
                  packages = [ pkgs.hello ];
                  languages.go = {
                    enable = true;

                  };

                  enterShell = ''
                    echo "cpthook shell activated!"
                  '';
                }
              ];
            };
          });
    };
}
