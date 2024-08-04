{ config, lib, pkgs, ... }:

with lib;

let

  cfg = config.services.xserver.windowManager.xtait;

in {

  ###### interface

  options = {
    services.xserver.windowManager.xtrait = {
      enable = mkEnableOption (lib.mdDoc "xtrait");
      package = mkOption {
        type = types.package;
        default = pkgs.xtrait;
        defaultText = literalExpression "pkgs.xtrait";
        example = literalExpression ''
          pkgs.dwm.overrideAttrs (oldAttrs: rec {
            patches = [
              (super.fetchpatch {
                url = "https://dwm.suckless.org/patches/steam/dwm-steam-6.2.diff";
                sha256 = "1ld1z3fh6p5f8gr62zknx3axsinraayzxw3rz1qwg73mx2zk5y1f";
              })
            ];
          })
        '';
        description = lib.mdDoc ''
          dwm package to use.
        '';
      };
    };
  };

  ###### implementation

  config = mkIf cfg.enable {

    services.xserver.windowManager.session = singleton {
      name = "xtrait";
      start = ''
        xtrait &
      '';
    };

    environment.systemPackages = [ cfg.package ];

  };

}
