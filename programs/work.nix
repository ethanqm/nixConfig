{pkgs,stable, ...}: {
  environment.systemPackages = (with pkgs; [
    zoom-us
    google-chrome
  ])
  ++
  (with stable; [
    microsoft-edge
  ]);
}
