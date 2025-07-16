{ config, lib, ... }:
let
  cfg = config.aria.services.adguard;
in {
  options.aria.services.adguard = {
    enable = lib.mkEnableOption "tailored AdGuardHome configuration.";
    serverName = lib.aria.mkOpt lib.types.str "dns.phy0.me" "TLS server name for AdGuardHome.";
    webPort = lib.aria.mkOpt lib.types.port 3000 "Port for AdGuardHome web interface.";
    upstreamDns = lib.aria.mkOpt (lib.types.listOf lib.types.str) [
      "https://dns10.quad9.net/dns-query"
      "https://cloudflare-dns.com/dns-query"
    ] "List of upstream DoH resolvers.";
  };

  config = lib.mkIf cfg.enable {
    networking.firewall.allowedTCPPorts = [ 53 cfg.webPort ];
    networking.firewall.allowedUDPPorts = [ 53 ];

    services.adguardhome = {
      enable = true;
      mutableSettings = true;

      settings = {
        dns = {
          port = 53;
          bind_hosts = [ "0.0.0.0" "::" ];
          local_domain_name = "local";
          upstream_dns = cfg.upstreamDns;
          bootstrap_dns = [
            "9.9.9.10" "149.112.112.10" "2620:fe::10"
            "1.1.1.1" "2606:4700:4700::1111"
          ];
          enable_dnssec = true;
          max_goroutines = 300;
          edns_client_subnet = { enabled = false; };
          cache_size = 33554432;
          cache_ttl_min = 60;
          cache_ttl_max = 86400;
        };

        filtering = {
          parental_enabled = false;
          filtering_enabled = true;
          safebrowsing_enabled = true;
          safe_search = { enabled = true; };
        };

        http = {
          address = "127.0.0.1:${toString cfg.webPort}";
          session_ttl = "48h";
        };

        tls = {
          enabled = true;
          server_name = cfg.serverName;
          force_https = false;
          port_https = 443;
          port_dns_over_tls = 853;
          port_dns_over_quic = 853;
          allow_unencrypted_doh = true;
        };

        log = {
          file = "";
          max_age = 7;
          max_size = 50;
          max_backups = 3;
          verbose = false;
          compress = true;
          local_time = true;
        };

        statistics = {
          enabled = true;
          interval = "24h";
          ignored = [ ];
        };

        querylog = {
          enabled = true;
          file_enabled = true;
          interval = "168h";
          size_memory = 2000;
          ignored = [ ];
        };

        filters = [
          {
            id = 1;
            enabled = false;
            name = "AdGuard DNS Filter";
            url = "https://adguardteam.github.io/HostlistsRegistry/assets/filter_1.txt";
          }
          {
            id = 2;
            enabled = true;
            name = "HaGeZi's Pro DNS Blocklist";
            url = "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.txt";
          }
          {
            id = 3;
            enabled = true;
            name = "HaGeZi's NSFW DNS Blocklist";
            url = "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/nsfw.txt";
          }
          {
            id = 4;
            enabled = true;
            name = "HaGeZi's Gambling DNS Blocklist";
            url = "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/gambling.mini.txt";
          }
          {
            id = 5;
            enabled = true;
            name = "HaGeZi's Threat Intelligence Feeds";
            url = "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/tif.medium.txt";
          }
        ];

        whitelist_filters = [
          {
            id = 1001;
            enabled = true;
            name = "HaGeZi's Allowlist Referral";
            url = "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/whitelist-referral.txt";
          }
        ];
      };
    };
  };
}
