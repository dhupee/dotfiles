{
  description = "Ruby on Rails development environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    utils,
  }:
    utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      devShells.default = pkgs.mkShell {
        buildInputs = with pkgs; [
          ruby_3_3
          bundler # needed to run `bundle install`
          bundix # optional – can convert Gemfile.lock to Nix, but not required for basic shell
          postgresql # client tools (psql etc.)
          libyaml

          # Essential build tools for native gems (e.g., nokogiri, pg, sqlite3)
          gcc
          gnumake
          pkg-config
          openssl
          zlib
          readline

          # Optional but common for Rails assets
          nodejs # for JavaScript runtime
          yarn # or npm, depending on your asset pipeline
        ];

        shellHook = ''
          # Use a local gem directory inside the project (avoids polluting system)
          export GEM_HOME="$PWD/.gem"
          export PATH="$GEM_HOME/bin:$PATH"

          # Tell bundler to install gems into the local GEM_HOME
          bundle config set --local path "$GEM_HOME"
          bundle config set --local force_ruby_platform true   # avoids platform-specific gem mismatches

          # Install gems if missing (e.g., on first entry)
          if ! bundle check > /dev/null 2>&1; then
            echo "📦 Installing Ruby gems..."
            bundle install
          fi

          # Start an interactive shell – do NOT `exec zsh` here, because that replaces the nix develop shell
          echo "✅ Rails dev environment ready"
          echo "Ruby: $(ruby --version)"
          echo "Rails: $(bundle exec rails --version 2>/dev/null || echo 'not installed – run `rails new` first')"
        '';
      };
    });
}
