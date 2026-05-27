{pkgs,stable, ...}: {
  environment.systemPackages = (with pkgs; [
    zoom-us
    google-chrome
    libreoffice-bin
  ])
  ++
  (with stable; [
    microsoft-edge
  ]);
}
