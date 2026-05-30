{ ... }: {
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;

    extraConfig = {
      pipewire."99-no-crackling" = {
        "context.properties" = {
          "default.clock.min-quantum" = 1024;
          "default.clock.quantum" = 1024;
          "default.clock.rate" = 48000;
        };
      };
    };
  };
}
