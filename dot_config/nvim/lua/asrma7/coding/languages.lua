-- To add a language, create lua/asrma7/coding/languages/<name>.lua and require it here.
return {
	require("asrma7.coding.languages.lua"),
	require("asrma7.coding.languages.config"),
	require("asrma7.coding.languages.markdown"),
	require("asrma7.coding.languages.shell"),
	require("asrma7.coding.languages.python"),
	require("asrma7.coding.languages.go"),
	require("asrma7.coding.languages.dart"),
	require("asrma7.coding.languages.qml"),
	require("asrma7.coding.languages.web"),
	require("asrma7.coding.languages.terraform"),
	require("asrma7.coding.languages.docker"),
	require("asrma7.coding.languages.sql"),
}
