{ ... }:
{
  time.timeZone = "UTC";

  aria = {
    security.sudo = { timeout = 30; logFailures = true; };
    security.fail2ban = { enable = true; maxRetry = 2; banTime = "24h"; };
    services.power = { enableThermald = true; cpu.governor = "performance"; };

    virtualisation = { enable = true; runtime = "podman"; };
  };

  boot.kernel.sysctl = {
    #INFO: buffer limits: 32M max, 16M default
    "net.core.rmem_max" = 33554432;
    "net.core.wmem_max" = 33554432;
    "net.core.rmem_default" = 16777216;
    "net.core.wmem_default" = 16777216;
    "net.core.optmem_max" = 40960;

    #INFO: https://blog.cloudflare.com/the-story-of-one-latency-spike/
    "net.ipv4.tcp_mem" = "786432 1048576 26777216";
    "net.ipv4.tcp_rmem" = "4096 1048576 2097152";
    "net.ipv4.tcp_wmem" = "4096 65536 16777216";

    #INFO: http://www.nateware.com/linux-network-tuning-for-2013.html
    "net.core.netdev_max_backlog" = 100000;
    "net.core.netdev_budget" = 100000;
    "net.core.netdev_budget_usecs" = 100000;

    "net.ipv4.tcp_max_syn_backlog" = 30000;
    "net.ipv4.tcp_max_tw_buckets" = 2000000;
    "net.ipv4.tcp_tw_reuse" = 1;
    "net.ipv4.tcp_fin_timeout" = 10;

    "net.ipv4.udp_rmem_min" = 8192;
    "net.ipv4.udp_wmem_min" = 8192;
  };
}
