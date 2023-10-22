-- Import mason plugin safely
local mason_status, mason = pcall(require, "mason")
if not mason_status then
  return
end

-- Import mason-lspconfig plugin safely
local mason_lspconfig_status, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status then
  return
end

-- Enable mason
mason.setup()

-- Enable mason lspconfig
mason_lspconfig.setup({
  -- list of servers for mason to install
  ensure_installed = {
    "tsserver",
    "html",
    "cssls",
    "tailwindcss",
    "lua_ls",
    "emmet_ls",
    "solang",
    "solc",
    "solidity",
    "solidity_ls_nomicfoundation",
    "rust_analyzer"
  },
  -- auto-install configured servers (with lspconfig)
  automatic_installation = true, -- not the same as ensure_installed
})
