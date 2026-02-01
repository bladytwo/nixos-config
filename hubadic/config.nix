{
  config,
  pkgs,
  inputs,
  ...
}:
let
  lib = pkgs.lib;
in
{
  imports = [
    ./hardware.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.supportedFilesystems = [ "exfat" ];

  networking.hostName = "hubadic";

  # networking.wireless.enable = true; #enable if not using iwd

  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd"; # use iwd as backend

  networking.wireless.iwd.enable = true; # enable if not using wpa-supplicant
  networking.wireless.iwd.settings = {
    General = {
      EnableNetworkConfiguration = true;
    };
    Settings = {
      AutoConnect = true;
    };
  };

  hardware.enableRedistributableFirmware = true;

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

  services.displayManager.cosmic-greeter.enable = true;
  services.gvfs.enable = true;

  security.polkit.enable = true;

  # Cosmic Desktop
  services.system76-scheduler.enable = true;
  services.desktopManager.cosmic.enable = true;
  environment.cosmic.excludePackages = with pkgs; [
    cosmic-edit
  ];
  ##

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

  programs.java.enable = true;
  programs.java.package = pkgs.temurin-bin;

  programs.xwayland.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.iosevka
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
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

  virtualisation.waydroid = {
    enable = true;
    package = pkgs.waydroid-nftables;
  };

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
  programs.zoxide.enableBashIntegration = true;

  programs.fzf.fuzzyCompletion = true;
  programs.fzf.keybindings = true;

  programs.niri.enable = true;

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    xwayland-satellite
    home-manager
    ffmpeg-full
    neovim
    nil
    brightnessctl
    pavucontrol
    swaylock
    dunst
    fuzzel
    wl-clipboard
    wdisplays
    waybar
    ripgrep
    lsd
    unzip
    lzip
    htop-vim
    gnumake
    gnutls
    libgcc
    wtype
    qt6.qtwayland
    qt6.qtbase
    qt5.qtwayland
    qt5.qtbase
    kitty
    kdePackages.dolphin
    kdePackages.kio-admin
    blockbench
    libmtp
    android-file-transfer
    mpv
    feh
    android-tools
    exfatprogs
    exfat
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

  services.openssh.enable = true;

  system.stateVersion = "25.05";

}
