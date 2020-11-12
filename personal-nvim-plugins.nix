{fetchgit, buildVimPluginFrom2Nix}:
{

  sideways-vim = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "sideways-vim-2020-09-21";
    src = fetchgit {
      url = "https://github.com/AndrewRadev/sideways.vim";
      rev = "19c5a21206b6c9f999004256a10e7381450ea83f";
      sha256 = "14h8lf70wccafapifzf9c6cjprik9n1a1wmv5gpajyqqbvzh1yv6";
    };
    dependencies = [];

  };

  Colorizer = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "Colorizer-2020-05-29";
    src = fetchgit {
      url = "https://github.com/chrisbra/Colorizer";
      rev = "879e6c69c0c02c4ef0f08b3955c60de16efd8fb8";
      sha256 = "1wbmd9qyb4qsqdmd4dqnfi5jn44scv1pgacr56sy7dagx2iz5zj6";
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
    name = "promptline-vim-2019-03-30";
    src = fetchgit {
      url = "https://github.com/edkolev/promptline.vim";
      rev = "106418570a0ecc33b35439e24b051be34f829b94";
      sha256 = "1dwjlwynqi680kjr31zqa5zc7v14r52l7andv6wp53rnij1wnmkd";
    };
    dependencies = [];

  };

  Dockerfile-vim = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "Dockerfile-vim-2020-08-11";
    src = fetchgit {
      url = "https://github.com/ekalinin/Dockerfile.vim";
      rev = "038480563ce04c5b5e233c5ff6044db2a0760625";
      sha256 = "151cz6j50fck4y57nmdaa0sa4h4dckpiv857rcx7fpiwcz3z5pz7";
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

  tla-vim = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "tla-vim-2016-12-27";
    src = fetchgit {
      url = "https://github.com/hwayne/tla.vim";
      rev = "0d6d453a401542ce1db247c6fd139ac99b8a5add";
      sha256 = "1bfxnvx3g5679jan7v5prh7zk0f77m81g8c9ngq75nxdn20ihl7l";
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

  vim-cue = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "vim-cue-2020-10-25";
    src = fetchgit {
      url = "https://github.com/jjo/vim-cue";
      rev = "9e8bef1198817b6bae1143fecd965403d65d2466";
      sha256 = "0rq74znq9mx5p925jd120l5apjqdqp6xy6llzhf2gq5cxpg62hjl";
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
    name = "vim-jsx-2019-09-29";
    src = fetchgit {
      url = "https://github.com/mxw/vim-jsx";
      rev = "8879e0d9c5ba0e04ecbede1c89f63b7a0efa24af";
      sha256 = "0czjily7kjw7bwmkxd8lqn5ncrazqjsfhsy3sf2wl9ni0r45cgcd";
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
    name = "html5-vim-2020-08-22";
    src = fetchgit {
      url = "https://github.com/othree/html5.vim";
      rev = "7c9f6f38ce4f9d35db7eeedb764035b6b63922c6";
      sha256 = "1hgbvdpmn3yffk5ahz7hz36a7f5zjc1k3pan5ybgncmdq9f4rzq6";
    };
    dependencies = [];

  };

  vim-jsx-typescript = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "vim-jsx-typescript-2020-07-08";
    src = fetchgit {
      url = "https://github.com/peitalin/vim-jsx-typescript";
      rev = "07370d48c605ec027543b52762930165b1b27779";
      sha256 = "190nyy7kr6i3xr6nrjlfv643s1c48kxlbh8ynk8p53yf32gcxwz7";
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
    name = "vim-delve-2020-09-23";
    src = fetchgit {
      url = "https://github.com/sebdah/vim-delve";
      rev = "d4f0e265f8ba10a39b46ed4b0a0cf17668abf676";
      sha256 = "18gpbanagsbdrsymrmhy3rn894w21hgp8am2225hmrxsg567s4pn";
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
    name = "vim-endwise-2020-04-19";
    src = fetchgit {
      url = "https://github.com/tpope/vim-endwise";
      rev = "97180a73ad26e1dcc1eebe8de201f7189eb08344";
      sha256 = "1f9nwp9qiip4alkpacwaq2nzsrx80a4cdwyrvajs6lrk48dv4hbw";
    };
    dependencies = [];

  };

  vim-obsession = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "vim-obsession-2020-01-19";
    src = fetchgit {
      url = "https://github.com/tpope/vim-obsession";
      rev = "96a3f837c112cb64e0a9857b69f6d6a71041155e";
      sha256 = "11h7jyg7fhjmq3pmpc93nrsxm175ra14407rs3558h8p04snc159";
    };
    dependencies = [];

  };

  vim-ragtag = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "vim-ragtag-2020-01-26";
    src = fetchgit {
      url = "https://github.com/tpope/vim-ragtag";
      rev = "6f1af76cd669c4fb07f0c4e20fdee3077620e3d8";
      sha256 = "1q5klbnwsg26zxhs3knhamk3srg7dmq46n83sa5rw2kmikb2idg2";
    };
    dependencies = [];

  };

  vim-unimpaired = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "vim-unimpaired-2020-04-26";
    src = fetchgit {
      url = "https://github.com/tpope/vim-unimpaired";
      rev = "4afbe5ebf32ad85341b4c02b0e1d8ca96a64c561";
      sha256 = "052amdb4bd2qbip3z9xz7h1cv61k4p038j65yijm68vy0hf2724y";
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
    name = "jq-vim-2019-05-21";
    src = fetchgit {
      url = "https://github.com/vito-c/jq.vim";
      rev = "6e056fa297ce58d45500b0937b8214400e9a50fa";
      sha256 = "0dfsym34xiza9221bdsr51jykcxmz8bnkzi846bqxxjxiw0p3yk1";
    };
    dependencies = [];

  };



}
