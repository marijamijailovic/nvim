-- Import telescope plugin itself safely
local telescope_setup, telescope = pcall(require, "telescope")
if not telescope_setup then
  return
end

-- Import telescope actions plugin safely
local actions_setup, actions = pcall(require, "telescope.actions")
if not actions_setup then
  return
end

-- Enable telescope
telescope.setup({
  defaults = {
    mappings = {
      i = {
        ["<C-k>"] = actions.move_selection_previous, -- move to prev result
        ["<C-j>"] = actions.move_selection_next, -- move to next result
        ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
      },
    },
  },
})

-- Enable telescope preform better
telescope.load_extension("fzf")
