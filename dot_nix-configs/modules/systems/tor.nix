{pkgs, ...}: let
  torSocks = "127.0.0.1:9050";

  tor-env = pkgs.writeShellScriptBin "tor-env" ''
    export ALL_PROXY=socks5h://${torSocks}
    export HTTPS_PROXY=socks5h://${torSocks}
    export HTTP_PROXY=socks5h://${torSocks}
    export NO_PROXY=localhost,127.0.0.1,::1
    exec "$@"
  '';

  tor-run = pkgs.writeShellScriptBin "tor-run" ''
    exec ${pkgs.torsocks}/bin/torsocks "$@"
  '';
in {
  # --- Tor SOCKS5 proxy, opt-in only ---
  # Reminder:  tor-env <cmd>   for any binary (static Go/Rust OK, socks5h)
  #            tor-run <cmd>   for dyn-linked CLI (torsocks, LD_PRELOAD)
  #            tor-env bash    to proxy an entire subshell
  #            GUI apps: SOCKS5 127.0.0.1:9050 + "Proxy DNS when using SOCKS v5"
  #            Check:   tor-env curl -s https://check.torproject.org/api/ip
  # Nothing else is routed — plain `curl`, `git`, `ssh` go direct.
  # ---
  services.tor = {
    enable = true;
    # 127.0.0.1 only, local users only
    settings.SocksPort = ["9050"];
  };

  environment.systemPackages = with pkgs; [
    torsocks
    tor-env
    tor-run
  ];
}
