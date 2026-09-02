-- VARIABLES
local map = vim.keymap.set
local hl = vim.api.nvim_set_hl
local autocmd = vim.api.nvim_create_autocmd

-- OPTIONS
vim.opt.backup = false
vim.opt.swapfile = false

vim.opt.encoding = "utf-8"
vim.opt.fileencodings = {
    "ucs-bom",                -- UTF-16/32 BOM marks
    "utf-8",                  -- UTF-8
    "euc-jp",                 -- EUC-JP
    "sjis",                   -- Shift JIS
    "cp1252",                 -- Windows-1252
    "latin1",                 -- ISO-8859-1
}
vim.opt.fileformats = { "unix", "dos" }
vim.opt.backspace = { "start", "eol", "indent" }

vim.api.nvim_exec("language en_US.UTF8", true)
vim.opt.clipboard = "unnamedplus"
vim.opt.expandtab = true

vim.opt.title = true
vim.opt.titlestring = "%t%m - nvim"

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
vim.opt.listchars = { tab = ">_", trail = "_", eol = "↲" }
vim.opt.fillchars = { eob = " " }
vim.opt.shortmess:append({I = true})

vim.opt.mouse = "a"
vim.opt.mousemodel = "extend"

-- KEYBINDS & AUTOCOMPLETE
map({"i", "c"}, "<C-v>", "<C-R>+")     -- Paste from clipboard (Ctrl + V)
map({"n", "v"}, "<C-v>", '"+gP')       -- Paste from the clipboard (Ctrl + V)
map({"n", "v"}, "<C-c>", '"+y')        -- Copy to the clipboard (Ctrl + C)
map({"v"}, "<C-x>", '"+x')             -- Cut to the clipboard (Ctrl + X)
map("x", "p", [["_dP]])                -- Fix overriden text being copied to clipboard
map({"n", "v"}, "<leader>d", [["_d]])  -- Fix deleted text being copied to clipboard

map("i", "'", "''<left>")
map("i", '"', '""<left>')
map("i", "(", "()<left>")
map("i", "[", "[]<left>")
map("i", "{", "{}<left>")

-- THEME
if vim.loop.os_uname().sysname == "Linux" and vim.env.DISPLAY == nil then
    vim.api.nvim_exec("silent! colorscheme industry", true)
    vim.api.nvim_set_hl(0, "TabLineSel", { ctermbg = 12 })
    vim.api.nvim_set_hl(0, "TabLineFill", { ctermbg = 7 })
else
    vim.opt.termguicolors = true
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "TabLineSel", { bg = "#4D78CC" })
    vim.api.nvim_set_hl(0, "StatusLine", { bg = "#2C2E33" })
    vim.api.nvim_set_hl(0, "CursorLine", {
        underline = true,
        sp = "#AFAFAF"
    })
end

-- LANGUAGE SPECIFIC
vim.api.nvim_create_autocmd("FileType", {
    pattern = "text",
    callback = function()
        vim.opt.wrap = true
        vim.opt.linebreak = true
        vim.opt.autoindent = false
        vim.opt.cindent = false
    end
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = "ps1",
    callback = function()
        vim.opt.fileformat = "dos"
    end
})
if vim.loop.os_uname().sysname == "Windows_NT" then
    vim.api.nvim_create_autocmd("BufNewFile", {
        pattern = "*.txt",
        callback = function()
            vim.opt.fileformat = "dos"
        end
    })
end

-- FILETYPES
vim.api.nvim_create_autocmd("FileType", {
    pattern = "ps1",
    callback = function()
        vim.bo.filetype = "PowerShell"
    end
})
vim.api.nvim_create_autocmd("FileType", {
    pattern = "sh",
    callback = function()
        vim.bo.filetype = "ShellScript"
    end
})

-- HIGHLIGHTS
if vim.loop.os_uname().sysname == "Linux" and vim.env.DISPLAY == nil then
    vim.api.nvim_set_hl(0, "StatusLineNormal", { ctermbg = 10 })
    vim.api.nvim_set_hl(0, "StatusLineInsert", { ctermbg = 14 })
    vim.api.nvim_set_hl(0, "StatusLineVisual", { ctermbg = 13 })
    vim.api.nvim_set_hl(0, "StatusLineCommand", { ctermbg = 9 })
else
    vim.api.nvim_set_hl(0, "StatusLineNormal", { bg = "#A7C080", fg = "#2C2E33" })
    vim.api.nvim_set_hl(0, "StatusLineInsert", { bg = "#7FBBB3", fg = "#2C2E33" })
    vim.api.nvim_set_hl(0, "StatusLineVisual", { bg = "#D699B6", fg = "#2C2E33" })
    vim.api.nvim_set_hl(0, "StatusLineCommand", { bg = "#E67E80", fg = "#2C2E33" })
    vim.api.nvim_set_hl(0, "StatusLineReplace", { bg = "#E69875", fg = "#2C2E33" })
    vim.api.nvim_set_hl(0, "StatusLineSelect", { bg = "#CFC9C2", fg = "#2C2E33" })
    vim.api.nvim_set_hl(0, "StatusLineClock", { bg = "#828BB8", fg = "#2C2E33" })
end

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

local function fileformat()
    if vim.bo.fileformat == "unix" then
        return "Unix[LF]"
    elseif vim.bo.fileformat == "dos" then
        return "DOS[CRLF]"
    elseif vim.bo.fileformat == "mac" then
        return "Mac[CR]"
    else
        return string.format("%s", vim.bo.fileformat):gsub("^%l", string.upper)
    end
end

local function clock()
    if vim.loop.os_uname().sysname == "Linux" and vim.env.DISPLAY == nil then
        return " %{strftime(\"%H:%M\")} "
    else
        return ""
    end
end

-- STATUSLINE
vim.opt.showmode = false
vim.opt.laststatus = 2
function StatusLine()
    local filetype = string.format("%s", vim.bo.filetype):gsub("^%l", string.upper)
    local fileencoding = string.format("  %s  ", vim.opt.fileencoding:get()):upper()
    local modified = vim.bo.modified and "+" or ""
    return table.concat({
        mode_colors(),
        vi_mode(),
        "%*",
        " %.40F ",
        modified,
        "%=",
        filetype,
        fileencoding,
        fileformat(),
        " %l:%c %P ",
        "%#StatusLineClock#",
        clock()
    })
end
vim.opt.statusline = "%!v:lua.StatusLine()"
