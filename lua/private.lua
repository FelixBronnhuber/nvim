-- Handle private config and plugins for work:
local nvim_private_dir = vim.fs.joinpath(vim.env.HOME, ".config", "nvim.private")
if vim.fn.isdirectory(nvim_private_dir) then
	vim.opt.runtimepath:append(nvim_private_dir)
	local private_init = vim.fs.joinpath(nvim_private_dir, "init.lua")
	if vim.fn.filereadable(private_init) == 1 then
		-- Recurse plugins in private_dir
		local handle = vim.uv.fs_scandir(nvim_private_dir)
		if handle then
			while true do
				local name, typ = vim.uv.fs_scandir_next(handle)
				if not name then break end
				if typ == "directory" then
					vim.opt.runtimepath:append(vim.fs.joinpath(nvim_private_dir, name))
				end
			end
		end
		dofile(private_init)
	end
end
