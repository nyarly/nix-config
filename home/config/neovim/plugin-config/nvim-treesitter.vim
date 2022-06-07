lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "bash", "bibtex", "c", "c_sharp", "clojure", "cmake",
  "comment", "commonlisp", "cpp", "css", "dart", "dockerfile", "dot", "erlang", "fish",
  "go", "gomod", "graphql", "hcl", "html", "java",
  -- "javascript",
  "jsdoc", "json", "json5", "jsonc", "latex", "lua", "nix", "ocaml",
  "ocaml_interface", "python", "query", "regex", "rst", "ruby", "rust",
  "scss", "sparql", "tlaplus", "toml", "tsx", "turtle", "typescript", "vim",
  "vue", "yaml", },

  highlight = {
    enable = true,              -- false will disable the whole extension
    -- disable = { "c", "rust" },  -- list of language that will be disabled
  },
  incremental_selection = { enable = true },
  indent = {
    enable = true ,
    disable = { "yaml" },
  }
}
EOF

set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
