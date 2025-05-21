return {
	"barrett-ruth/live-server.nvim",
	enabled = false,
	build = "npm install -g live-server",
	lazy = true,
	event = { "BufEnter *.html", "BufEnter *.htmx" },
	cmd = { "LiveServerStart", "LiveServerStop" },
	config = true,
}

-- 类似的 https://github.com/turbio/bracey.vim
