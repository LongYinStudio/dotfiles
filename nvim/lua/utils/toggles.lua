-- 配置各种功能的开关
local M = {}

local function bool2str(bool)
	return bool and "on" or "off"
end

--- Toggle wrap
function M.wrap()
	vim.wo.wrap = not vim.wo.wrap -- local to window
	vim.notify(("wrap %s"):format(bool2str(vim.wo.wrap)))
end

-- TODO: 配置spell
--- Toggle spell
function M.spell()
	vim.wo.spell = not vim.wo.spell -- local to window
	vim.notify(("spell %s"):format(bool2str(vim.wo.spell)))
end

--- Change the number display modes
function M.number()
	local number = vim.wo.number -- local to window
	local relativenumber = vim.wo.relativenumber -- local to window
	if not number and not relativenumber then
		vim.wo.number = true
	elseif number and not relativenumber then
		vim.wo.relativenumber = true
	elseif number and relativenumber then
		vim.wo.number = false
	else -- not number and relativenumber
		vim.wo.relativenumber = false
	end
	vim.notify(("number %s, relativenumber %s"):format(bool2str(vim.wo.number), bool2str(vim.wo.relativenumber)))
end

return M
