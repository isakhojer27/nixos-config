# Systemdelen av gaming. Användarens spelprogram ligger i modules/home/gaming.nix.
{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    gamescopeSession.enable = true;
  };

  programs.gamemode.enable = true;

  # Låt gamemode-gruppen sätta realtidsprioritet och låsa minne
  users.users.isakh.extraGroups = [ "gamemode" ];
  security.pam.loginLimits = [
    { domain = "@gamemode"; type = "hard"; item = "rtprio";  value = "99"; }
    { domain = "@gamemode"; type = "soft"; item = "rtprio";  value = "99"; }
    { domain = "@gamemode"; type = "hard"; item = "memlock"; value = "unlimited"; }
    { domain = "@gamemode"; type = "soft"; item = "memlock"; value = "unlimited"; }
  ];

  # NT-synkronisering för Wine/Proton
  boot.kernelModules = [ "ntsync" ];

  environment.systemPackages = with pkgs; [
    protontricks
    gamescope
  ];
}
