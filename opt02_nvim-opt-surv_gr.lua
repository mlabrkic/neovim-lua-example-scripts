-- date: 2022-12M-22 14:43:56
--[[
------------------------------------------------------------
No 0)

opt00_nvim-opt-survey.lua (-->  00optionsDefault.txt)
opt01_opt-window_gr.lua (-->  01optionsGroups.txt)

------------------------------------------------------------
No 1)

Exit Neovim.
A) Neovim, open 01optionsGroups.txt (:ls  --> buf_id=1)
B) Neovim, open 00optionsDefault.txt

C) Goto buffer "00optionsDefault.txt"

------------------------------
No 2)
Run this script!

https://github.com/nanotee/nvim-lua-guide#sourcing-lua-files
:luafile "path to"\opt02_nvim-opt-surv_gr.lua

Example:
:so C:\Users\<user name>\Documents\opt02_nvim-opt-surv_gr.lua

------------------------------
I want this:
02neovim-options-survey_groups.txt :

aleph,224, 24 language specific
allowrevins,false, 24 language specific
ambiwidth,"single", 25 multi-byte characters
arabic,false, 24 language specific
arabicshape,true, 24 language specific
autochdir,false, 2 moving around
...

-- #########################################################

RESOURCES (Neovim Lua API):

https://www.davekuhlman.org/nvim-lua-info-notes.html
Published
Fri 29 April 2022

https://jacobsimpson.github.io/nvim-lua-manual/docs/buffers-and-windows/

https://github.com/nanotee/nvim-lua-guide

------------------------------------------------------------
NOTE:

------------------------------
-- 02:
h luaref-Lib

5  STANDARD LIBRARIES

5.4 - String Manipulation
h luaref-libString

h string.sub
h string.len
h string.match

h luaref-patterns
- `%a`  represents all letters.
- `%d`  represents all digits.

------------------------------
-- 03:
h lua.txt

---------------
Lua module: vim
h lua-vim

h vim.split
h vim.trim

------------------------------
-- 04:
Nvim API
h api.txt

Options Functions
h api-options
h nvim_buf_set_option

Buffer Functions
h api-buffer
-->
h nvim_buf_set_name
h nvim_buf_line_count
h nvim_buf_get_lines
h nvim_buf_set_lines

Global Functions
h api-global
-->
h nvim_create_buf
h nvim_get_current_line
h nvim_get_current_buf
h nvim_list_bufs
h nvim_notify

------------------------------------------------------------
h buffers

------------------------------------------------------------
Lua Quick Guide -
https://github.com/medwatt/Notes/blob/main/Lua/Lua_Quick_Guide.ipynb

Lua_Quick_Guide.pdf

2.3 Pattern Matching
string.match(line1, '^.%d')

h luaref-patterns
- `%a`  represents all letters.
- `%d`  represents all digits.
-- %A represents all non-letter characters.

------------------------------
5.5 Variable Number of Arguements

-- `_` is a placeholder for a variable whose value we don't care about

for _, value in ipairs(arg) do
  sum = sum + value
end

------------------------------
h luaref-pairs

for k,v in pairs(t) do
`body`
end

------------------------------------------------------------
h vim.split

lua line = vim.api.nvim_get_current_line()
lua =line
lua words = vim.split(line, ",")

lua =words[1]
lua =words[2]
lua print(words[1])
lua print(words[2])

------------------------------------------------------------
]]

------------------------------------------------------------
local A = vim.api

-- nvim_create_buf({listed}, {scratch})
local bufnr = A.nvim_create_buf(true, false)

A.nvim_buf_set_name(bufnr, '02neovim-options-survey_groups.txt')  -- Assign a name to the new buffer
A.nvim_buf_set_option(bufnr, 'buftype', '')  -- set buftype="" (because I want to save the file)

------------------------------
-- The entire buffer is loaded into the table.
-- A) Options_groups.txt (:ls  --> buf_id=1)
local myTable1 = A.nvim_buf_get_lines(1, 0, -1, false)
--[[
packpath, 1 important
helpfile, 1 important
whichwrap, 2 moving around, searching and patterns
startofline, 2 moving around, searching and patterns
]]
------------------------------
-- The entire buffer is loaded into the table.
-- B) optionsDefault.txt
local myTable = A.nvim_buf_get_lines(0, 0, -1, false)
--[[
aleph,224
allowrevins,false
ambiwidth,"single"
arabic,false
]]
------------------------------

-- Start creating output lines
local lines = { '---Start---' }
local option_lines = {}

for _,line in pairs(myTable) do

  local words = vim.split(line, ",")
  local firstWord = words[1]

  for _,line1 in pairs(myTable1) do
    local words1 = vim.split(line1, ", ")
    local firstWord1 = words1[1]
    if (firstWord == firstWord1) then
      local secondWord1 = words1[2]
      -- print(line .. ", " .. secondWord1)
      table.insert(option_lines, line .. ", " .. secondWord1)
    end
  end

end

--[[
h vim.list_extend
]]
vim.list_extend(lines, option_lines)

table.insert(lines, '---END---')

--[[
h nvim_buf_set_lines
]]
A.nvim_buf_set_lines(bufnr, 0, -1, true, lines)
A.nvim_set_current_buf(bufnr)

