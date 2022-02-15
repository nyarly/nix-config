{fetchgit, buildVimPluginFrom2Nix}:
{

  sideways-vim = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "sideways-vim-2022-02-12";
    src = fetchgit {
      url = "https://github.com/AndrewRadev/sideways.vim";
      rev = "ab20cc8a6a7cb95679f99bc4ec724544f9b94c62";
      sha256 = "01slcxzw485ik7mszj97x67576yw1l7i6imv3rfdn3cv7d216rj8";
    };
    dependencies = [];

  };

  Colorizer = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "Colorizer-2022-02-03";
    src = fetchgit {
      url = "https://github.com/chrisbra/Colorizer";
      rev = "a3882e86cf503e9eea3eece5768bbe3ce9a29fcd";
      sha256 = "115f0jljjj32qpadpy4bhr9nqb4q1hzb06dr7pnngk8m71bwsg6d";
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
    name = "Dockerfile-vim-2021-09-06";
    src = fetchgit {
      url = "https://github.com/ekalinin/Dockerfile.vim";
      rev = "2a31e6bcea5977209c05c728c4253d82fd873c82";
      sha256 = "0dicf1igsnhmx8cacjj1qc0yxv3fqb2s6bimngxhvrh9jdkqc91j";
    };
    dependencies = [];

  };

  vim-markdown-composer = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "vim-markdown-composer-2022-01-04";
    src = fetchgit {
      url = "https://github.com/euclio/vim-markdown-composer";
      rev = "010ae3667fb0cb4c63c99439d1a8f81ebdcc849e";
      sha256 = "1hz0xjq0srv3llb4i6n2sw0pi2s0k3qcwyk6az5icrvkfhbnc0kf";
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
    name = "vim-cue-2021-06-18";
    src = fetchgit {
      url = "https://github.com/jjo/vim-cue";
      rev = "bd1a62303d096aa24fe4160a475645087f8770b3";
      sha256 = "01f89ki0w2j58pfdvb8w0sf1x5nqgqh3bldinifpd4pysnqhniai";
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
    name = "vim-jsx-typescript-2020-12-03";
    src = fetchgit {
      url = "https://github.com/peitalin/vim-jsx-typescript";
      rev = "22df470d92651426f2377e3166488672f7b4b4ef";
      sha256 = "13w7n8km927v9yvm91c4z8g343bn2mp0k80nwv5y0sz279x4x9n7";
    };
    dependencies = [];

  };

  ranger-vim = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "ranger-vim-2021-12-13";
    src = fetchgit {
      url = "https://github.com/rafaqz/ranger.vim";
      rev = "527c7c5371667f7848da91c2abc75c3998cbf1a0";
      sha256 = "1rfzv6lxbhfk4xwdmhpc9b0xamfa2lrzc1xi630v1hakscjdjcm1";
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
    name = "vim-delve-2020-11-13";
    src = fetchgit {
      url = "https://github.com/sebdah/vim-delve";
      rev = "554b7997caba5d2b38bc4a092e3a468e4abb7f18";
      sha256 = "11qsvw3qsrkwmdks6mhmygmwzi9ma8vhx77kid5s7p936i8xdmxr";
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
    name = "vim-endwise-2021-03-06";
    src = fetchgit {
      url = "https://github.com/tpope/vim-endwise";
      rev = "4289889a2622f9bc7c594a6dd79763781f63dfb5";
      sha256 = "0sixr3rpcgqbaiyk7w6ghcrvllh35cb3gq9isdlwkww3dz4jyyxc";
    };
    dependencies = [];

  };

  vim-obsession = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "vim-obsession-2021-03-22";
    src = fetchgit {
      url = "https://github.com/tpope/vim-obsession";
      rev = "82c9ac5e130c92a46e043dd9cd9e5b48d15e286d";
      sha256 = "0lfcba8sk25l5yp3agh6pwniddf8jx627ikpr8i2z9ary2fqsj98";
    };
    dependencies = [];

  };

  vim-ragtag = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "vim-ragtag-2021-02-22";
    src = fetchgit {
      url = "https://github.com/tpope/vim-ragtag";
      rev = "b8966c4f6503a8baaec39e17bd0bf38b2aadc9b2";
      sha256 = "0q4blsgnl4l2bkhgjry6xnszhsswdand52gc6gdjffwlzwa9jczy";
    };
    dependencies = [];

  };

  vim-unimpaired = buildVimPluginFrom2Nix { # created by nix#NixDerivation
    name = "vim-unimpaired-2022-02-02";
    src = fetchgit {
      url = "https://github.com/tpope/vim-unimpaired";
      rev = "f992923d336e93c7f50fe9b35a07d5a92660ecaf";
      sha256 = "04l0v2jgkvhkfjj7j5r7x81gq2zwbjh5vh4p860p38razq6aixpl";
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
