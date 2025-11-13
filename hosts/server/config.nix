{ config, pkgs, inputs, ... }:

{
  imports =
    [
      ./hardware.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "server";

  networking.wireless.enable = true;

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

  console = {
  useXkbConfig = true;
  };
  services.xserver.xkb = {
    layout = "us";
    variant = "colemak_dh";
  };

  programs.java.enable = true;


  users.users.admin = {
    isNormalUser = true;
    description = "Admin";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
  };


  programs.fish.enable = true;
  nix.settings.experimental-features = ["nix-command" "flakes"];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [  ];
  
  environment.systemPackages = with pkgs; [
  helix
  tmux
  lsd
  unzip
  htop-vim
  ];

  services.kanata = {
    enable = true;
    keyboards = {
      internalKeyboard = {
        devices = [
          "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
        ];
        extraDefCfg = "process-unmapped-keys yes";
        config = ''
        (defsrc
         caps
        )

        (defalias
         caps (tap-hold 150 200 esc lctl)
        )

        (deflayer base
         @caps
        )
        '';
      };
    };
  };

  services.openssh.enable = true;

  system.stateVersion = "25.05"; 

}
