{
  addressable = {
    dependencies = ["public_suffix"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0bcm2hchn897xjhqj9zzsxf3n9xhddymj4lsclz508f4vw3av46l";
      type = "gem";
    };
    version = "2.6.0";
  };
  compass-core = {
    dependencies = ["multi_json" "sass"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0yaspqwdmzwdcqviclbs3blq7an16pysrfzylz8q1gxmmd6bpj3a";
      type = "gem";
    };
    version = "1.0.3";
  };
  compass-import-once = {
    dependencies = ["sass"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0bn7gwbfz7jvvdd0qdfqlx67fcb83gyvxqc7dr9fhcnks3z8z5rq";
      type = "gem";
    };
    version = "1.0.5";
  };
  crass = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0bpxzy6gjw9ggjynlxschbfsgmx8lv3zw1azkjvnb8b9i895dqfi";
      type = "gem";
    };
    version = "1.0.4";
  };
  daemons = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0l5gai3vd4g7aqff0k1mp41j9zcsvm2rbwmqn115a325k9r7pf4w";
      type = "gem";
    };
    version = "1.3.1";
  };
  eventmachine = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0wh9aqb0skz80fhfn66lbpr4f86ya2z5rx6gm5xlfhd05bj1ch4r";
      type = "gem";
    };
    version = "1.2.7";
  };
  faye-websocket = {
    dependencies = ["eventmachine" "websocket-driver"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "07s0mwxx1fm7s1vg429m57cfkf87sn6gai8v6s4zpjlfj8i74da6";
      type = "gem";
    };
    version = "0.7.5";
  };
  json = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0sx97bm9by389rbzv8r1f43h06xcz8vwi3h5jv074gvparql7lcx";
      type = "gem";
    };
    version = "2.2.0";
  };
  kramdown = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "070r81kz88zw28c8bs5p0p92ymn1nldci2fm1arkas0bnqrd3rna";
      type = "gem";
    };
    version = "1.7.0";
  };
  mini_portile2 = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "15zplpfw3knqifj9bpf604rb3wc1vhq6363pd6lvhayng8wql5vy";
      type = "gem";
    };
    version = "2.4.0";
  };
  multi_json = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1rl0qy4inf1mp8mybfk56dfga0mvx97zwpmq5xmiwl5r770171nv";
      type = "gem";
    };
    version = "1.13.1";
  };
  nokogiri = {
    dependencies = ["mini_portile2"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "02bjydih0j515szfv9mls195cvpyidh6ixm7dwbl3s2sbaxxk5s4";
      type = "gem";
    };
    version = "1.10.3";
  };
  public_suffix = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "08q64b5br692dd3v0a9wq9q5dvycc6kmiqmjbdxkxbfizggsvx6l";
      type = "gem";
    };
    version = "3.0.3";
  };
  rack = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0z90vflxbgjy2n84r7mbyax3i2vyvvrxxrf86ljzn5rw65jgnn2i";
      type = "gem";
    };
    version = "2.0.7";
  };
  rack-mount = {
    dependencies = ["rack"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "09a1qfaxxsll1kbgz7z0q0nr48sfmfm7akzaviis5bjpa5r00ld2";
      type = "gem";
    };
    version = "0.8.3";
  };
  RedCloth = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0m9dv7ya9q93r8x1pg2gi15rxlbck8m178j1fz7r5v6wr1avrrqy";
      type = "gem";
    };
    version = "4.3.2";
  };
  rhet-butler = {
    dependencies = ["RedCloth" "addressable" "compass-core" "compass-import-once" "crass" "kramdown" "nokogiri" "rack" "rqrcode" "sockjs" "system-getifaddrs" "thin" "thor" "tilt" "valise"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0a1da747kw0zsabg8i6c7xbqm6nrr71676qafxaxlcb2kj9jrwa5";
      type = "gem";
    };
    version = "0.14.0";
  };
  rqrcode = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1a9gwz5vkpq4ifp1mrs3sc40smwxm9w0b8i69xxyakac00wd0rd5";
      type = "gem";
    };
    version = "0.4.2";
  };
  sass = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0kfpcwh8dgw4lc81qglkvjl73689jy3g7196zkxm4fpskg1p5lkw";
      type = "gem";
    };
    version = "3.4.25";
  };
  sockjs = {
    dependencies = ["faye-websocket" "json" "rack" "rack-mount" "thin"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0b3z1gyb7z4m84ssbs5f8dsnpb26gqd4spql3k2f0wi20aa3mm9j";
      type = "gem";
    };
    version = "0.3.4.0";
  };
  system-getifaddrs = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1py8c4wnn4r12xl86k0wy379l5bwzb58z9220k9d1kywxmiyycir";
      type = "gem";
    };
    version = "0.2.1";
  };
  thin = {
    dependencies = ["daemons" "eventmachine" "rack"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "0nagbf9pwy1vg09k6j4xqhbjjzrg5dwzvkn4ffvlj76fsn6vv61f";
      type = "gem";
    };
    version = "1.7.2";
  };
  thor = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1yhrnp9x8qcy5vc7g438amd5j9sw83ih7c30dr6g6slgw9zj3g29";
      type = "gem";
    };
    version = "0.20.3";
  };
  tilt = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "00sr3yy7sbqaq7cb2d2kpycajxqf1b1wr1yy33z4bnzmqii0b0ir";
      type = "gem";
    };
    version = "1.4.1";
  };
  valise = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1arsbmk2gifrhv244qrld7s3202xrnxy6vlc5gqklg70dpsinbn5";
      type = "gem";
    };
    version = "1.2.1";
  };
  websocket-driver = {
    dependencies = ["websocket-extensions"];
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "1551k3fs3kkb3ghqfj3n5lps0ikb9pyrdnzmvgfdxy8574n4g1dn";
      type = "gem";
    };
    version = "0.7.0";
  };
  websocket-extensions = {
    groups = ["default"];
    platforms = [];
    source = {
      remotes = ["https://rubygems.org"];
      sha256 = "034sdr7fd34yag5l6y156rkbhiqgmy395m231dwhlpcswhs6d270";
      type = "gem";
    };
    version = "0.1.3";
  };
}