local M = {}

-- node types that count as a "definition" to fold (matched as Lua patterns)
local DEF_PATTERNS = { "function", "method", "class", "decorated_definition", "impl_item" }
-- reject things like function_call / method_signature / class_body
local EXCLUDE_PATTERNS = { "call", "signature", "body", "type", "parameter", "name" }

local function is_definition(node_type)
	for _, p in ipairs(EXCLUDE_PATTERNS) do
		if node_type:find(p) then
			return false
		end
	end
	for _, p in ipairs(DEF_PATTERNS) do
		if node_type:find(p) then
			return true
		end
	end
	return false
end

-- Collect the outermost multi-line definition nodes; do not descend into them.
local function collect(node, out)
	for child in node:iter_children() do
		if child:named() then
			local srow, _, erow = child:range()
			if is_definition(child:type()) and erow > srow then
				-- decorated defs: the fold starts at the inner def, not the decorator
				local inner = child:field("definition")[1]
				table.insert(out, inner and (inner:range()) or srow)
			else
				collect(child, out)
			end
		end
	end
end

--- Open all folds, then close only the outermost functions/classes in the buffer.
function M.fold_definitions()
	local ok, parser = pcall(vim.treesitter.get_parser, 0)
	if not ok or not parser then
		vim.notify("No treesitter parser for this buffer", vim.log.levels.WARN)
		return
	end
	if vim.wo.foldmethod ~= "expr" then
		vim.wo.foldmethod = "expr"
		vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
	end

	local root = parser:parse()[1]:root()
	local rows = {}
	collect(root, rows)

	local view = vim.fn.winsaveview()
	vim.cmd("normal! zR")
	for _, row in ipairs(rows) do
		-- closes the innermost open fold at the definition's first line
		pcall(vim.cmd, (row + 1) .. "foldclose")
	end
	vim.fn.winrestview(view)
end

return M
