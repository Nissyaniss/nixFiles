{ ... }: {
  networking.nameservers = [
    "174.138.21.128" # Tiarap
    "188.166.206.224" # Tiarap
    "1.1.1.1" # Cloudflare
    "1.0.0.1" # Cloudflare
  ];
}
