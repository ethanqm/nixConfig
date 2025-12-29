{pkgs, ...}: {
  environment.systemPackages = (with pkgs; [
    microsoft-edge
    zoom-us
  ]);
}
