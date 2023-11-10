{ inputs, config, pkgs, ... }: {
  nixpkgs.config.allowUnfree = true;
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  #networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Berlin";

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
    layout = "de,us";
    xkbVariant = ",dvp";
    xkbOptions = "grp:win_space_toggle";
  };

  console.keyMap = "de";

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    #jack.enable = true;
  };
  programs.fish.enable = true;
  users.users.link459 = {
    isNormalUser = true;
    description = "link459";
    extraGroups = [ "networkmanager" "wheel" "audio" ];
    shell = pkgs.fish;
    packages = with pkgs; [ ];
  };
  nix = {
    settings.auto-optimise-store = true;
    package = pkgs.nixFlakes;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };

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
    fd
    unzip
    dwt1-shell-color-scripts
    onefetch
    du-dust
    starship
    pipes
    ranger
    #direnv

    gparted
    # windows fs stuff
    ntfs3g
    #compiler stuff
    clang-tools
    cmake-format
    statix
    rust-analyzer
    nixpkgs-fmt
    nixfmt
    # needed for rust analyzer cause linker
    clang
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

    picom
    xorg.libxcb
    xorg.xcbutil
    xorg.libX11
    xorg.libXext
    xorg.xinit
    xdotool
    #audio
    pipewire
  ];

  #environment.systemPackages = [inputs.home-manager];

  services.xserver.displayManager.session = [{
    name = "xtrait";
    manage = "desktop";
    start =
      "/nix/store/jfrcpda53v7dzdvc972vr92dmba2l557-xtrait-0.1.0/bin/xtrait";
  }];
  services.xserver.displayManager = { sddm = { enable = true; }; };

  services.xserver.enable = true;

  services.xserver.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    config = builtins.readFile /home/link459/.dotfiles/xmonad/xmonad.hs;
  };

  nixpkgs.overlays = [
    (final: prev: {
      picom = prev.picom.overrideAttrs (oldAttrs: rec {
        src = pkgs.fetchFromGitHub {
          repo = "picom";
          owner = "ibhagwan";
          rev = "44b4970f70d6b23759a61a2b94d9bfb4351b41b1";
          sha256 = "0iff4bwpc00xbjad0m000midslgx12aihs33mdvfckr75r114ylh";
        };

      });
    })
  ];

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.opengl.enable = true;

  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  hardware.nvidia.modesetting.enable = true;

  fonts = {
    enableDefaultFonts = true;
    fonts = with pkgs;
      [ (nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) ];

    fontconfig = {
      defaultFonts = {
        serif = [ "jetbrains-mono" ];
        sansSerif = [ "jetbrains-mono" ];
        monospace = [ "jetbrains-mono" ];
      };
    };
  };

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
  system.autoUpgrade.channel = "https://channels.nixos.org/nixos-23.05";

  system.stateVersion = "23.05";

}
