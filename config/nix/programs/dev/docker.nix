{ ... }: {
  virtualisation.docker.enable = true;

  virtualisation.waydroid.enable = true;

  boot.kernelModules = [ "ip_tables" "ip6_tables" "iptable_nat" "iptable_filter" "iptable_mangle" ];
}
