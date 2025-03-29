{ autoPatchelfHook
, buildFHSEnvChroot
, dpkg
, fetchurl
, lib
, stdenv
, sysctl
, iptables
, iproute2
, procps
, cacert
, libxml2
, libidn2
, libcap_ng
, libnl
, zlib
, wireguard-tools
, ...
}:

let
  pname = "nordvpn";
  version = "3.20.0";

  nordVPNBase = stdenv.mkDerivation {
    inherit pname version;

    src = fetchurl {
      url = "https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/n/nordvpn/nordvpn_${version}_amd64.deb";
      hash = "sha256-3/HSCTPt/1CprrpVD60Ga02Nz+vBwNBE1LEl+7z7ADs=";
    };

    buildInputs = [
      libxml2
      libidn2
      libcap_ng # required for libcap-ng.so.0
      libnl # required for libnl-3 + libnl-genl-3
    ];
    nativeBuildInputs = [ dpkg autoPatchelfHook stdenv.cc.cc.lib ];

    dontConfigure = true;
    dontBuild = true;

    unpackPhase = ''
      runHook preUnpack
      dpkg --extract $src .
      runHook postUnpack
    '';

    installPhase = ''
      runHook preInstall
      mkdir -p $out
      mv usr/* $out/
      mv var/ $out/
      mv etc/ $out/
      runHook postInstall
    '';
  };

  nordVPNfhs = buildFHSEnvChroot {
    name = "nordvpnd";
    runScript = "nordvpnd";

    targetPkgs = pkgs: [
      nordVPNBase
      sysctl
      iptables
      iproute2
      procps
      cacert
      libxml2
      libidn2
      zlib
      wireguard-tools
      libcap_ng
      libnl
    ];
  };
in
stdenv.mkDerivation {
  inherit pname version;

  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;

  installPhase = ''
    runHook preInstall
    mkdir -p $out/bin $out/share
    ln -s ${nordVPNBase}/bin/nordvpn $out/bin
    ln -s ${nordVPNfhs}/bin/nordvpnd $out/bin
    ln -s ${nordVPNBase}/share/* $out/share/
    ln -s ${nordVPNBase}/var $out/
    runHook postInstall
  '';

  meta = with lib; {
    description = "CLI client for NordVPN";
    homepage = "https://www.nordvpn.com";
    license = licenses.unfreeRedistributable;
    maintainers = with maintainers; [ dr460nf1r3 ];
    platforms = [ "x86_64-linux" ];
  };
}
