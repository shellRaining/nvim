-- Rerun tests only if their modification time changed.
cache = true
codes = true

exclude_files = {
	"tests/indent/lua/",
}

-- Glorious list of warnings: https://luacheck.readthedocs.io/en/stable/warnings.html
ignore = {
	"121", -- setting read-only global variable
	"212", -- Unused argument
	"411", -- Redefining a local variable.
	"412", -- Redefining an argument.
	"422", -- Shadowing an argument
	"122", -- Indirectly setting a readonly global
}

-- Global objects defined by the C code
read_globals = {
	"vim",
}
