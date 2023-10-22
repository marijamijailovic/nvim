-- Import lualine plugin safely
local status, lualine = pcall(require, "lualine")
if not status then
  return
end

-- Enable lualine
lualine.setup()
