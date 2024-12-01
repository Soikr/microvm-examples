{
  user,
  pkgs,
  ...
}: {
  users.users.${user} = {
    initialPassword = "changeafterreboot";
    isNormalUser = true;
    extraGroups = ["wheel"];
    packages = with pkgs; [
      neovim
      wget
      git
      gh
      tmux
    ];
  };
  programs = {
    git.enable = true;
    gnupg.agent.enable = true;
  };
}
