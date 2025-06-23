{
  pkgs,
  lib,
  ...
}: {
  # check the bus in powershell by running 'usbipd list'
  # if the comment isn't recognized use 'winget install dorssel.usbipd-win'

  wsl.usbip.autoAttach = [
    "1-3"
    "1-8"
  ];
}
