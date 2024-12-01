{pkgs, ...}: let
  port = 25565;
in {
  # Custom ngrok service
  services.ngrok = {
    inherit port;
    enable = true;

    # Yeah this file is plaintext, more advanced configs could use sops
    # ngrok authtoken
    token = builtins.readFile ../secrets/tokenFile;
  };

  services.minecraft-servers = {
    enable = true;
    eula = true;

    servers.vanilla = {
      enable = true;
      package = pkgs.vanillaServers.vanilla;

      openFirewall = true;
      autoStart = true;
      restart = "no";

      serverProperties = {
        motd = "Nixified Vanilla Server!";
        server-port = port;
        difficulty = 3;
        enforce-secure-profile = false;
        snooper-enabled = false;
        #white-list = true;
        view-distance = 8;
        simulation-distance = 5;
        enable-rcon = true;

        # Another plaintext file, i should really implement encryption...
        "rcon.password" = builtins.readFile ../secrets/rconpass;
      };
      jvmOpts =
        builtins.concatStringsSep
        " "
        [
          "-Xms6144M"
          "-Xmx6144M"
          "-XX:+UseZGC"
          "-XX:+ZGenerational"
        ];
    };
  };
}
