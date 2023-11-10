-- Various utility functions used in multiple places across the user configuration.
-- Many of these were "borrowed" from AstroNvim utility functions.

local lazy_util = require("lazyvim.util")

local M = {}

--- Merge extended options with a default table of options
---@param default? table The default table that you want to merge into
---@param opts? table The new options that should be merged with the default table
---@return table # The merged table
function M.extend_tbl(default, opts)
  opts = opts or {}
  return default and vim.tbl_deep_extend("force", default, opts) or opts
end

--- Serve a notification with a title of UserConfig
---@param msg string The notification body
---@param type? number The type of the notification (:help vim.log.levels)
---@param opts? table The nvim-notify options to use (:help notify-options)
function M.notify(msg, type, opts)
  vim.schedule(function()
    vim.notify(msg, type, M.extend_tbl({ title = "UserConfig" }, opts))
  end)
end

--- Trigger a custom user event
---@param event string The event name to be triggered, prefixed by Custom
---@param delay? boolean Whether or not to delay the event asynchronously (Default: true)
function M.trigger_custom_event(event, delay)
  local emit_event = function()
    vim.api.nvim_exec_autocmds("User", { pattern = "Custom" .. event, modeline = false })
  end
  if delay == false then
    emit_event()
  else
    vim.schedule(emit_event)
  end
end

--- Run a shell command and capture the output and if the command succeeded or failed
---@param cmd string|string[] The terminal command to execute
---@param show_error? boolean Whether or not to show an unsuccessful command as an error to the user
---@return string|nil # The result of a successfully executed command or nil
function M.cmd(cmd, show_error)
  if type(cmd) == "string" then
    cmd = { cmd }
  end
  if vim.fn.has("win32") == 1 then
    cmd = vim.list_extend({ "cmd.exe", "/C" }, cmd)
  end
  local result = vim.fn.system(cmd)
  local success = vim.api.nvim_get_vvar("shell_error") == 0
  if not success and (show_error == nil or show_error) then
    vim.api.nvim_err_writeln(("Error running command %s\nError message:\n%s"):format(table.concat(cmd, " "), result))
  end
  return success and result:gsub("[\27\155][][()#;?%d]*[A-PRZcf-ntqry=><~]", "") or nil
end

--- Open a URL under the cursor with the current operating system
---@param path string The path of the file to open with the system opener
function M.system_open(path)
  -- TODO: Remove this entire function when dropping support for nvim <0.10
  if vim.ui.open then
    return vim.ui.open(path)
  end
  local cmd
  if vim.fn.has("win32") == 1 and vim.fn.executable("explorer") == 1 then
    cmd = { "cmd.exe", "/K", "explorer" }
  elseif vim.fn.has("unix") == 1 and vim.fn.executable("xdg-open") == 1 then
    cmd = { "xdg-open" }
  elseif (vim.fn.has("mac") == 1 or vim.fn.has("unix") == 1) and vim.fn.executable("open") == 1 then
    cmd = { "open" }
  end
  if not cmd then
    M.notify("Available system opening tool not found!", vim.log.levels.ERROR)
  end
  vim.fn.jobstart(vim.fn.extend(cmd, { path or vim.fn.expand("<cfile>") }), { detach = true })
end

M.has = lazy_util.has
M.on_load = lazy_util.on_load

return M
