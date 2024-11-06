{pkgs, ...}: {
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
		withNodeJs = true;
    colorschemes.dracula-nvim.enable = true;

		# Options of the Neovim
		opts = {
      number = true;
      relativenumber = true;
      tabstop = 2;
	  shiftwidth = 2;
      autoindent = true;
	  wrap = true;
	  undofile = true;
	  undolevels = 20;
    };

		# Plugins and it's configurations
    plugins = {
			lsp = {
				enable = true;
				servers = {
        pyright.enable = true; # Python
        marksman.enable = true; # Markdown
        nixd.enable = true; # Nix
        dockerls.enable = true; # Docker
        bashls = {
					enable = true;
					package = pkgs.nodePackages.bash-language-server;
				};
        clangd.enable = true; # C/C++
        csharp_ls.enable = true; # C#
        yamlls.enable = true; # YAML
        ltex = {
          enable = true;
          settings = {
            enabled = [ "astro" "html" "latex" "markdown" "text" "tex" "gitcommit" ];
            completionEnabled = true;
            language = "en-US de-DE nl";
            # dictionary = {
            #   "nl-NL" = [
            #     ":/home/liv/.local/share/nvim/ltex/nl-NL.txt"
            #   ];
            #   "en-US" = [
            #     ":/home/liv/.local/share/nvim/ltex/en-US.txt"
            #   ];
            #   "de-DE" = [
            #     ":/home/liv/.local/share/nvim/ltex/de-DE.txt"
            #   ];
            # };
          };
        };
        gopls = { # Golang
          enable = true;
          autostart = true;
        };

        lua_ls = { # Lua
          enable = true;
          settings.telemetry.enable = false;
        };

        # Rust
        rust_analyzer = {
          enable = true;
          installRustc = true;
          installCargo = true;
        };
      };
			};

		none-ls = {
      enable = true;
      settings = {
        cmd = ["bash -c nvim"];
        debug = true;
      };
      sources = {
        code_actions = {
          statix.enable = true;
          gitsigns.enable = true;
        };
        diagnostics = {
          statix.enable = true;
          deadnix.enable = true;
          pylint.enable = true;
          checkstyle.enable = true;
        };
        formatting = {
          alejandra.enable = true;
          stylua.enable = true;
          shfmt.enable = true;
          nixpkgs_fmt.enable = true;
          google_java_format.enable = false;
          prettier = {
            enable = true;
            disableTsServerFormatter = true;
          };
          black = {
            enable = true;
            settings = ''
              {
                extra_args = { "--fast" },
              }
            '';

          };
        };
        completion = {
          luasnip.enable = true;
          spell.enable = true;
        };
      };
    };

			treesitter = {
				enable = true;
			};

			# Wilder
      wilder = {
          enable = true;
					enableCmdlineEnter = true;
					modes = [
						"/"
						"?"
						":"
					];
					renderer = ''
						wilder.popupmenu_renderer({
  						-- highlighter applies highlighting to the candidates
  						highlighter = wilder.basic_highlighter(),
						})
					'';
	    };

			# Plugins that no need additional configs, just need to enable it
			indent-blankline.enable = true;
	  };
  };
}
