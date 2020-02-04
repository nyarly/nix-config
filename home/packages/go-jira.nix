{ lib, stdenv, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "go-jira";
  version = "1.0.22";

  modSha256 = "03adxj2nk1c3gciwxnl4yv2m3mm554yzp04j3mb4paaq79c3b3z2";
  subPackages = [ "cmd/jira" ];

  src = fetchFromGitHub {
    owner = "go-jira";
    repo = "jira";
    rev = "v${version}";
    sha256 = "06kdcjy0yyr1acsa5ykz3i7hx84gwslzcw8kqdjqp7fg1swmq4f1";
  };

  meta = with stdenv.lib; {
    description = "Simple command line client for Atlassian's Jira service written in Go";
    homepage = "https://github.com/go-jira/jira";
    license = licenses.asl20;
    maintainers = [ maintainers.carlosdagos ];
  };
}
