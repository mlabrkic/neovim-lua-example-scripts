-- date: 2022-12M-23 14:58:52
--[[
------------------------------------------------------------
No 0)
opt02_nvim-opt-surv_gr.lua
(-->  02neovim-options-survey_groups.txt)

------------------------------------------------------------
No 1)
Neovim, open "02neovim-options-survey_groups.txt"
Goto buffer "02neovim-options-survey_groups.txt"

No 2)
Run this script!
:so C:\Users\<user name>\Documents\opt03_sort_nvim-opt-surv_gr.lua

No 3)
write buffer
:w

------------------------------
I want this:
03sortNeovim-options-survey_groups.txt :

pastetoggle,"", 1 important
compatible,false, 1 important
sections,"SHNHH HUnhsh", 2 moving around
casemap,"internal,keepascii", 2 moving around
cdhome,false, 2 moving around
...
exrc,false, 26 various

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

----------
5.1  Basic Functions
h luaref-libBasic

h luaref-tonumber

----------
5.4 - String Manipulation
h luaref-libString

h string.sub
h string.len
h string.match

h luaref-patterns
- `%a`  represents all letters.
- `%d`  represents all digits.

----------
5.5  Table Manipulation
h luaref-libTable

h table.concat
h table.sort

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
Tables
-->
4.3 Other Table Methods

Sort list elements in a given order, in-place.
If "comp" is given, then it must be a function that receives two list elements and
returns "true" when the first element must come before the second in the final order.
If "comp" is not given, then the standard Lua operator < is used instead.

local T = {"John", "Mary", "Thomas"}

-- create a comparison function to sort according to the second letter
local function comp(s1, s2)
    return string.sub(s1,2,2) > string.sub(s2,2,2)
end

-- sort the table according to this function
table.sort(T, comp) --> T = {John, Thomas, Mary}

]]
------------------------------------------------------------

local A = vim.api

-- nvim_create_buf({listed}, {scratch})
local bufnr = A.nvim_create_buf(true, false)

A.nvim_buf_set_name(bufnr, '03sortNeovim-options-survey_groups.txt')  -- Assign a name to the new buffer
A.nvim_buf_set_option(bufnr, 'buftype', '')  -- set buftype="" (because I want to save the file)

------------------------------
--[[
local T = {"John", "Mary", "Thomas"}
local T = {"imsearch, 24 language 1 specific", "paste, 1 important 7", "listchars, 4 displaying 2 text"}
]]

-- Neovim, open "02neovim-options-survey_groups.txt"
-- The entire buffer is loaded into the table.
local myTable = A.nvim_buf_get_lines(0, 0, -1, false)

------------------------------
-- create a comparison function to sort according to the second letter
-- h luaref-tonumber
local function comp(s1, s2)
  -- return string.match(s1, ',%s%d+') < string.match(s2, ',%s%d+')
  return tonumber(string.match(s1, '%s%d+%s')) < tonumber(string.match(s2, '%s%d+%s'))
end

-- sort the table according to this function
-- h table.sort
table.sort(myTable, comp)

------------------------------
-- print("After sort:")
-- print(vim.inspect(myTable))

--[[
h nvim_buf_set_lines
]]
A.nvim_buf_set_lines(bufnr, 0, -1, true, myTable)
A.nvim_set_current_buf(bufnr)

