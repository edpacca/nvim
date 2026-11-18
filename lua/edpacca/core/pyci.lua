-- Python tooling (isort/black/flake8/pylint/mypy) runs from the project root,
-- using binaries from the project's .venv.
local M = {}

local markers = { ".flake8", ".pylintrc", "mypy.ini", "pyproject.toml", ".git" }

---@param bufnr? integer
---@return string project root (falls back to cwd)
function M.root(bufnr)
	local name = vim.api.nvim_buf_get_name(bufnr or 0)
	if name == "" then
		return vim.fn.getcwd()
	end
	return vim.fs.root(name, markers) or vim.fn.getcwd()
end

---@param root string
---@param tool string
---@return string path to the venv binary, or the bare name if absent
function M.bin(root, tool)
	local path = root .. "/.venv/bin/" .. tool
	return vim.fn.executable(path) == 1 and path or tool
end

return M
