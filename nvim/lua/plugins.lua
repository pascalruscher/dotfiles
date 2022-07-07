local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

local function get_config(name)
  return string.format("require('config/%s')", name)
end

if fn.empty(fn.glob(install_path)) > 0 then
  	packer_bootstrap = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer...")
	vim.api.nvim_command("packadd packer.nvim")
end

local packer = require("packer")

packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float()
		end
	},
})

packer.startup(function(use)
	use({ "wbthomason/packer.nvim" })
	use({ "neovim/nvim-lspconfig", config = get_config("lsp") })
	use {
	  "nvim-telescope/telescope.nvim",
	  requires = { {"nvim-lua/plenary.nvim"} },
	  config = get_config("telescope"),
	}
	use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
	use { "nvim-telescope/telescope-file-browser.nvim" }
	use { "kyazdani42/nvim-web-devicons" }
	if packer_bootstrap then
		packer.sync()
	end
end)
