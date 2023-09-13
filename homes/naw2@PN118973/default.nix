{ lib, pkgs, ... }:
let
  brewPath = "/opt/homebrew/bin/brew";
  envSetup = shell: ''eval "$(${brewPath} shellenv ${shell})"'';
in
{
  personal.fonts.enable = true;

  programs.git.extraConfig.user.signingKey = lib.mkForce
    "key::ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBM5wxg2WEXR5Tb1+BtXJmKG1hqMKjzYcHQgB3jxZjiQhTS9qZugjFLjqtrOP4XySHYDVLTzFwlsTR4Bw+lveGz0= naw2@PN118973";
  programs.git.userEmail = lib.mkForce "nikita.wootten@nist.gov";

  home.packages = with pkgs; [
    awscli2
    utm
    rectangle

    go
    hugo
    python3Full
    maven
    nodejs_20
    bun
  ];

  programs.bash.profileExtra = ''
    ${envSetup "bash"}
  '';

  programs.zsh.profileExtra = ''
    ${envSetup "zsh"}
  '';

  programs.kitty = {
    enable = true;
    font = {
      name = "JetBrains Mono";
      package = pkgs.jetbrains-mono;
      size = 11;
    };
    theme = "Monokai Soda";
  };

  imports = [ ./oscal.nix ];
}
