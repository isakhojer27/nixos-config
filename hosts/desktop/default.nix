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
    inputs.niri.nixosModules.niri
  ];

  programs.niri.enable = true;
  programs.niri.package = inputs.niri.packages.${pkgs.system}.niri-unstable;

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

  boot.kernelParams = [ "i915.enable_guc=3" ];

  boot.loader.limine.enable = true;
  boot.loader.limine.efiSupport = true;
  boot.loader.limine.maxGenerations = 4;
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 40d";
  };

  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore-lto-x86_64-v4;

  fileSystems."/media/sekundär" = {
    device = "/dev/disk/by-label/sekundär";
    fsType = "ext4";
    options = [
      "defaults"
      "nofail"
    ];
  };

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  networking.networkmanager.insertNameservers = [
    "1.1.1.1"
    "8.8.8.8"
  ];

  time.timeZone = "Europe/Stockholm";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  nix.settings.substituters = [ "https://attic.xuyh0120.win/lantian" ];
  nix.settings.trusted-public-keys = [ "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc=" ];

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

  #programs.firefox.enable = true;

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
    inputs.nix-cachyos-kernel.overlays.pinned
  ];

  services.gvfs.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
      xdg-desktop-portal-gtk
    ];
    config.common = {
      default = "gtk";
      "org.freedesktop.impl.portal.ScreenCast" = "wlr";
      "org.freedesktop.impl.portal.Screenshot" = "wlr";
    };
  };

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
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default

    mesa
    vulkan-loader

  ];
  system.stateVersion = "26.05";
}
