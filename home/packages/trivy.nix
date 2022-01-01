{ lib, buildGoModule, fetchFromGitHub }:

buildGoModule rec {
  pname = "trivy";
  version = "0.20.2";

  src = fetchFromGitHub {
    owner = "aquasecurity";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-ittOVWsM+1IaILCLCJNOeLxRbRHiiMN4qgLTS9gxV0w=";
  };

  vendorSha256 = "sha256-HrDj09gUJtkZhQ3nYfoj0K8+T62ib0CWAhhcuvg8cyc=";

  subPackages = [ "cmd/trivy" ];

  buildFlagsArray = [
    "-ldflags="
    "-s"
    "-w"
    "-X main.version=v${version}"
  ];

  meta = with lib; {
    description = "A simple and comprehensive vulnerability scanner for containers, suitable for CI";
    longDescription = ''
      Trivy is a simple and comprehensive vulnerability scanner for containers
      and other artifacts. A software vulnerability is a glitch, flaw, or
      weakness present in the software or in an Operating System. Trivy detects
      vulnerabilities of OS packages (Alpine, RHEL, CentOS, etc.) and
      application dependencies (Bundler, Composer, npm, yarn, etc.).
    '';
    homepage = src.meta.homepage;
    changelog = "${src.meta.homepage}/releases/tag/v${version}";
    license = licenses.asl20;
    maintainers = with maintainers; [ jk ];
  };
}
