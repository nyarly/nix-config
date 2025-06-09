local capabilities = require("cmp_nvim_lsp").default_capabilities()

local lspconfig = require('lspconfig')
-- local configs = require('lspconfig/configs')

local function lsp_attach(client, buffer)
  -- This callback is called when the LSP is attached/enabled for this buffer
  -- we could set keymaps related to LSP, etc here.
  local keymap_opts = { buffer = buffer }
  -- Code navigation and shortcuts
  vim.keymap.set("n", "<c-]>", vim.lsp.buf.definition, keymap_opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, keymap_opts)
  vim.keymap.set("n", "gD", vim.lsp.buf.implementation, keymap_opts)
  vim.keymap.set("n", "<c-k>", vim.lsp.buf.signature_help, keymap_opts)
  vim.keymap.set("n", "1gD", vim.lsp.buf.type_definition, keymap_opts)
  vim.keymap.set("n", "gr", vim.lsp.buf.references, keymap_opts)
  vim.keymap.set("n", "g0", vim.lsp.buf.document_symbol, keymap_opts)
  vim.keymap.set("n", "gW", vim.lsp.buf.workspace_symbol, keymap_opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, keymap_opts)

  vim.keymap.set("n", "gf", vim.lsp.buf.code_action, keymap_opts)
  vim.keymap.set("v", "gf", vim.lsp.buf.code_action, keymap_opts)
  vim.keymap.set("n", "gN", vim.lsp.buf.rename, keymap_opts)
  vim.keymap.set("n", "gb", function() vim.diagnostic.open_float(nil, { focusable = false }) end, keymap_opts)

  -- Goto previous/next diagnostic warning/error
  vim.keymap.set("n", "g[", vim.diagnostic.goto_prev, keymap_opts)
  vim.keymap.set("n", "g]", vim.diagnostic.goto_next, keymap_opts)

  vim.wo.signcolumn = "number"

  vim.cmd([[match OverLength /\%100v./]]) -- right place?

  vim.api.nvim_create_autocmd("BufWritePre", {
    buffer = buffer,
    callback = function()
      vim.lsp.buf.format { async = false }
    end,
  })
end
-- Enable some language servers with the additional completion capabilities offered by nvim-cmp
-- local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver' }
local servers = { 'rust_analyzer', 'gopls' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
    on_attach = lsp_attach,
  }
end

lspconfig['terraformls'].setup {
  -- on_attach = my_custom_on_attach,
  capabilities = capabilities,
  on_attach = lsp_attach,
  init_options = {
    terraform = {
      path = vim.fn.exepath('tofu')
    }
  }
}

lspconfig['yamlls'].setup {
  -- on_attach = my_custom_on_attach,
  capabilities = capabilities,
  on_attach = lsp_attach,
  settings = {
    redhat = { telemetry = { enabled = false } },
    yaml = { schemaStore = { enable = false } },
  }
}

lspconfig['lua_ls'].setup {
  -- on_attach = my_custom_on_attach,
  capabilities = capabilities,
  on_attach = lsp_attach,
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" }
      }
    }
  }
}

lspconfig['pyright'].setup {
  -- on_attach = my_custom_on_attach,
  capabilities = capabilities,
  on_attach = lsp_attach,
  on_new_config = function(new_config, new_root_dir)
    if vim.env.VIRTUAL_ENV then
      new_config.cmd = { 'pyright-langserver', '--stdio', '--venvpath', vim.env.VIRTUAL_ENV }
    end
  end
}

lspconfig['nil_ls'].setup {
  capabilities = capabilities,
  on_attach = lsp_attach,
  settings = {
    nix = {
      flake = {
        autoArchive = true
      }
    }
  }
}

lspconfig['elmls'].setup {
  capabilities = capabilities,
  on_attach = lsp_attach,
  root_dir = require "lspconfig.util".root_pattern("elm.json", ".git"),
  -- init_options = { elmTestPath = "elm-test-rs" },
  init_options = {
    elmFormatPath = "elm-format",
  }
}

-- belongs in on_attach? belongs in lsp?
local format_sync_grp = vim.api.nvim_create_augroup("Format", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.rs",
  callback = function()
    vim.lsp.buf.format({ timeout_ms = 200 })
  end,
  group = format_sync_grp,
})

local langs = {
  rs = function(client, buffer)
    vim.bo.sw = 4
    vim.b.ale_lint_on_insert_leave = 0
  end,
  elm = function(client, buffer)
    vim.bo.sw = 2 -- set in after/ftplugin as well...
  end
}
for l, cb in pairs(langs) do
  vim.api.nvim_create_autocmd("LspAttach", {
    pattern = "*." .. l,
    callback = cb
  })
end


-- Rust configuration care of:
-- https://sharksforarms.dev/posts/neovim-rust/
--   there were more tips there

-- Configure LSP through rust-tools.nvim plugin.
-- rust-tools will configure and enable certain LSP features for us.
-- See https://github.com/simrat39/rust-tools.nvim#configuration
local opts = {
  tools = {
    runnables = {
      -- use_telescope = true, -- fuzzy finder
    },
    inlay_hints = {
      auto = true,
      show_parameter_hints = false,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
    },
  },

  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
  server = {
    -- on_attach is a callback called when the language server attachs to the buffer
    on_attach = lsp_attach,
    settings = {
      -- to enable rust-analyzer settings visit:
      -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
      ["rust-analyzer"] = {
        -- enable clippy on save
        checkOnSave = {
          command = "clippy",
        },
      },
    },
  },
}

require("rust-tools").setup(opts)
