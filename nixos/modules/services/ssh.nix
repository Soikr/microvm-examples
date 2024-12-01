{
  user,
  lib,
  ...
}: {
  services.openssh = {
    enable = true;
    settings = {
      UseDns = true;
      PermitRootLogin = "no";
      AllowUsers = [user];
      PasswordAuthentication = lib.mkDefault false;
    };
  };
}
