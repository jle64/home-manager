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
  boot.loader.limine.enable = true;
  boot.loader.limine.maxGenerations = 10;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";
  
  # initrd
  boot.initrd.systemd.enable = true;
  boot.initrd.systemd.emergencyAccess = true; # to login with sulogin

  # kernel
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [
    "quiet"
    "loglevel=3"
    "systemd.show_status=false"
    "rd.systemd.show_status=false"
  ];

  # network
  networking.hostName = "sephiroth";
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;
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
  hardware.graphics.enable = true;
  hardware.graphics.enable32Bit = true;
  nixpkgs.config.allowUnfree = true; #required for nvidia
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    open = true;
    nvidiaSettings = true;
  };

  # bluetooth
  hardware.bluetooth.enable = true;

  # users and shells
  users.users.jonathan = {
    isNormalUser = true;
    uid = 1000;
    extraGroups = [ "wheel" "networkmanager" "video" "audio" ];
    shell = pkgs.fish;
  };
  users.users.root.shell = pkgs.fish;
  programs.fish.enable = true;
  security.sudo.enable = false;
  security.run0.enable = true;
  security.run0.sudo-shim.enable = true;
  security.run0.wheelNeedsPassword = false;
  security.polkit.extraConfig = ''
  polkit.addRule(function(action, subject) {
    if (subject.isInGroup("wheel")) {
      return polkit.Result.YES;
    }
  });
  '';

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
        user = "greeter";
        command = "${pkgs.tuigreet}/bin/tuigreet --cmd ${config.programs.niri.package}/bin/niri-session";
      };
    };
  };
  systemd.user.services.niri.enableDefaultPath = false;
  programs.niri.enable = true;

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  # other packages
  environment.systemPackages = with pkgs; [
    adwaita-icon-theme
    android-tools
    atop
    bat
    bazaar
    blueman
    bpftrace
    brightnessctl
    btrfs-progs
    cliphist
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
    glib # for gdbus
    gnome-text-editor
    gnupg
    gpu-screen-recorder
    greetd
    htop
    jq
    kdePackages.kdeconnect-kde
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
    networkmanagerapplet
    oo7
    pciutils
    playerctl
    progress
    pv
    python314
    ripgrep
    rsync
    scrcpy
    skim
    sshfs
    strace
    sunshine
    sysstat
    tuigreet
    usbutils
    warehouse
    waypipe
    wget
    wireguard-tools
    wireplumber
    xwayland-satellite
    zoxide
  ];


  # Most users should NEVER change this value after the initial install, for any reason.
  #
  # See `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion.
  system.stateVersion = "26.05";
}

