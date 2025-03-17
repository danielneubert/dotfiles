local function map(key, action, buffer)
    if buffer then
        vim.keymap.set("t", key, action, { silent = true, buffer = true })
    else
        vim.keymap.set("n", key, action, { silent = true, noremap = true })
    end
end

return {
    {
        "ibhagwan/fzf-lua",
        dependencies = { "nvim-tree/nvim-web-devicons" },
        config = function()
            local fzf = require("fzf-lua")

            fzf.setup({
                fzf_opts = { ["--wrap"] = true },
                grep = {
                    rg_glob = true,
                    rg_glob_fn = function(query, _)
                        local regex, flags = query:match("^(.-)%s%-%-(.*)$")
                        return (regex or query), flags
                    end,
                },
                winopts = {
                    preview = {
                        wrap = "wrap",
                    },
                    on_create = function()
                        map("<M-j>", "<Down>", true)
                        map("<M-k>", "<Up>", true)
                    end,
                },
                defaults = {
                    git_icons = false,
                    file_icons = false,
                    color_icons = false,
                    formatter = "path.filename_first",
                },
            })

            map('<C-p>', fzf.files)
            map('fg', fzf.live_grep)
            map('fG', fzf.live_grep_native)
            map('fd', fzf.diagnostics_document)
            map('<leader><Space>', fzf.buffers)
        end,
    },
}
