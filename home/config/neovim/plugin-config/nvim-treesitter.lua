
require'nvim-treesitter.configs'.setup {
	ensure_installed = {},
  -- ensure_installed = { "bash", "bibtex", "c", "c_sharp", "clojure", "cmake",
  -- "comment", "commonlisp", "cpp", "css", "dart", "dockerfile", "dot", "erlang", "fish",
  -- "go", "gomod", "graphql", "hcl", "html", "java",
  -- "javascript",
  -- "jsdoc", "json", "json5", "jsonc", "latex", "lua", "nix", "ocaml",
  --"ocaml_interface", "python", "query", "regex", "rst", "ruby", "rust",
  --"scss", "sparql", "tlaplus", "toml", "tsx", "turtle", "typescript", "vim",
  --"vue", "yaml", },

  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {"kotlin", "swift", "verilog", "help"}, -- currently out of date
    -- disable = { "c", "rust" },  -- list of language that will be disabled
    additional_vim_regex_highlighting = false,
  },
  incremental_selection = { enable = true },
  indent = {
    enable = true ,
    disable = { "yaml" },
  },

  textobjects = {
    select = {
      enable = true,
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
          ["ap"] = "@parameter.outer",
          ["ip"] = "@parameter.inner",
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ["<C-X>"] = "@parameter.inner",
      },
      swap_previous = {
        ["<C-Z>"] = "@parameter.inner",
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
        ["]p"] = "@parameter.inner",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
        ["]P"] = "@parameter.inner",
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
        ["[p"] = "@parameter.inner",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
        ["[P"] = "@parameter.inner",
      },
    },
  },
}

vim.o.foldmethod='expr'
vim.o.foldexpr='nvim_treesitter#foldexpr()'
