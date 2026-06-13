--  ┳┳┓┏┓┏┳┓┳┳┏┓┏┓┳┓  ┓┏┓┏┏┓┳┓┓ ┏┓┳┓┳┓
--  ┃┃┃┣┫ ┃ ┃┃┃┓┣ ┃┃━━┣┫┗┫┃┃┣┫┃ ┣┫┃┃┃┃
--  ┛ ┗┛┗ ┻ ┗┛┗┛┗┛┛┗  ┛┗┗┛┣┛┛┗┗┛┛┗┛┗┻┛
--

-- Image Path
local image = "{{image}}"

-- All Colors
<* for name, value in colors *>
local {{name}} = "rgba({{value.default.hex_stripped}}ff)"
<* endfor *>
