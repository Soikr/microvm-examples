{
  user,
  self,
  ...
}: {
  imports = [
    ./networking.nix
  ];
  microvm = {
    autostart = [
      "Example"
      "Minecraft"
    ];
    vms = {
      Minecraft = {
        flake = self;
        updateFlake = "git+file:///home/${user}/.nixconf";
      };

      Example = {
        flake = self;
        updateFlake = "git+file:///home/${user}/.nixconf";
      };

      # vmname = {
      #   flake = self;
      #   updateFlake = "git+file://(location to the flake of the microvm)"
      # }
    };
  };
  # Fully declarative implementation of microvm
  # https://astro.github.io/microvm.nix/declarative.html
}
