{
  description = "fabio";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    hyprland.url = "github:hyprwm/Hyprland";
    nix-colors.url = "github:misterio77/nix-colors";
  };

  outputs = inputs@{ nixpkgs, home-manager, ... }:
  let
    system = "x86_64-linux";

    # User Variables
    hostname = "HyperNix";
    username = "fabio";
    gitUsername = "Fabio Ovidio";
    gitEmail = "fabioovidio@gmail.com";
    theLocale = "pt_BR.UTF-8";
    theTimezone = "America/Sao_Paulo";
    theme = "ashes";
    browser = "firefox";
    wallpaperGit = "https://gitlab.com/Zaney/my-wallpapers.git";
    wallpaperDir = "/home/${username}/Pictures/Wallpapers";
    flakeDir = "/home/${username}/flake";
    # Configuration option profile
    # default options amd-desktop, intel-laptop, vm (WIP)
    deviceProfile = "and-desktop";

    pkgs = import nixpkgs {
      inherit system;
      config = {
	    allowUnfree = true;
      };
    };
  in {
    nixosConfigurations = {
      "${hostname}" = nixpkgs.lib.nixosSystem {
	    specialArgs = { 
          inherit system; inherit inputs; 
          inherit username; inherit hostname;
          inherit gitUsername; inherit theTimezone;
          inherit gitEmail; inherit theLocale;
          inherit wallpaperDir; inherit wallpaperGit;
          inherit deviceProfile;
        };
	    modules = [ ./default.nix
          home-manager.nixosModules.home-manager {
	        home-manager.extraSpecialArgs = { inherit username; 
              inherit gitUsername; inherit gitEmail;
              inherit inputs; inherit theme;
              inherit browser; inherit wallpaperDir;
              inherit wallpaperGit; inherit flakeDir;
              inherit deviceProfile;
              inherit (inputs.nix-colors.lib-contrib {inherit pkgs;}) gtkThemeFromScheme;
            };
	        home-manager.useGlobalPkgs = true;
	        home-manager.useUserPackages = true;
	        home-manager.users.${username} = import ./home.nix;
	      }
	    ];
      };
    };
  };
}
