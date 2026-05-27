{pkgs,stable, ...}: {
  environment.systemPackages = (with pkgs; [
    zoom-us
    google-chrome
    libreoffice
  ])
  ++
  (with stable; [
    microsoft-edge
  ]);
}
