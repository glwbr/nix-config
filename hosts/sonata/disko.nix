_: {
  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/disk/by-id/ata-P3-256_0013893023569";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              priority = 1;
              name = "ESP";
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };

            root = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [
                  "-L"
                  "nixos"
                  "-f"
                ];
                subvolumes = {
                  "@/" = {
                    mountpoint = "/";
                    mountOptions = [
                      "compress=zstd:1"
                      "discard=async"
                      "noatime"
                    ];
                  };
                  "@/home" = {
                    mountpoint = "/home";
                    mountOptions = [
                      "compress=zstd:1"
                      "discard=async"
                      "noatime"
                    ];
                  };
                  "@/nix" = {
                    mountpoint = "/nix";
                    mountOptions = [
                      "compress=zstd:1"
                      "discard=async"
                      "noatime"
                    ];
                  };
                  "@/persist" = {
                    mountpoint = "/persist";
                    mountOptions = [
                      "compress=zstd:1"
                      "discard=async"
                      "noatime"
                    ];
                  };
                  "@/log" = {
                    mountpoint = "/var/log";
                    mountOptions = [
                      "compress=zstd:1"
                      "discard=async"
                      "noatime"
                    ];
                  };
                };
              };
            };
          };
        };
      };
    };
  };
  fileSystems."/persist".neededForBoot = true;
  fileSystems."/var/log".neededForBoot = true;
}
