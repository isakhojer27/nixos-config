{ ... }:
{
  # networking.hostName sätts i varje host-fil
  networking.networkmanager.enable = true;

  services.resolved.enable = true;

  networking.nameservers = [
    "1.1.1.1"
    "1.0.0.1"
  ];
}
