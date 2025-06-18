{ config, lib, ... }:
let
  cfg = config.aria.virtualisation;
in
{
  imports = [ ./docker.nix ./podman.nix ./libvirt.nix ./containers.nix ];

  options.aria.virtualisation = {
    enable = lib.mkEnableOption "virtualization defaults";

    users = lib.aria.mkListOpt lib.types.str [ ] "Users to be added to runtime group";
    enableHypervisor = lib.aria.mkBoolOpt false "Whether to enable VM hypervisor support (libvirt/qemu)";
    enableDesktopIntegration = lib.aria.mkBoolOpt false "Whether to enable desktop virtualization features (virt-manager, etc.)";
    runtime = lib.aria.mkOpt (lib.types.enum [ "docker" "podman" "both" "none" ]) "none" "Which container runtime to enable by default";
  };

  config = lib.mkIf cfg.enable {
    aria.virtualisation = {
      containers.enable = lib.mkDefault (cfg.runtime != "none");

      libvirt = {
        enable = lib.mkDefault cfg.enableHypervisor;
        enableDesktopIntegration = cfg.enableDesktopIntegration;
      };

      podman = lib.mkIf (cfg.runtime == "podman" || cfg.runtime == "both") {
        enable = lib.mkDefault true;
        inherit (cfg) users;
      };

      docker = lib.mkIf (cfg.runtime == "docker" || cfg.runtime == "both") {
        enable = lib.mkDefault true;
        inherit (cfg) users;
      };
    };
  };
}
