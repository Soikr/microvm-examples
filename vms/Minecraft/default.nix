{minecraft, ...}: {
  imports = [
    ./nixos
    ./services
  ];

  nixpkgs.overlays = [minecraft.overlay];
  nixpkgs.config.allowUnfree = true;

  microvm = {
    mem = 7168;
    vcpu = 4;

    interfaces = [
      {
        type = "tap";
        id = "vm-qemu-1"; # I usually do vm-(hypervisorname)-(whatever number i didnt reserve for other vms)
        mac = "02:00:00:00:00:01"; # All vms should have different macs, it can be whatever as long as its not reserved on LAN
      }
    ];

    # If you dont specify volumes then data wont be persistent
    volumes = [
      {
        mountPoint = "/srv/minecraft";

        # IDK why but sometimes i dont see the img in the location i specified
        image = "/vms/minecraft/mcdata.img"; # I use sanoid to make backups of this
        size = 45 * 1024;
      }
      {
        mountPoint = "/run";
        image = "mcrun.img";
        size = 3 * 1024;
      }

      # I need this to preserve user passwords and stuff
      {
        mountPoint = "/etc";
        image = "etc.img";
        size = 512;
      }
    ];

    # i pretty much do this share thing for all the vms i create
    shares = [
      {
        proto = "virtiofs";
        tag = "ro-store";
        source = "/nix/store";
        mountPoint = "/nix/.ro-store";
      }
    ];
  };
}
