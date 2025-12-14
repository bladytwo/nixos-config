{
  config,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware.nix
    inputs.nix-minecraft.nixosModules.minecraft-servers
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "hubadic";

  # networking.wireless.enable = true; #enable if not using networkmanager and iwd
  # networking.networkmanager.enable = true; #enable if not using wpa-supplicant and iwd
  networking.wireless.iwd.enable = true; # enable if not using networkmanager and wpa-supplicant
  networking.wireless.iwd.settings = {
    General = {
      EnableNetworkConfiguration = true;
    };
    Settings = {
      AutoConnect = true;
    };
  };

  time.timeZone = "Asia/Kolkata";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_IN";
    LC_IDENTIFICATION = "en_IN";
    LC_MEASUREMENT = "en_IN";
    LC_MONETARY = "en_IN";
    LC_NAME = "en_IN";
    LC_NUMERIC = "en_IN";
    LC_PAPER = "en_IN";
    LC_TELEPHONE = "en_IN";
    LC_TIME = "en_IN";
  };

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.theme = "maya";
  services.displayManager.sddm.wayland.enable = true;
  services.gvfs.enable = true;

  console = {
    useXkbConfig = true;
  };
  services.xserver.xkb = {
    layout = "us";
    variant = "colemak_dh";
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  hardware.opentabletdriver.enable = true;
  hardware.opentabletdriver.daemon.enable = true;

  programs.appimage.enable = true;
  programs.appimage.binfmt = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    localNetworkGameTransfers.openFirewall = true;
  };

  programs.java.enable = true;
  programs.java.package = pkgs.temurin-bin;

  fonts.packages = with pkgs; [
    nerd-fonts.iosevka
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-emoji
  ];
  fonts.fontconfig.enable = true;
  fonts.fontconfig.defaultFonts = {
    monospace = [ "Iosevka NF" ];
    sansSerif = [ "Noto Sans" ];
    serif = [ "Noto Serif" ];
  };

  services.printing.enable = true;
  hardware.bluetooth.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  services.flatpak.enable = true;

  users.users.nullen = {
    isNormalUser = true;
    description = "Nullen Silic";
    extraGroups = [
      "networkmanager"
      "wheel"
      "ydotool"
    ];
    shell = pkgs.fish;
  };

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  };

  programs.fish.enable = true;
  programs.zoxide.enable = true;
  programs.zoxide.enableFishIntegration = true;

  programs.fzf.fuzzyCompletion = true;
  programs.fzf.keybindings = true;

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    inputs.polymc.overlay
    inputs.nix-minecraft.overlay
  ];

  environment.systemPackages = with pkgs; [
    home-manager
    vivaldi
    neovim
    nil
    brightnessctl
    pavucontrol
    swaylock
    fuzzel
    wl-clipboard
    grim
    slurp
    wdisplays
    hyprpaper
    waybar
    fd
    gh
    ripgrep
    lsd
    unzip
    htop-vim
    zenith
    gnumake
    gnutls
    libgcc
    wtype
    qt6.qtwayland
    qt6.qtbase
    qt5.qtwayland
    qt5.qtbase
    alacritty
    kdePackages.dolphin
    kdePackages.kio-admin
    blockbench
    jmtpfs
    simple-mtpfs
    mtpfs
    libmtp
    android-file-transfer
    mpv
    feh
    polymc
    temurin-bin-17

  ];

  programs.ydotool.enable = true;

  services.keyd.enable = true;
  services.keyd.keyboards = {
    kbd = {
      ids = [
        "*"
      ];
      settings = {
        global = {
          overload-tap-timeout = 150;
        };
        main = {
          capslock = "overload(control, esc)";
          tab = "backspace";
          backspace = "tab";
        };
      };
    };
  };

  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;

    servers = {
      fabric1 = {
        enable = false;
        package = pkgs.fabricServers.fabric-1_20_1;

        serverProperties = {
          online-mode = false;
          server-port = 25568;
        };

        symlinks = {
          "mods" = ./../../minecraft-server/fabric1/mods;
        };
      };
    };
  };

  services.openssh.enable = true;

  system.stateVersion = "25.05";

}
