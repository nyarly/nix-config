{fetchgit, buildVimPluginFrom2Nix}:
{
  sideways-vim = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "sideways-vim-2018-12-26";
    src = fetchgit {
      url = "https://github.com/AndrewRadev/sideways.vim";
      rev = "9dd871ee10e0e553214d94cab246ad5107eeafc3";
      sha256 = "1q6vgwvhy1hi68zihjsl5kck6cmdyi6ypqjlqk2n4i8rcghhhvxg";
    };
    dependencies = [];

  };

  Colorizer = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "Colorizer-2019-02-05";
    src = fetchgit {
      url = "https://github.com/chrisbra/Colorizer";
      rev = "9ebbe34449f11ed017b09b36278a24e9cf8f221b";
      sha256 = "0lbg2bxdxlxcgmn208wgwrx3zixhirzl744p9flwwynvfn7sa9v5";
    };
    dependencies = [];

  };

  lldb-nvim = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "lldb-nvim-2016-12-15";
    src = fetchgit {
      url = "https://github.com/critiqjo/lldb.nvim";
      rev = "143e8240b6fce04de2d6c1af736f1c374503235b";
      sha256 = "1r128rh0r5i4w5f20w9wbk4pqa47sjsci6hf20hq1jkvffyrbac7";
    };
    dependencies = [];

  };

  vim-fish = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "vim-fish-2017-11-22";
    src = fetchgit {
      url = "https://github.com/dag/vim-fish";
      rev = "50b95cbbcd09c046121367d49039710e9dc9c15f";
      sha256 = "1yvjlm90alc4zsdsppkmsja33wsgm2q6kkn9dxn6xqwnq4jw5s7h";
    };
    dependencies = [];

  };

  promptline-vim = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "promptline-vim-2018-07-19";
    src = fetchgit {
      url = "https://github.com/edkolev/promptline.vim";
      rev = "1cd222cd91cb2ea4743a45b5969b8effa62803b6";
      sha256 = "02xa8j943wa49slkii5xwhk7qdlhia8yc82v3x8q5m19a78pfjkx";
    };
    dependencies = [];

  };

  Dockerfile-vim = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "Dockerfile-vim-2018-12-18";
    src = fetchgit {
      url = "https://github.com/ekalinin/Dockerfile.vim";
      rev = "4e31ae28d462987ee6ae4aadb403aa8774dadb4d";
      sha256 = "0ryz1w55hww8a2n506nv34qyxjvzspr0qmk3ccb54rhlc07dzd4n";
    };
    dependencies = [];

  };

  godoctor-vim = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "godoctor-vim-2018-03-28";
    src = fetchgit {
      url = "https://github.com/godoctor/godoctor.vim";
      rev = "17973331d1ea88bad082fba406c1690f17943b52";
      sha256 = "0si65xlgfq5rdshk0y2v7wq72zyxp7c9ckr0xljx65raa9l5dgil";
    };
    dependencies = [];

  };

  tmuxline-vim = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "tmuxline-vim-2016-12-27";
    src = fetchgit {
      url = "https://github.com/grensjo/tmuxline.vim";
      rev = "bf56c780262965dcec09da9e4366984c309c196b";
      sha256 = "0ywmdizm7pqsgsij1jsd6007niji9vcalsnk1cpdxlxab823nh9m";
    };
    dependencies = [];

  };

  vim-actionscript = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "vim-actionscript-2018-11-13";
    src = fetchgit {
      url = "https://github.com/jeroenbourgois/vim-actionscript";
      rev = "3851afeef5cdd447a5367cfffef6af7335fc86b6";
      sha256 = "1h7lxplvp7g3bdbx002kcn3q4cra4rzh0c41lw0gndwf9yih1yzc";
    };
    dependencies = [];

  };

  vim-legend = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "vim-legend-2016-07-13";
    src = fetchgit {
      url = "https://github.com/killphi/vim-legend";
      rev = "5b3c8d414db53fd99230f607a6c6fd330b409f46";
      sha256 = "105xnqi8vax1p7k396lqsjxv25039kzikh2djghp9gb3lkycm4ik";
    };
    dependencies = [];

  };

  errormarker-vim = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "errormarker-vim-2016-11-10";
    src = fetchgit {
      url = "https://github.com/mh21/errormarker.vim";
      rev = "66ab8e0a356ea8a971e99156c59d09c3beae5ef2";
      sha256 = "0axpzaysrcp7dl4lbvjgf9xkgslyb07ww7v8wgayff43hhjlris2";
    };
    dependencies = [];

  };

  vim-jsx = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "vim-jsx-2018-08-07";
    src = fetchgit {
      url = "https://github.com/mxw/vim-jsx";
      rev = "ffc0bfd9da15d0fce02d117b843f718160f7ad27";
      sha256 = "0ff4w5n0cvh25mkhiq0ppn0w0lzc6sds1zwvd5ljf0cljlkm3bbg";
    };
    dependencies = [];

  };

  jobmake = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "jobmake-2016-07-15";
    src = fetchgit {
      url = "https://github.com/nyarly/jobmake";
      rev = "3f1f995656210b3a3e597998684807108b0154f2";
      sha256 = "0b44ldmb4ambs28faynwsggpflcfqszrp9lx1pcd5cx3cvh7ywgj";
    };
    dependencies = [];

  };

  html5-vim = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "html5-vim-2018-05-14";
    src = fetchgit {
      url = "https://github.com/othree/html5.vim";
      rev = "3db896baa26839b866db3db5d8997cc830874a24";
      sha256 = "00r1894lm45x0gxlpgjz7mxvsrsvzyr4khn10zlnypq08kimfypc";
    };
    dependencies = [];

  };

  ranger-vim = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "ranger-vim-2019-02-08";
    src = fetchgit {
      url = "https://github.com/rafaqz/ranger.vim";
      rev = "6def86f4293d170480ce62cc41f15448075d7835";
      sha256 = "0890rbmdw3p25cww6vsji7xrndcxsisfyv5przahpclk9fc9sxs8";
    };
    dependencies = [];

  };

  ag-vim = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "ag-vim-2016-06-19";
    src = fetchgit {
      url = "https://github.com/rking/ag.vim";
      rev = "4a0dd6e190f446e5a016b44fdaa2feafc582918e";
      sha256 = "1dz7rmqv3xw31090qms05hwbdfdn0qd1q68mazyb715cg25r85r2";
    };
    dependencies = [];

  };

  vim-delve = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "vim-delve-2018-12-10";
    src = fetchgit {
      url = "https://github.com/sebdah/vim-delve";
      rev = "ad30cab549ab8b6014308fe7c095325c08dec211";
      sha256 = "10qkmdy2i9nikn82sdfvsa712lclc2y35jg4lvj98rfnxwks0bvc";
    };
    dependencies = [];

  };

  semweb-vim = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "semweb-vim-2015-04-06";
    src = fetchgit {
      url = "https://github.com/seebi/semweb.vim";
      rev = "b79b7ea19f21dadce34336ecc7dbfa0feb422e22";
      sha256 = "1q5jhvizalymmil20y9s1yny5fj67ws1y4bmjb78g30l6zwmxilv";
    };
    dependencies = [];

  };

  textile-vim = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "textile-vim-2013-11-16";
    src = fetchgit {
      url = "https://github.com/timcharper/textile.vim";
      rev = "00541bdac375938ca013fdb39eab95a04e622bac";
      sha256 = "00xwa8vwmakvzawsg1brymkhgd395ls1pvh9hrrpiiq7lly1zdl7";
    };
    dependencies = [];

  };

  vim-endwise = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "vim-endwise-2018-12-26";
    src = fetchgit {
      url = "https://github.com/tpope/vim-endwise";
      rev = "f67d022169bd04d3c000f47b1c03bfcbc4209470";
      sha256 = "0lq2sphh2mfciva184b4b3if202hr4yls4d2gzbjx7ibch45zb9i";
    };
    dependencies = [];

  };

  vim-obsession = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "vim-obsession-2018-09-17";
    src = fetchgit {
      url = "https://github.com/tpope/vim-obsession";
      rev = "95a576210dc4408a4804a0a62a9eae90d701026b";
      sha256 = "04wrwlvdlakn9vrg48y80pcz2jy6kb1zigmjych15s51ay56cswd";
    };
    dependencies = [];

  };

  vim-ragtag = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "vim-ragtag-2019-01-29";
    src = fetchgit {
      url = "https://github.com/tpope/vim-ragtag";
      rev = "5d3ce9c1ae2232170a3f232c1e20fa832d15d440";
      sha256 = "1aq4n8h8lgkvia1ixhxavchcgk9irp8xs61c9pkshh8xm2y7k8xa";
    };
    dependencies = [];

  };

  vim-unimpaired = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "vim-unimpaired-2019-01-17";
    src = fetchgit {
      url = "https://github.com/tpope/vim-unimpaired";
      rev = "5694455d72229e73ff333bfe5196cc7193dca5e7";
      sha256 = "1fsz9bg0rrp35rs7qwgqzm0wnnd22pckmc2f792kkpcfmmpg5lay";
    };
    dependencies = [];

  };

  IndentAnything = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "IndentAnything-2010-10-17";
    src = fetchgit {
      url = "https://github.com/vim-scripts/IndentAnything";
      rev = "42f224bf2490ab8fe746e8d76d981853a923e8d2";
      sha256 = "1vmyfpf52vpz7jsr1kqbj4zhqm2clx04mpjlcd5vafrxk64xjcsx";
    };
    dependencies = [];

  };

  gnupg = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "gnupg-2010-10-17";
    src = fetchgit {
      url = "https://github.com/vim-scripts/gnupg";
      rev = "3293c5870fabb3c1775618cedf0684e4a0cc4ab8";
      sha256 = "1mjivlbj7b108yri1khkfx0fv0dsag9pzn9whds9v05z0i1cipbn";
    };
    dependencies = [];

  };

  nginx-vim = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "nginx-vim-2010-11-27";
    src = fetchgit {
      url = "https://github.com/vim-scripts/nginx.vim";
      rev = "152bbb2dc00c2df37049ccf75f68f294208c72cb";
      sha256 = "16d21sci6v4chiv9sc0g073l37yz0my2jh7hzck0y2rhixm955wm";
    };
    dependencies = [];

  };

  rfc-syntax = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "rfc-syntax-2014-01-28";
    src = fetchgit {
      url = "https://github.com/vim-scripts/rfc-syntax";
      rev = "4a05fcdc5df36a3c6df9ddc142bac644b35eecd0";
      sha256 = "15bjpxxxy1r1zmyisxivnbah04k6s012zk8vrwqkdjyr1cf6f5lq";
    };
    dependencies = [];

  };

  jq-vim = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "jq-vim-2019-01-28";
    src = fetchgit {
      url = "https://github.com/vito-c/jq.vim";
      rev = "5baf8ed192cf267d30b84e3243d9aab3d4912e60";
      sha256 = "1ykaxlli7b9wmhr8lpdalqxh7l4940jwhwm9pwlraga425h4r6z4";
    };
    dependencies = [];
  };
}
