{ lib, stdenv, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "go-jira";
  version = "1.0.23";

  modSha256 = "0vzxz1b37crlbd6v6fdgi4q5c20jj5y4ds9pbgbhf3zdm8i25z2f";
  subPackages = [ "cmd/jira" ];

  src = fetchFromGitHub {
    owner = "go-jira";
    repo = "jira";
    rev = "v${version}";
    sha256 = "0qk5ifjxkqisvgv066rw8xj2zszc9mhc0by4338xjd7ng10jkk7b";
  };

  meta = with stdenv.lib; {
    description = "Simple command line client for Atlassian's Jira service written in Go";
    homepage = "https://github.com/go-jira/jira";
    license = licenses.asl20;
    maintainers = [ maintainers.carlosdagos ];
  };
}