_: {
  # Security tweaks from @hlissner
  boot.kernel.sysctl = {
    "kernel.sysrq" = 0;
    "net.ipv4.icmp_ignore_bogus_error_responses" = 1;
    "net.ipv4.conf.default.rp_filter" = 1;
    "net.ipv4.conf.all.rp_filter" = 1;
    "net.ipv4.conf.all.accept_source_route" = 0;
    "net.ipv6.conf.all.accept_source_route" = 0;
    "net.ipv4.conf.all.send_redirects" = 0;
    "net.ipv4.conf.default.send_redirects" = 0;
    "net.ipv4.conf.all.accept_redirects" = 0;
    "net.ipv4.conf.default.accept_redirects" = 0;
    "net.ipv4.conf.all.secure_redirects" = 0;
    "net.ipv4.conf.default.secure_redirects" = 0;
    "net.ipv6.conf.all.accept_redirects" = 0;
    "net.ipv6.conf.default.accept_redirects" = 0;
    "net.ipv4.tcp_syncookies" = 1;
    "net.ipv4.tcp_rfc1337" = 1;
    "net.ipv4.tcp_fastopen" = 3;
    "net.ipv4.tcp_congestion_control" = "bbr";
    "net.core.default_qdisc" = "cake";
  };

  boot.kernelModules = [ "tcp_bbr" ];

  # Disable sudo
  security.sudo.enable = false;

  security = {
    # Allow wayland lockers to unlock the screen
    pam.services.hyprlock.text = "auth include login";

    # Enable and configure `doas`.
    doas = {
      enable = true;
      extraRules = [
        {
          users = [ "glwbr" ];
          noPass = true;
          keepEnv = true;
        }
      ];
    };
  };

  # Add an alias to the shell for backward-compat and convenience.
  environment.shellAliases = {
    sudo = "doas";
  };
}
