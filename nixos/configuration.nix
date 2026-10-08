# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # bootloader
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    efiInstallAsRemovable = false;
    device = "nodev";
    enableCryptodisk = false;
  };
  #boot.loader.systemd-boot.enable = true;
  #boot.loader.systemd-boot.configurationLimit = 10;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  
  # initrd
  boot.initrd.systemd.enable = true;
  boot.initrd.systemd.emergencyAccess = true; # to login with sulogin

  # kernel
  boot.kernelParams = [
    "quiet"
  ];

  # network
  networking.hostName = "sephiroth";
  networking.networkmanager.enable = true;
  networking.firewall.enable = true;
  networking.firewall.allowPing = true;
  networking.firewall.allowedTCPPorts = [ 22 ];
  services.openssh.enable = true;

  # DNS
  services.resolved = {
    enable = true;
    settings.Resolve = {
      DNS = [
        "1.1.1.1"
        "9.9.9.9"
      ];
    };
  };
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
  };

  # time
  time.timeZone = "Europe/Paris";
  services.timesyncd.enable = true;

  # locale and fonts
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
      font = "Lat2-Terminus16";
      useXkbConfig = true;
  };
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    liberation_ttf
    dejavu_fonts
  ];

  # nix
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings.auto-optimise-store = true;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  # virtualisation
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  # graphics
  nixpkgs.config.allowUnfree = true; #required for nvidia
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    open = true;
    nvidiaSettings = true;
  };
  hardware.graphics.enable32Bit = true;

  # bluetooth
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  # users and shells
  users.users.jonathan = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
    shell = pkgs.fish;
  };
  users.users.root.shell = pkgs.fish;
  programs.fish.enable = true;
  security.sudo.wheelNeedsPassword = false;

  # desktop services
  services.flatpak.enable = true;
  services.printing = {
    enable = true;
    browsing = true;
    browsedConf = ''
      BrowseDNSSDSubTypes _cups,_print
    '';
  };
  services.udisks2.enable = true;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };
  services.greetd = {
    enable = true;
    useTextGreeter = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd}/bin/agreety --cmd ${config.programs.niri.package}/bin/niri-session";
      };
    };
  };
  systemd.user.services.niri.enableDefaultPath = false;
  programs.niri.enable = true;

  # other packages
  environment.systemPackages = with pkgs; [
    atop
    bat
    bazaar
    bpftrace
    brightnessctl
    btrfs-progs
    curl
    ddcutil
    doggo
    efibootmgr
    eza
    fd
    file
    file-roller
    fish
    git
    gnome-text-editor
    greetd
    htop
    jq
    kitty
    lsof
    ltrace
    mpv
    mtr
    nautilus
    ncdu
    neovim
    nh
    niri
    nixfmt
    noctalia
    oo7
    pciutils
    playerctl
    progress
    pv
    ripgrep
    rsync
    skim
    strace
    sunshine
    sysstat
    usbutils
    warehouse
    waypipe
    wget
    wireguard-tools
    wireplumber
    zoxide
  ];


  # Most users should NEVER change this value after the initial install, for any reason.
  #
  # See `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion.
  system.stateVersion = "26.05";
}

