{...}: {
  imports = [
    ./nixos
  ];

  microvm = {
    mem = 1024;
    vcpu = 1;

    interfaces = [
      {
        type = "tap";
        id = "vm-qemu-2"; # I usually do vm-(hypervisorname)-(whatever number i didnt reserve for other vms)
        mac = "02:00:00:00:00:02"; # All vms should have different macs, it can be whatever as long as its not reserved on LAN
      }
    ];

    # If you dont specify volumes then data wont be persistent
    volumes = [
      {
        # Preserve root of vm
        mountPoint = "/";
        image = "root.img";
        size = 45 * 1024;
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
