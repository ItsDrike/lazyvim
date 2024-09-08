-- This file contains various utility functions that I use to make certain tasks eaasier and cleaner.
local M = {}


--- Removes the first occurrence of a value from a table.
---@generic T
---@param tbl T[] The table to remove the value from.
---@param value T The value to remove.
---@return boolean Whether the value was found and removed.
function M.remove_value(tbl, value)
  for i = #tbl, 1, -1 do -- Iterate backward to avoid index shifting issues
    if tbl[i] == value then
      table.remove(tbl, i)
      return true
    end
  end
  return false
end

return M
