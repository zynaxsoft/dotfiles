==============================================
My customized help file to be searched later!
==============================================

# Open diff from vim

usually we can just do `vimdiff file1 file2`
Though it requires input of file1 and file2.

We can simply open either file1 or file2 first.
Then use `:diffs .`
Then navigate with netrw to open the another file
Then `:difft` on that new window.

Then use `do` (diffput) to select the diff you want to use!


# Vim Surround
edit surrounding stuff
cs{surround char}{new char}
replace surround char with new char

# Vim Sneak
move to specified exactly 2 characters with [count]s{char}{char}
There is also [count]dz{char}{char} to delete until those chars

# Grepping
Grepping to quickfix is quite wierd.
`:grep <args>` --> `rg --vimgrep <args>`
However in the vim command line we can't put `|` directly, so when
we want to use it in the patter we need to escape it `\|`. Otherthan that
just enclosed it within a string and we don't need to escape brackets
like in vim grep.
Ex. `:grep "logger\.(info\|error)"`

# Editing command line
use <C-f> to enter normal mode in command line and use <C-c> to return
or just press Enter to submit.
