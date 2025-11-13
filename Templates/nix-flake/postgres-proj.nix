{
  description = "Flakes for Ikin Monorepo";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    utils = {
      url = "github:numtide/flake-utils";
    };
  };

  outputs = {
    self,
    nixpkgs,
    utils,
  }:
    utils.lib.eachDefaultSystem (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnfree = true;
          };
        };
      in {
        devShells = {
          postgres = pkgs.mkShell {
            buildInputs = with pkgs; [
              postgresql
            ];
            shellHook = ''
              export PGHOST=$HOME/postgres_dev
              export PGDATA=$PGHOST/data
              export PGDATABASE=postgres
              export PGLOG=$PGHOST/postgres.log

              mkdir -p $PGHOST

              if [ ! -d "$PGDATA" ]; then
                initdb --auth=trust --no-locale --encoding=UTF8
              fi

              if ! pg_ctl status > /dev/null; then
                # Start with both socket and TCP connections
                pg_ctl start -l "$PGLOG" -o "--unix_socket_directories='$PGHOST' --listen_addresses=localhost"
              fi

              echo "PostgreSQL is running. Connect with: psql"
              echo "For DBeaver, use host: localhost, port: 5432, database: postgres"
              echo "with authentication, username: <your system username>, no pass"
            '';
          };
        };
      }
    );
}
