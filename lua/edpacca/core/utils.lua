local M = {}

function M.relative_path()
	local path = vim.fn.expand("%:.")
	if path == "" then
		vim.notify("Buffer has no file path", vim.log.levels.WARN)
		return
	end
	return path
end

-- yank relative path of current buffer
function M.yank_relative_path()
	-- local path = vim.fn.expand("%:.")
	-- if path == "" then
	-- 	vim.notify("Buffer has no file path", vim.log.levels.WARN)
	-- 	return
	local path = M.relative_path()
	if path == "" then
		return
	end

	vim.fn.setreg("+", path)
	vim.fn.setreg('"', path)
	vim.notify("Yanked: " .. path)
end

-- collect names of the classes (outermost first) whose range contains `line`
local function enclosing_classes(symbols, line, classes)
	classes = classes or {}
	for _, sym in ipairs(symbols) do
		local range = sym.range
		if range and range.start.line <= line and line <= range["end"].line then
			if sym.kind == vim.lsp.protocol.SymbolKind.Class then
				table.insert(classes, sym.name)
			end
			if sym.children then
				enclosing_classes(sym.children, line, classes)
			end
			break
		end
	end
	return classes
end

-- yank pytest test-path: path/to/test.py::ClassIfAny::test_name
function M.yank_pytest_path()
	local path = M.relative_path()
	if not path then
		return
	end

	local test_name = vim.fn.expand("<cword>")
	local line = vim.api.nvim_win_get_cursor(0)[1] - 1

	local params = { textDocument = vim.lsp.util.make_text_document_params() }
	local responses = vim.lsp.buf_request_sync(0, "textDocument/documentSymbol", params, 1000)

	local classes = {}
	for _, response in pairs(responses or {}) do
		if response.result then
			classes = enclosing_classes(response.result, line)
			break
		end
	end

	local parts = { path }
	vim.list_extend(parts, classes)
	table.insert(parts, test_name)
	local pytest_path = table.concat(parts, "::")

	vim.fn.setreg("+", pytest_path)
	vim.fn.setreg('"', pytest_path)
	vim.notify("Yanked: " .. pytest_path)
end

return M
