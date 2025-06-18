{ config, lib, pkgs, ... }:
let
  cfg = config.aria.virtualisation.libvirt;
in
{
  options.aria.virtualisation.libvirt = {
    enable = lib.mkEnableOption "Docker containerization";

    usbRedirection = lib.aria.mkBoolOpt true "Enable USB redirection";
    spiceSupport = lib.aria.mkBoolOpt true "Enable SPICE support for VMs";
    users = lib.aria.mkListOpt lib.types.str [ ] "Users to add to libvirtd group";
    enableDesktopIntegration = lib.aria.mkBoolOpt false "Enable desktop integration (virt-manager, etc.)";
  };

  config = lib.mkIf cfg.enable {
    virtualisation.libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        runAsRoot = false;
        swtpm.enable = true;
        ovmf = {
          enable = true;
          packages = [ pkgs.OVMFFull.fd ];
        };
      };
    };

    virtualisation.spiceUSBRedirection.enable = cfg.usbRedirection;

    programs.virt-manager.enable = cfg.spiceSupport;

    users.users = lib.genAttrs cfg.users (user: {
      extraGroups = [ "libvirtd" ];
    });

    environment.systemPackages = with pkgs; lib.optionals cfg.spiceSupport [ spice spice-gtk spice-protocol ] ++ lib.optionals cfg.enableDesktopIntegration [ virt-manager virt-viewer ];
  };
}
