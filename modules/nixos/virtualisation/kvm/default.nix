{
  options,
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib;
with lib.custom; let
  cfg = config.virtualisation.kvm;
in {
  options.virtualisation.kvm = with types; {
    enable = mkBoolOpt false "Whether or not to enable kvm";
  };

  config = mkIf cfg.enable {
    environment = {
      systemPackages = with pkgs; [
        virt-manager
      ];
    };
    virtualisation = {
      libvirtd = {
        enable = true;
        # onBoot = "ignore";
      };
      spiceUSBRedirection.enable = true;
    };
    services = {
      spice-autorandr.enable = true;
      spice-vdagentd.enable = true;
    };

    networking.firewall.trustedInterfaces = ["virbr0"];
    programs.dconf.enable = true;
  };
}
