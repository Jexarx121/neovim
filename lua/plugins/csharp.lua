-- Roslyn LSP for C# / Unity (needs the "roslyn" Mason package)

return {
    "seblyng/roslyn.nvim",
    ft = "cs",
    opts = {
        broad_search = true, -- find the .sln above nested Unity Assets/ dirs
    },
}
