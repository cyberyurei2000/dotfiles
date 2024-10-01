-- VARIABLES
local map = vim.keymap.set
local hl = vim.api.nvim_set_hl
local autocmd = vim.api.nvim_create_autocmd

-- OPTIONS
vim.opt.backup = false
vim.opt.swapfile = false

vim.opt.fileencoding = "utf-8"
vim.opt.fileformats = {"unix", "dos"}
vim.opt.backspace = {"start", "eol", "indent"}

vim.cmd [[silent! language en_US.UTF-8]]
vim.opt.clipboard = "unnamedplus"
vim.opt.expandtab = true

vim.opt.cursorline = true
vim.opt.wrap = false
vim.opt.number = true
vim.opt.ruler = true
vim.opt.cindent = true
vim.opt.autoindent = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.showtabline = 2

vim.opt.list = true
vim.opt.listchars = {tab = ">_", trail = "_"}
vim.opt.shortmess:append({I = true})

vim.opt.mouse = "a"
vim.opt.mousemodel = "extend"

-- KEYBINDS & AUTOCOMPLETE
map({"i", "c"}, "<C-v>", "<C-R>+") -- Paste from clipboard (Ctrl + V)
map({"n", "v"}, "<C-v>", '"+gP') -- Paste from the clipboard (Ctrl + V)
map({"n", "v"}, "<C-c>", '"+y') -- Copy to the clipboard (Ctrl + C)
map({"v"}, "<C-x>", '"+x') -- Cut to the clipboard (Ctrl + X)
map("x", "p", [["_dP]]) -- Fix overriden text being copied to clipboard
map({"n", "v"}, "<leader>d", [["_d]]) -- Fix deleted text being copied to clipboard

map("i", "'", "''<left>")
map("i", '"', '""<left>')
map("i", "(", "()<left>")
map("i", "[", "[]<left>")
map("i", "{", "{}<left>")

-- THEME
if vim.env.DISPLAY == nil and vim.fn.has("linux") then
    vim.cmd [[silent! colorscheme industry]]
else
    vim.opt.termguicolors = true
    vim.cmd [[silent! colorscheme tokyonight-storm]]
    if vim.g.colors_name == "tokyonight-storm" then
        vim.cmd [[silent! highlight TabLineSel guibg=#F7768E]]
    end
end

-- LANGUAGE SPECIFIC
autocmd({"BufRead", "BufEnter"}, {
    pattern = {"*.txt"},
    callback = function()
        vim.opt.wrap = true
        vim.opt.linebreak = true
        vim.opt.autoindent = false
        vim.opt.cindent = false
    end
})
autocmd({"BufRead", "BufEnter"}, {
    pattern = {"*.ps1"},
    callback = function()
        vim.opt.fileformats = "dos"
    end
})

-- HIGHLIGHTS
hl(0, "StatusLineNormal", {bg = "#2AC3DE", fg = "#222432"})
hl(0, "StatusLineInsert", {bg = "#9ECE6A", fg = "#222432"})
hl(0, "StatusLineVisual", {bg = "#BB9AF7", fg = "#222432"})
hl(0, "StatusLineCommand", {bg = "#F7768E", fg = "#222432"})
hl(0, "StatusLineReplace", {bg = "#FF9E64", fg = "#222432"})
hl(0, "StatusLineSelect", {bg = "#CFC9C2", fg = "#222432"})
hl(0, "StatusLineClock", {bg = "#828BB8", fg = "#222432"})

-- FUNCTIONS
local function vi_mode()
    local modes = {
        ["n"] = "NORMAL",
        ["no"] = "NORMAL",
        ["v"] = "VISUAL",
        ["V"] = "VISUAL LINE",
        [""] = "VISUAL BLOCK",
        ["s"] = "SELECT",
        ["S"] = "SELECT LINE",
        [""] = "SELECT BLOCK",
        ["i"] = "INSERT",
        ["ic"] = "INSERT",
        ["R"] = "REPLACE",
        ["Rv"] = "VISUAL REPLACE",
        ["c"] = "COMMAND",
        ["cv"] = "VIM EX",
        ["ce"] = "EX",
        ["r"] = "PROMPT",
        ["rm"] = "MOAR",
        ["r?"] = "CONFIRM",
        ["!"] = "SHELL",
        ["t"] = "TERMINAL",
    }

    local current_mode = vim.api.nvim_get_mode().mode
    return string.format(" %s ", modes[current_mode]):upper()
end

local function mode_colors()
    local mode = vim.api.nvim_get_mode().mode
    local color = "%#StatusLineNormal#"
    if mode == "n" then
        color = "%#StatusLineNormal#"
    elseif mode == "i" or mode == "ic" then
        color = "%#StatusLineInsert#"
    elseif mode == "v" or mode == "V" or mode == "" then
        color = "%#StatusLineVisual#"
    elseif mode == "c" then
        color = "%#StatusLineCommand#"
    elseif mode == "R" or mode == "Rv" then
        color = "%#StatusLineReplace#"
    elseif mode == "s" or mode == "S" or mode == "" then
        color = "%#StatusLineSelect#"
    elseif mode == "t" then
        color = "%#StatusLineCommand#"
    end
    return color
end

local function filetype()
    if vim.bo.filetype == "ps1" then
        return "PowerShell"
    elseif vim.bo.filetype == "sh" then
        return "Shell"
    else
        return string.format("%s", vim.bo.filetype):gsub("^%l", string.upper)
    end
end

local function fileformat()
    if vim.bo.fileformat == "unix" then
        return "Unix(LF)"
    elseif vim.bo.fileformat == "dos" then
        return "DOS(CRLF)"
    elseif vim.bo.fileformat == "mac" then
        return "Mac(CR)"
    else
        return string.format("%s", vim.bo.fileformat):gsub("^%l", string.upper)
    end
end

local function clock()
    if vim.env.DISPLAY == nil and vim.fn.has("linux") then
        return " %{strftime(\"%H:%M\")} "
    else
        return ""
    end
end

-- STATUSLINE
vim.opt.showmode = false
vim.opt.laststatus = 2
function StatusLine()
    local fileencoding = string.format("  %s  ", vim.opt.fileencoding:get()):upper()
    return table.concat({
        mode_colors(),
        vi_mode(),
        "%*",
        " %.40F ",
        "%=",
        filetype(),
        fileencoding,
        fileformat(),
        " %l:%c %P ",
        "%#StatusLineClock#",
        clock()
    })
end
vim.opt.statusline = "%!v:lua.StatusLine()"
