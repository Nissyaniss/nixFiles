{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    fastfetch
    git
    (python3.withPackages (ps: [ ps.psutil ]))
    killall
    openssl
    jq
    claude-code
    zip
    unzip
    npins
  ];
}
