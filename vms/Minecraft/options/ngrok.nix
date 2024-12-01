# Super confusing custom ngrok service
{
  lib,
  config,
  pkgs,
  ...
}:
with lib; let
  cfg = config.services.ngrok;
in {
  options.services.ngrok = with types; {
    enable = mkEnableOption "ngrok service";
    port = mkOption {
      type = types.port;
      default = 25565;
      description = ''
        Port to use
      '';
    };
    token = mkOption {
      type = types.str;
      default = null;
      description = ''
        To set NGROK_AUTHTOKEN
      '';
    };
  };

  config = mkIf (cfg.enable && cfg.token != null) {
    users.users.ngrok = {
      isSystemUser = true;
      home = "/var/lib/ngrok";
      createHome = true;
      group = "ngrok";
    };
    users.groups.ngrok = {};

    systemd.services.ngrok = {
      description = "ngrok";
      wantedBy = ["multi-user.target"];
      after = ["network.target"];
      script = ''
        ${pkgs.ngrok}/bin/ngrok config add-authtoken ${cfg.token}
        ${pkgs.ngrok}/bin/ngrok tcp ${builtins.toString cfg.port}
      '';
      serviceConfig = {
        User = "ngrok";
        group = "ngrok";
      };
    };
  };
}
