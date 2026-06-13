--  ┳┳┓┏┓┏┳┓┳┳┏┓┏┓┳┓  ┓┏┓┏┏┓┳┓┓ ┏┓┳┓┳┓
--  ┃┃┃┣┫ ┃ ┃┃┃┓┣ ┃┃━━┣┫┗┫┃┃┣┫┃ ┣┫┃┃┃┃
--  ┛ ┗┛┗ ┻ ┗┛┗┛┗┛┛┗  ┛┗┗┛┣┛┛┗┗┛┛┗┛┗┻┛
--

local colors = {
    image = "{{image}}",
}

function colors.alpha(color, alpha)
	local value = color:gsub("%x%x%)$", alpha .. ")")
	return value
end

-- All Colors
<* for name, value in colors *>
colors.{{name}} = "rgba({{value.default.hex_stripped}}ff)"
<* endfor *>

return colors
