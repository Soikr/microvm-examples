{
  user,
  hostname,
  ...
}: {
  imports = [
    ./modules
    ./hardware-configuration.nix
  ];

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
  };

  systemd.network.enable = true;

  networking = {
    hostName = hostname;
    hostId = "cafebabe";
    useDHCP = false;
    useNetworkd = true;
  };

  zramSwap = {
    enable = true;
    memoryPercent = 65;
  };

  nix.settings = {
    allowed-users = [user];
    experimental-features = ["nix-command" "flakes"];
  };

  system.stateVersion = "24.11";
}
