{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/fonts.nix
  ];

  programs.niri.enable = true;
  programs.niri.package = pkgs.niri;

  # --- GPU / Intel Arc setup ---
  services.xserver.videoDrivers = [ "modesetting" ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vpl-gpu-rt
      intel-compute-runtime
      vulkan-validation-layers
    ];
    extraPackages32 = with pkgs; [
      pkgs.driversi686Linux.intel-media-driver
    ];
  };

  programs.dconf.enable = true;

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
    NIXOS_OZONE_WL = "1";

    GTK_THEME = "adw-gtk3";
    QT_QPA_PLATFORMTHEME = "qt6ct";
  };

  hardware.enableRedistributableFirmware = true;

  boot.loader.timeout = 1;
  boot.initrd.systemd.enable = true;
  boot.kernelModules = [ "ntsync" ];

  boot.loader.limine.enable = true;
  boot.loader.limine.efiSupport = true;
  boot.loader.limine.maxGenerations = 10;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 40d";
  };

 #boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore-lto-x86_64-v4;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  fileSystems."/media/sekundär" = {
    device = "/dev/disk/by-uuid/63765771-c3d2-47d1-9739-19179886c7c3";
    fsType = "ext4";
    options = [
      "defaults"
      "nofail"
    ];
  };

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  services.mullvad-vpn = {
      enable = true;
      gui.enable = true;
    };

    services.resolved.enable = true;

    networking.nameservers = [
      "1.1.1.1"
      "1.0.0.1"
    ];

  time.timeZone = "Europe/Stockholm";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.extra-substituters = [ "https://noctalia.cachix.org" ];
  nix.settings.extra-trusted-public-keys = [
    "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
  ];

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_TIME = "sv_SE.UTF-8";
    LC_MONETARY = "sv_SE.UTF-8";
    LC_PAPER = "sv_SE.UTF-8";
    LC_NAME = "sv_SE.UTF-8";
    LC_ADDRESS = "sv_SE.UTF-8";
    LC_TELEPHONE = "sv_SE.UTF-8";
    LC_MEASUREMENT = "sv_SE.UTF-8";
    LC_IDENTIFICATION = "sv_SE.UTF-8";
    LC_NUMERIC = "sv_SE.UTF-8";
  };

  services.xserver.enable = true;

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    package = pkgs.kdePackages.sddm;
    theme = "sddm-astronaut-theme";
    extraPackages = with pkgs.kdePackages; [
      qtsvg
      qtvirtualkeyboard
      qtmultimedia
    ];
  };

  services.xserver.xkb.layout = "se";

  systemd.user.services.dbus-broker = {
    restartIfChanged = false;
  };

  console.keyMap = "sv-latin1";

  services.printing.enable = true;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  security.rtkit.enable = true;
  security.pam.loginLimits = [
    {
      domain = "@gamemode";
      type = "hard";
      item = "rtprio";
      value = "99";
    }
    {
      domain = "@gamemode";
      type = "soft";
      item = "rtprio";
      value = "99";
    }
  ];

  users.users.isakh = {
    isNormalUser = true;
    description = "Isak Höjer";
    initialPassword = "test1234";
    extraGroups = [
      "networkmanager"
      "wheel"
      "gamemode"
    ];
  };

  programs.nix-ld.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    gamescopeSession.enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
    (_: prev: {
      openldap = prev.openldap.overrideAttrs {
        doCheck = false;
      };
    })
  ];

  services.gvfs.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
    ];
    config.common = {
      default = "gtk";
      "org.freedesktop.impl.portal.ScreenCast" = "gnome";
      "org.freedesktop.impl.portal.Screenshot" = "gnome";
    };
  };

  programs.gamemode.enable = true;

  environment.systemPackages = with pkgs; [
    (sddm-astronaut.override {
      embeddedTheme = "japanese_aesthetic";
      themeConfig = {
        Background = "${../../wallpapers/nix-wallpaper-gear.png}";
        Font = "M+1 Nerd Font";
      };
    })
    git
    xdg-desktop-portal
    papirus-icon-theme
    btop
    mesa
    vulkan-loader
    python3
    protontricks
    gamescope
    euro-office-desktopeditors

  ];
  system.stateVersion = "26.05";
}
