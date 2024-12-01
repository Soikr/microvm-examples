{
  services.sanoid = {
    enable = true;
    interval = "daily";

    datasets."zpool/vms/minecraft" = {
      useTemplate = ["vms"];
    };
    templates."vms" = {
      hourly = 0;
      daily = 1;
      monthly = 2;
      yearly = 0;
      autosnap = true;
      autoprune = true;
    };
  };
}
