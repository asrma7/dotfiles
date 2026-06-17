local M = {}

local matugen_path = vim.fn.stdpath("config") .. "/lua/asrma7/matugen-nvim.lua"

function M.source(opts)
    opts = opts or {}

    local file, err = io.open(matugen_path, "r")
    if err ~= nil then
        vim.cmd("colorscheme base16-catppuccin-mocha")

        if not opts.silent then
            vim.print(
                "A matugen style file was not found, but that's okay! "
                    .. "The colorscheme will dynamically change if matugen runs!"
            )
        end

        return
    end

	io.close(file)
	dofile(matugen_path)
	vim.g.colors_name = "base16-matugen"
end

return M
