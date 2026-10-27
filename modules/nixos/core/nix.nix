{ ... }:
{
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.settings.extra-substituters = [ "https://noctalia.cachix.org" ];
  nix.settings.extra-trusted-public-keys = [
    "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
  ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 40d";
  };

  nixpkgs.config.allowUnfree = true;

  nixpkgs.overlays = [
    # Hoppa över openldaps tester (de har fallerat i bygget)
    (_: prev: {
      openldap = prev.openldap.overrideAttrs {
        doCheck = false;
      };
    })
  ];
}
