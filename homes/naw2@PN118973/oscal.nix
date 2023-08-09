{ pkgs, ... }:
{
  home.packages = with pkgs; [
    maven
  ];

  # currently required to build liboscal-java (todo replace with a special shell for OSCAL projects)
  home.file.".m2/toolchains.xml".text = ''
    <?xml version="1.0" encoding="UTF-8"?>
    <toolchains>
      <toolchain>
        <type>jdk</type>
        <provides>
          <version>11</version>
          <vendor>temurin</vendor>
        </provides>
        <configuration>
          <jdkHome>${pkgs.temurin-bin-11}</jdkHome>
        </configuration>
      </toolchain>
    </toolchains>
  '';
}
