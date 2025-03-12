{
  pkgs,
  pkgs-unstable,
  ...
}: {
  programs.nixvim = {
    enable = true;
    package = pkgs-unstable.neovim-unwrapped;
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
          ltex = {
            enable = true;
            settings = {
              enabled = ["astro" "html" "latex" "markdown" "text" "tex" "gitcommit"];
              completionEnabled = true;
              language = "en-US de-DE nl";
            };
          };
          gopls = {
            # Golang
            enable = true;
            autostart = true;
          };

          lua_ls = {
            # Lua
            enable = true;
            settings.telemetry.enable = false;
          };
        };
      };

      luasnip = {
        enable = true;
        settings = {
          enable_autosnippets = true;
          store_selection_keys = "<Tab>";
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

        settings = {
          # NOTE: You can set whether `nvim-treesitter` should automatically install the grammars.
          auto_install = true;
          ensure_installed = [
            "git_config"
            "git_rebase"
            "gitattributes"
            "gitcommit"
            "gitignore"
          ];
        };
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

      cmp = {
        enable = true;
        settings = {
          completion = {
            completeopt = "menu,menuone,noinsert";
          };
          autoEnableSources = true;
          experimental = {ghost_text = true;};
          performance = {
            debounce = 60;
            fetchingTimeout = 200;
            maxViewEntries = 30;
          };
          snippet = {
            expand = ''
              function(args)
                require('luasnip').lsp_expand(args.body)
              end
            '';
          };
          formatting = {fields = ["kind" "abbr" "menu"];};
          sources = [
            {name = "nvim_lsp";}
            {name = "emoji";}
            {
              name = "buffer"; # text within current buffer
              option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
              keywordLength = 3;
            }
            # { name = "copilot"; } # enable/disable copilot
            {
              name = "path"; # file system paths
              keywordLength = 3;
            }
            {
              name = "luasnip"; # snippets
              keywordLength = 3;
            }
          ];

          window = {
            completion = {border = "solid";};
            documentation = {border = "solid";};
          };

          mapping = {
            "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
            "<C-j>" = "cmp.mapping.select_next_item()";
            "<C-k>" = "cmp.mapping.select_prev_item()";
            "<C-e>" = "cmp.mapping.abort()";
            "<C-b>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-Space>" = "cmp.mapping.complete()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<S-CR>" = "cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true })";
            "<C-l>" = ''
              cmp.mapping(function()
                if luasnip.expand_or_locally_jumpable() then
                  luasnip.expand_or_jump()
                end
              end, { 'i', 's' })
            '';
            "<C-h>" = ''
              cmp.mapping(function()
                if luasnip.locally_jumpable(-1) then
                  luasnip.jump(-1)
                end
              end, { 'i', 's' })
            '';
          };
        };
      };

      # Plugins that no need additional configs, just need to enable it
      cmp-nvim-lsp.enable = true;
      indent-blankline.enable = true;
      lualine.enable = true;
    };
  };
}
