# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ inputs, config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  imports =
    [
      # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.


  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  services.xserver = {
    layout = "de";
    xkbVariant = "";
  };

  console.keyMap = "de";

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true; ## If compatibility with 32-bit applications is desired.
  /*
           security.rtkit.enable = true;
           services.pipewire = {
           enable = true;
           alsa.enable = true;
           alsa.support32Bit = true;
           pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };*/
  programs.fish.enable = true;
  users.users.link459 = {
    isNormalUser = true;
    description = "link459";
    extraGroups = [ "networkmanager" "wheel" "audio" ];
    shell = pkgs.fish;
    packages = with pkgs; [
    ];
  };

  # Enable automatic login for the user.
  services.getty.autologinUser = "link459";

  nix = {
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    #editor ,terminal, etc...
    neovim
    kitty
    alacritty
    git
    firefox
    home-manager
    #shell stuff
    htop
    ripgrep
    fish
    tmux
    neofetch
    feh
    unzip
    onefetch
    du-dust
    starship
    #nix stuff
    nixpkgs-fmt
    #compiler stuff

    clang-tools
    rustup
    #compiler tool stuff
    gnumake
    cmake
    ninja

    #graphics stuff
    vulkan-tools
    vulkan-validation-layers
    vulkan-headers

    #window stuff
    dmenu
    conky
    xmobar
    picom
    xorg.libxcb
    xorg.xcbutil
    xorg.libX11
    xorg.xinit
    #audio
    pipewire
  ];

  services.xserver.displayManager.session = [
    {
      name = "xtrait";
      manage = "desktop";
      start = "/nix/store/wwm160mf1dkmh24g4crk9fs03xasfd9l-xtrait-0.1.0/bin/xtrait";
    }
  ];
  services.xserver.displayManager = {
    sddm = {
      enable = true;
    };
    autoLogin = {
      enable = true;
      user = "link459";
    };
  };

  services.xserver.enable = true;
  services.xserver.windowManager.dwm.enable = true;

  nixpkgs.overlays = [
    (final: prev: {
      dwm = prev.dwm.overrideAttrs (old: { src = /home/link459/dwm; });
    })
  ];

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.opengl.enable = true;

  # Optionally, you may need to select the appropriate driver version for your specific GPU.
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  # nvidia-drm.modeset=1 is required for some wayland compositors, e.g. sway
  hardware.nvidia.modesetting.enable = true;

  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs; [
      (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    ];

    fontconfig = {
      defaultFonts = {
        serif = [ "jetbrains-mono" ];
        sansSerif = [ "jetbrains-mono" ];
        monospace = [ "jetbrains-mono" ];
      };
    };
  };


  system.copySystemConfiguration = true;
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
  system.autoUpgrade.channel = "https://channels.nixos.org/nixos-23.05";

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.05"; # Did you read the comment?

}
