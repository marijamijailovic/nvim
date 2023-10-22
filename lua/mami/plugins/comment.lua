-- Import comment plugin safely
local status, comment = pcall(require, "Comment")
if not setup then
  return
end

-- Enable comment
comment.setup()
