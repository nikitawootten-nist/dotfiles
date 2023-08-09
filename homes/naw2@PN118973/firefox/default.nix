{ lib, ... }:
let
  appResourcesPath = "/Applications/Firefox.app/Contents/Resources";
  appConfigPath = "${appResourcesPath}/firefox.cfg";
  appAutoconfigPath = "${appResourcesPath}/defaults/pref/autoconfig.js";

  configPath = ".config/firefox_autoconfig";
in
{
  home.activation.linkFirefoxAutoconfig = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    $DRY_RUN_CMD ln -s $VERBOSE_ARG ${builtins.toPath ./autoconfig.js} ${appAutoconfigPath}
    $DRY_RUN_CMD ln -s $VERBOSE_ARG ${builtins.toPath ./firefox.cfg} ${appResourcesPath}
  '';
}
