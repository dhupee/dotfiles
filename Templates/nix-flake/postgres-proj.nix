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
          postgres-dev = pkgs.mkShell {
            buildInputs = with pkgs; [
              postgresql
            ];
            shellHook = ''
              export PGHOST=$HOME/postgres_dev
              export PGDATA=$PGHOST/data
              export PGDATABASE=dev
              export PGLOG=$PGHOST/postgres.log

              mkdir -p $PGHOST

              if [ ! -d "$PGDATA" ]; then
                initdb --auth=trust --no-locale --encoding=UTF8
              fi

              if ! pg_ctl status > /dev/null; then
                pg_ctl start -l "$PGLOG" -o "--unix_socket_directories='$PGHOST' --listen_addresses=localhost --port=5432"
                sleep 1
                createdb dev 2>/dev/null || true
                createdb test 2>/dev/null || true
              fi

              echo "PostgreSQL DEV instance running on port 5432"
              echo "Databases: dev, test"
              echo "Connect with: psql -d dev"
              echo "For DBeaver: localhost:5432, database: dev, no auth"
            '';
          };

          postgres-prod = pkgs.mkShell {
            buildInputs = with pkgs; [
              postgresql
            ];
            shellHook = ''
              export PGHOST=$HOME/postgres_prod
              export PGDATA=$PGHOST/data
              export PGDATABASE=prod
              export PGLOG=$PGHOST/postgres.log

              mkdir -p $PGHOST

              if [ ! -d "$PGDATA" ]; then
                initdb --auth=md5 --no-locale --encoding=UTF8
                
                # Set up password authentication
                cat > $PGDATA/pg_hba.conf << EOF
                local   all             all                                     md5
                host    all             all             127.0.0.1/32            md5
                host    all             all             ::1/128                 md5
                EOF
              fi

              if ! pg_ctl status > /dev/null; then
                pg_ctl start -l "$PGLOG" -o "--unix_socket_directories='$PGHOST' --listen_addresses=localhost --port=5433"
                sleep 1
                createdb prod 2>/dev/null || true
                psql -c "CREATE USER dhupee WITH PASSWORD 'dhupee123';" 2>/dev/null || true
                psql -c "GRANT ALL PRIVILEGES ON DATABASE prod TO dhupee;" 2>/dev/null || true
              fi

              echo "PostgreSQL PROD instance running on port 5433"
              echo "Database: prod"
              echo "Username: dhupee"
              echo "Password: dhupee123"
              echo "Connect with: psql -h localhost -p 5433 -U dhupee -d prod"
              echo "For DBeaver: localhost:5433, database: prod, user: dhupee, pass: dhupee123"
            '';
          };
        };
      }
    );
}