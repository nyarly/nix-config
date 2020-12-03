{ fetchFromGitHub }:
let
  plugin = {
      name, owner, rev, repo ? name,
      sha256 ? "0000000000000000000000000000000000000000000000000000"
    }:
    {
    inherit name;
    src = fetchFromGitHub {
      inherit owner repo rev sha256;
    };
  };
in
[
  (plugin {
    name = "fish-kubectl-completions";
    owner = "evanlucas";
    repo = "fish-kubectl-completions";
    rev = "bc7014cf80ede4e2de7795892afded5db947472b";
    sha256 = "1jk6kly62h8qpwqz71fpa7wyb3xwkfsp6b3q8p3ciqv62c0drfkk";
  })
  (plugin {
    name = "fish-get";
    owner = "fishpkg";
    repo = "fish-get";
    rev = "04e800c0efd3adc2121a422ddb41ced68b6ca946";
    sha256 = "1xj6vy250p96rh66zzg479w9ah0x7z0jzfdjapflxxz8idxhsl6x";
  })
  (plugin {
    name = "plugin-fasd";
    owner = "oh-my-fish";
    repo = "plugin-fasd";
    rev = "38a5b6b6011106092009549e52249c6d6f501fba";
    sha256 = "06v37hqy5yrv5a6ssd1p3cjd9y3hnp19d3ab7dag56fs1qmgyhbs";
  })
  (plugin {
    name = "fzf";
    owner = "jethrokuan";
    repo = "fzf";
    rev = "fdb69549a3a37c15b096ad9eb5ea661d4739aa4e";
    sha256 = "1kf5bdh0mpijb8wdwvj66w1rrsy1fb7jzvrdizvakipykkshv5vh";
  })
  (plugin {
    name = "fish-bang-bang";
    owner = "nyarly";
    repo = "fish-bang-bang";
    rev = "12f08d9c81dc23fc44eb309964c7b418bbc97cbb";
    sha256 = "0mzbz0kdg8ax6q1gzsfvpy25d3xqwkyx9hy0jmbkr9zvjf4qav7b";
  })
  (plugin {
    name = "fish-rake-complete";
    owner = "nyarly";
    repo = "fish-rake-complete";
    rev = "5f1999c952f9602c753dbec830f6396adb3c692e";
    sha256 = "1hyf4h9xd4x70l0pfqxf4ahm3ykb29p8xb24s3034djsvawzsv4n";
  })
  (plugin {
    name = "google-cloud-sdk-fish-completion";
    owner = "lgathy";
    repo = "google-cloud-sdk-fish-completion";
    rev = "bc24b0bf7da2addca377d89feece4487ca0b1e9c";
    sha256 = "03zzggi64fhk0yx705h8nbg3a02zch9y49cdvzgnmpi321vz71h4";
  })
  (plugin {
    name = "fish-cache-file";
    owner = "nyarly";
    rev = "ff7490e7dd8a36ce770a8eb96ab5cdb0454e8a8d";
    sha256 = "0rv4p0d1lc4h0w14857ry541jgwj0b26bhnbh1s8v4g1apm4rxg0";
  })
  (plugin {
    name = "lookup";
    owner = "nyarly";
    rev = "c96adbfda19464bc9b463d67906634fbb9cddd5b";
    sha256 = "0id3glqn126y4k9ql37pwzwlphf35sg785vhxyw90zsi37p7vz9s";
  })
  (plugin {
    name = "fish-bang-bang";
    owner = "nyarly";
    rev = "12f08d9c81dc23fc44eb309964c7b418bbc97cbb";
    sha256 = "0mzbz0kdg8ax6q1gzsfvpy25d3xqwkyx9hy0jmbkr9zvjf4qav7b";
  })
]
