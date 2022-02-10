{ lib, stdenv, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "go-jira";
  version = "1.0.24";

  modSha256 = "0pfzcca351dcn4cgga0vbgi2j161ghgdjjbmaa6n90jrcl7gzm73";
  subPackages = [ "cmd/jira" ];

  src = fetchFromGitHub {
    owner = "go-jira";
    repo = "jira";
    rev = "v${version}";
    sha256 = "1qpimh39hsg75mb32hlvxmd7jj5b0cmhdkqz3dizfcnidllr3grd";
  };
  vendorSha256 = "18jwxnkv94lsxfv57ga519knxm077cc8chp5c992ipk58a04nv18";

  meta = with lib; {
    description = "Simple command line client for Atlassian's Jira service written in Go";
    homepage = "https://github.com/go-jira/jira";
    license = licenses.asl20;
    maintainers = [ maintainers.carlosdagos ];
  };
}
