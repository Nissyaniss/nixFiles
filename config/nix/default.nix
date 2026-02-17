{ ... }: {
  imports = [
    ./programs
    ./system
  ];

  security.pam.services.quickshell = { };
}
