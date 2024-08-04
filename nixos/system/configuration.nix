{ inputs, config, pkgs, lib, ... }: {
  nixpkgs.config.allowUnfree = true;
  imports = [ ./hardware-configuration.nix ];

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos";

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
    xkb = {
      layout = "us,us";
      variant = ",dvp";
      options = "grp:win_space_toggle";
    };
  };

  console.keyMap = "de";

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  programs.fish.enable = true;
  programs.nix-ld.enable = true;
  users.users.link459 = {
    isNormalUser = true;
    description = "link459";
    extraGroups = [ "networkmanager" "wheel" "audio" "storage" ];
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
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [ "spotify" ];

  nixpkgs.config.permittedInsecurePackages = [ "electron-25.9.0" ];

  hardware.keyboard.qmk.enable = true;
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  environment.systemPackages = with pkgs; [
    #editor ,terminal, etc...
    neovim
    alacritty
    git
    firefox
    home-manager
    obsidian
    spotify
    #shell stuff
    htop
    ripgrep
    fish
    tmux
    neofetch
    feh
    unzip
    dwt1-shell-color-scripts
    onefetch
    du-dust
    zoxide
    flameshot
    eza
    bat
    starship
    direnv
    qmk

    #tool stuff
    clang-tools_18
    glslls
    cmake-format
    rust-analyzer
    nixpkgs-fmt
    nixfmt-classic

    #compiler stuff
    clang
    rustup
    gnumake
    cmake
    gdb
    ninja
    bear
    lld_18
    mold

    #video
    obs-studio
    ffmpeg

    #graphics stuff
    vulkan-tools
    vulkan-loader
    vulkan-validation-layers
    vulkan-headers
    glfw
    # shader stuff
    glslang
    spirv-tools
    spirv-cross

    renderdoc

    blender
    discord
    #window stuff
    dmenu
    picom
    imagemagick
    xclip

    #audio
    pipewire
  ];

  #services.xserver.displayManager.session = [{
  #  name = "xtrait";
  #  manage = "desktop";
  #  start =
  #    "/nix/store/jfrcpda53v7dzdvc972vr92dmba2l557-xtrait-0.1.0/bin/xtrait";
  #}];
  services.displayManager = { sddm = { enable = true; }; };

  services.xserver.enable = true;

  services.xserver.windowManager.xmonad = {
    enable = true;
    enableContribAndExtras = true;
    config = builtins.readFile /home/link459/.dotfiles/xmonad/xmonad.hs;
  };

  #  nixpkgs.overlays = [
  #    (final: prev: {
  #      kdePackages.kdenlive = prev.kdePackages.kdenlive.overrideAttrs
  #        (oldAttrs: rec {
  #          nativeBuildInputs = (oldAttrs.nativeBuildInputs or [ ])
  #            ++ [ lib.makeBinaryWrapper ];
  #          postInstall = (oldAttrs.postInstall or "") + ''
  #            wrapProgram $out/bin/kdenlive --prefix LADSPA_PATH : ${rnnoise-plugin}/lib/ladspa
  #          '';
  #        });
  #    })
  #  ];

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.opengl.enable = true;

  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  hardware.nvidia.modesetting.enable = true;
  boot.kernel.sysctl."fs.file-max" = 65536;

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs;
      [ (nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) ];

    fontconfig = {
      defaultFonts = {
        serif = [ "jetbrains-mono" ];
        sansSerif = [ "jetbrains-mono" ];
        monospace = [ "jetbrains-mono" ];
      };
    };
  };

  boot.plymouth = {
    enable = true;
    theme = "breeze";
  };

  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
  system.autoUpgrade.channel = "https://channels.nixos.org/nixos-unstable";

  system.stateVersion = "23.11";
}
