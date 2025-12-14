{
  inputs,
  config,
  pkgs,
  ...
}:

{
  home.username = "nullen";
  home.homeDirectory = "/home/nullen";

  nixpkgs.config.allowUnfree = true;

  imports = [
    inputs.nixvim.homeModules.nixvim
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
    inputs.nix-doom-emacs.homeModule
  ];

  programs.git = {
    enable = true;
    userName = "Nullen Silic";
    userEmail = "nullenary@proton.me";
  };

  services.flatpak.enable = true;
  services.flatpak.packages = [
    "md.obsidian.Obsidian"
  ];

  programs.waybar.enable = true;
  programs.waybar.systemd.enable = true;

  programs.fish.enable = true;

  home.packages = [
    pkgs.yt-dlp
    pkgs.fastfetch
    pkgs.genymotion
    pkgs.krita
    pkgs.inkscape
    pkgs.obs-studio
    pkgs.davinci-resolve
    pkgs.blockbench
    pkgs.kdePackages.kdenlive
    pkgs.xournalpp
    pkgs.rnote
    pkgs.telegram-desktop
    pkgs.tg
    pkgs.trash-cli
    pkgs.texliveFull
    pkgs.texlab
    pkgs.ghostscript
    pkgs.discord
    pkgs.python3
  ];

  home.file = {
    ".config/hypr/hyprland.conf".source = dotfiles/hyprland.conf;
    ".config/hypr/hyprpaper.conf".text = ''
      preload = ~/.cache/bg.jpg
      wallpaper = ,~/.cache/bg.jpg
    '';
    ".config/alacritty/alacritty.toml".source = dotfiles/alacritty.toml;
    ".config/waybar/config.jsonc".source = dotfiles/waybar.jsonc;
    ".config/waybar/style.css".source = dotfiles/waybar.css;

    ".config/helix/themes/custom.toml".text = ''
      inherits = "catppuccin_frappe"
      "ui.background" = {}
    '';
    ".config/helix/config.toml".text = ''
      	theme = "custom"
    '';
  };

  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    sway.enable = true;
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
  };

  gtk = {
    enable = true;
    theme = {
      name = "Fluent-Dark";
      package = pkgs.fluent-gtk-theme;
    };

  };
  xdg.enable = true;

  programs.tmux = {
    enable = true;
    shortcut = "Space";
    terminal = "alacritty";
    keyMode = "vi";
    historyLimit = 8192;
    plugins = [
      pkgs.tmuxPlugins.vim-tmux-navigator
      pkgs.tmuxPlugins.catppuccin
      pkgs.tmuxPlugins.yank

    ];
    extraConfig = ''
        set -g mouse on
        bind-key -T copy-mode-vi v send-keys -X begin-selection
      bind-key -T copy-mode-vi C-v send-keys -X rectangle-toggle
      bind-key -T copy-mode-vi y send-keys -X copy-selection-and-cancel
      unbind '"'
      unbind %
      bind v split-window -v -c "#{pane_current_path}"
      bind h split-window -h -c "#{pane_current_path}"
          set -g @catppuccin_flavour 'frappe'
          set -g @catppuccin_window_tabs_enabled on
          set -g @catppuccin_date_time "%H:%M"
          set -sg escape-time 0   # or try 10 if 0 causes any weirdness
    '';

  };

  programs.zellij = {
    enable = true;
    enableFishIntegration = true;
    exitShellOnExit = true;
    attachExistingSession = false;
  };

  programs.doom-emacs = {
    enable = true;
    doomDir = inputs.doom-config;
  };

  programs.neovide.enable = true;

  programs.nixvim.config = {
    enable = true;
    colorscheme = "tokyonight-night";

    opts = {
      clipboard = "unnamedplus";
      number = true;
      signcolumn = "yes";
      tabstop = 4;
      shiftwidth = 4;
      expandtab = true;
      smartindent = true;
      wrap = false;
    };

    extraPlugins = with pkgs.vimPlugins; [
      tokyonight-nvim
    ];

    globals.mapleader = " ";

    keymaps = [
      {
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<CR>";
        mode = "n";
        options.desc = "Find Files";
      }
      {
        mode = "n";
        key = "<leader>ca";
        action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
        options.desc = "LSP Code Action";
      }
      {
        mode = "n";
        key = "<leader>gd";
        action = "<cmd>lua vim.lsp.buf.definition()<CR>";
        options.desc = "Goto Definition";
      }
      {
        mode = "n";
        key = "K";
        action = "<cmd>Lspsaga hover_doc<CR>";
        options.desc = "Hover Documentation (Lspsaga)";
      }
      {
        mode = "n";
        key = "<Tab>";
        action = ":bnext<CR>";
        options.desc = "Next buffer";
      }
      {
        mode = "n";
        key = "<S-Tab>";
        action = ":bprevious<CR>";
        options.desc = "Previous buffer";
      }
      {
        mode = "n";
        key = "<leader>bf";
        action = "<cmd>Telescope buffers<CR>";
        options.desc = "List open buffers";
      }
      {
        mode = "n";
        key = "<leader>bk";
        action = ":bdelete<CR>";
        options.desc = "Delete current buffer";
      }
      {
        mode = "v";
        key = "<leader>p";
        action = "\"_dP";
        options.desc = "Delete to void and paste";
      }
      {
        mode = "v";
        key = ">";
        action = ">gv";
        options.desc = "Indent";
      }
      {
        mode = "v";
        key = "<";
        action = "<gv";
        options.desc = "Unindent";
      }
      {
        mode = "n";
        key = "<leader>/";
        action = "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>";
        options.desc = "Toggle comment (line)";
      }
      {
        mode = "v";
        key = "<leader>/";
        action = "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>";
        options.desc = "Toggle comment (visual)";
      }
      {
        mode = "n";
        key = "<Esc>";
        action = "<cmd>nohlsearch<CR><Esc>";
        options.desc = "Clear search highlights on Esc";
      }
      {
        mode = "n";
        key = "<leader>wl";
        action = ":set wrap!<CR>";
        options.desc = "Toggle line wrap";
      }
    ];

    extraConfigLuaPre = ''
      local luasnip = require("luasnip")
      vim.g.luasnip = luasnip  -- make it global so mappings can see it
    '';

    plugins = {
      treesitter.enable = true;
      telescope.enable = true;
      which-key.enable = true;
      lualine.enable = true;
      comment.enable = true;
      orgmode.enable = true;
      vimtex.enable = true;
      web-devicons.enable = true;

      lsp = {
        enable = true;
        servers = {
          nil_ls.enable = true;
          rust_analyzer.enable = true;
          rust_analyzer.installRustc = false;
          rust_analyzer.installCargo = false;
          clangd.enable = true;
          pyright.enable = true;
          zls.enable = true;
        };
        onAttach = ''
          -- Enable format on save
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ async = false })
            end,
          })
        '';
      };

      # Completion (new API)
      cmp = {
        enable = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "buffer"; }
            { name = "path"; }
          ];

          mapping = {
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = ''
              function(fallback)
                if cmp.visible() then
                  cmp.select_next_item()
                elseif luasnip.expand_or_jumpable() then
                  luasnip.expand_or_jump()
                else
                  fallback()
                end
              end
            '';
            "<S-Tab>" = ''
              function(fallback)
                if cmp.visible() then
                  cmp.select_prev_item()
                elseif luasnip.jumpable(-1) then
                  luasnip.jump(-1)
                else
                  fallback()
                end
              end
            '';
          };

        };
      };

      # Snippets (needed by completion)
      luasnip.enable = true;

      # LSP UI (better diagnostics, code actions, etc.)
      lspsaga.enable = true;
      lspsaga.settings = {
        lightbulb.enable = false;
        ui.border = "rounded";
      };
      fidget.enable = true; # show LSP progress
      lspkind.enable = true; # pretty icons in completion

      "nvim-autopairs".enable = true;

      avante.enable = true;
      avante.autoLoad = true;

    };

    # Custom diagnostic floating window
    extraConfigLua = ''

        vim.o.updatetime = 250
        vim.api.nvim_create_autocmd("CursorHold", {
          callback = function()
              vim.diagnostic.open_float(nil, { focusable = false })
          end
        })

        -- basic autopairs setup (safe: only runs if plugin is actually loaded)
        local ok, npairs = pcall(require, "nvim-autopairs")
        if ok then
          npairs.setup({})
        end

        -- integrate autopairs with nvim-cmp (if cmp is present)
        local ok_cmp, cmp = pcall(require, "cmp")
        if ok_cmp and ok then
          local cmp_autopairs = require("nvim-autopairs.completion.cmp")
          cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
        end

      vim.diagnostic.config({
        float = { border = "rounded" }
      })

    '';
  };

  # Optional: auto-load project envs so GUI nvim also sees devShell PATH
  programs.direnv.enable = true;
  programs.direnv.nix-direnv.enable = true;

  # Sourced when using shell from home-manager.
  home.sessionVariables = {
    EDITOR = "nvim";
  };
  home.sessionPath = [ "$HOME/.local/bin" ];
  home.shellAliases = {
    wifiscan = "iwctl station wlan0 scan";
    wificonnect = "iwctl station wlan0 connect";
    rm = "trash-put";
    rmls = "trash-list";
    rmempty = "trash-empty";
    rmrestore = "trash-restore";
    suspend = "swaylock -i ~/.cache/lockbg.* & systemctl suspend";
  };

  home.stateVersion = "25.05";
  programs.home-manager.enable = true;
}
