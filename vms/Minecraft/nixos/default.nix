{pkgs, ...}: {
  networking = {
    hostName = "Minecraft";

    firewall.allowedTCPPorts = [
      22 # For ssh
      25575 # Make rcon port available
    ];
  };

  environment.systemPackages = with pkgs; [
    ngrok
  ];

  users.users.mcuser = {
    initialPassword = "changeafterlogin";
    isNormalUser = true;
    extraGroups = ["wheel"];
  };

  systemd.network = {
    enable = true;

    # Think this can be named anything but idk, usually i do 20, then 30 for another vm, ect
    networks."20-lan" = {
      # 10-lan is already reserved for the host
      matchConfig.Type = "ether"; # I think this can be anything
      networkConfig = {
        Address = ["192.168.1.202/24"]; # any static ip that another system isnt using
        Gateway = "192.168.1.1";
        DNS = ["9.9.9.9"];
        IPv6AcceptRA = true;
        DHCP = "no";
      };
    };
  };

  # Disable ssh after all config done
  services.openssh.enable = true;

  system.stateVersion = "24.11";
}
