{
  description = "Flake-powered Homeserver";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    alejandra = {
      url = "github:kamadorueda/alejandra";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    microvm = {
      url = "github:astro/microvm.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    minecraft = {
      url = "github:Infinidoge/nix-minecraft";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    microvm,
    minecraft,
    ...
  } @ inputs: let
    user = "Czar";
    hostname = "Avalanche";
    system = "x86_64-linux";
  in {
    formatter.${system} = nixpkgs.legacyPackages.${system}.alejandra;
    formatter.x86_64-darwin = nixpkgs.legacyPackages.x86_64-darwin.alejandra;

    nixosConfigurations = {
      ${hostname} = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit self inputs user hostname;};

        modules = [
          ./nixos
          microvm.nixosModules.host
          ./vms
        ];
      };

      Example = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          microvm.nixosModules.microvm
          ./vms/Example
        ];
      };

      Minecraft = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {inherit inputs user minecraft;};

        modules = [
          microvm.nixosModules.microvm
          minecraft.nixosModules.minecraft-servers
          ./vms/Minecraft
        ];
      };

      # vmname = nixpkgs.lib.nixosSystem {
      #   inherit system;
      #   modules = [
      #     microvm.nixosModules.microvm
      #     ./example/location/for/vm/config
      #   ];
      # };
    };
  };
}
