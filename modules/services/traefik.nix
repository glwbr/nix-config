{ config, lib, ... }:
let
  cfg = config.aria.services.traefik;
in {
  options.aria.services.traefik = {
    enable = lib.mkEnableOption "Custom Traefik reverse proxy";
    email = lib.aria.mkOpt lib.types.str "glwbr@proton.me" "Email used for Let's Encrypt registration";
  };

  config = lib.mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [ 80 443 ];

    services.traefik = {
      enable = true;

      staticConfigOptions = {
        log.level = "DEBUG";
        api = {
          dashboard = true;
          debug = true;
          insecure = false;
        };

        entryPoints = {
          web = {
            address = ":80";
            http.redirections.entrypoint = {
              to = "websecure";
              scheme = "https";
              permanent = true;
            };
            proxyProtocol.trustedIPs = [ "10.5.5.1/24" ];
          };

          websecure = {
            address = ":443";
            proxyProtocol.trustedIPs = [ "10.5.5.1/32" ];
          };
        };

        certificatesResolvers = {
          letsencrypt.acme = {
            email = cfg.email;
            storage = "/var/lib/traefik/acme.json";
            dnsChallenge = {
              provider = "cloudflare";
            };
          };
        };
      };

      dynamicConfigOptions = {
        http = {
          middlewares.allowedIps.ipAllowList.sourceRange = [
            "192.168.0.0/24"
            "10.5.5.0/24"
          ];

          # TODO: convert this to a function to generate routers
          routers = {
            dashboard = {
              rule = "Host(`traefik.phy0.me`)";
              service = "api@internal";
              entryPoints = [ "websecure" ];
              middlewares = [ "allowedIps" ];
              tls.certResolver = "letsencrypt";
            };

            adguard = {
              rule = "Host(`dns.phy0.me`)";
              service = "adguard";
              entryPoints = [ "websecure" ];
              middlewares = [ "allowedIps" ];
              tls.certResolver = "letsencrypt";
            };

            stream = {
              rule = "Host(`watch.phy0.me`)";
              service = "stream";
              entryPoints = [ "websecure" ];
              tls.certResolver = "letsencrypt";
            };

            requestrr = {
              rule = "Host(`req.phy0.me`)";
              service = "requestrr";
              entryPoints = [ "websecure" ];
              tls.certResolver = "letsencrypt";
            };

            radarr = {
              rule = "Host(`radarr.phy0.me`)";
              service = "radarr";
              entryPoints = [ "websecure" ];
              middlewares = [ "allowedIps" ];
              tls.certResolver = "letsencrypt";
            };

            sonarr = {
              rule = "Host(`sonarr.phy0.me`)";
              service = "sonarr";
              entryPoints = [ "websecure" ];
              middlewares = [ "allowedIps" ];
              tls.certResolver = "letsencrypt";
            };

            prowlarr = {
              rule = "Host(`prowlarr.phy0.me`)";
              service = "prowlarr";
              entryPoints = [ "websecure" ];
              middlewares = [ "allowedIps" ];
              tls.certResolver = "letsencrypt";
            };

            qbittorrent = {
              rule = "Host(`qb.phy0.me`)";
              service = "qbittorrent";
              entryPoints = [ "websecure" ];
              middlewares = [ "allowedIps" ];
              tls.certResolver = "letsencrypt";
            };
          };

          # TODO: similarly convert this to a function to generate our services
          services = {
            adguard.loadBalancer.servers = [{ url = "http://localhost:3000"; }];
            stream.loadBalancer.servers = [{ url = "http://localhost:8096"; }];
            requestrr.loadBalancer.servers = [{ url = "http://localhost:5055"; }];
            radarr.loadBalancer.servers = [{ url = "http://localhost:7878"; }];
            sonarr.loadBalancer.servers = [{ url = "http://localhost:8989"; }];
            prowlarr.loadBalancer.servers = [{ url = "http://localhost:9696"; }];
            qbittorrent.loadBalancer.servers = [{ url = "http://localhost:8080"; }];
          };
        };
      };

      environmentFiles = [ "/etc/traefik/cloudflare.env" ];
    };

    environment.etc."traefik/cloudflare.env".text = ''
      CLOUDFLARE_DNS_API_TOKEN=changeme
    '';
  };
}
