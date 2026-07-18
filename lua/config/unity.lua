-- Auto-cd to the Unity project root (folder containing ProjectSettings/)
-- whenever a .cs file is opened, so :pwd, telescope, harpoon, etc. all
-- resolve relative to the project instead of nvim's launch directory.

local function unity_root(path)
  local found = vim.fs.find("ProjectSettings", {
    path = vim.fs.dirname(path),
    upward = true,
    type = "directory",
  })[1]
  return found and vim.fs.dirname(found) or nil
end

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*.cs",
  callback = function(args)
    local root = unity_root(args.match)
    if root and vim.fn.getcwd() ~= root then
      vim.cmd.cd(root)
    end
  end,
})
