" Vim
" An example for a vimrc file.
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"             for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"
" Sourcing other files at the end of the file

set nocompatible        " Use Vim defaults (much better!) -- not needed, defaults to nocompatible when vimrc is found
set bs=indent,eol,start " allow backspacing over everything in insert mode
set ai                  " always set autoindenting on
"set backup             " keep a backup file
set viminfo='20,\"50    " read/write a .viminfo file, don't store more
                        " than 50 lines of registers
"set term=ansi          " always set TERM type as ansi (ansi looks better
                        " then linux on the console and works in an xterm)
set showmode
"set visualbell         " Don't beep
set laststatus=2        " Show the "status" bar
"set number             " Show line numbers
set magic
set showmatch           " Show matching bracket for last "}"
set autoindent
"set paste              " Don't autoindent when pasting. (adding commented for reference) 
set shiftwidth=4        " This is under the autoindenting.
set tabstop=2
set expandtab           " always uses spaces instead of tab characters
set ruler
set incsearch
set helpheight=45       " Height of the help window
set whichwrap=b,s,h,l   " Allow BS, Space, h, l to wrap at end or start of line
set ignorecase          " ignore case when using a search pattern
set smartcase           " override 'ignorecase' when pattern
                        " has upper case character
set formatoptions+=j    " Delete comment characters when joining lines += adds to existing option
set printoptions=paper:letter,header:0 ",duplex:off  " set printer paper type and other options.

" Maximum column in which to search for syntax items.  In long lines the text after this column is not
" highlighted and following lines may not be highlighted correctly, because the syntax state is cleared.
" setting to '0' removes the limit. 
set synmaxcol=0

" force syntax highlighting to parse from the start of the file (accurate, but can be slow for long files).
autocmd BufEnter * :syntax sync fromstart

" clear search highlighting with <ESC> -- Off because it breaks arrow key and pgup/pgdn movement in Normal mode. 
" nnoremap <ESC> :nohlsearch<CR><ESC>

" Dictionaries to use for keywork completion
set complete=k/usr/share/dict/*-english

" Function to source only if file exists {
function! SourceIfExists(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction
" }

" Include the Vundle config -- 8/29/12 moved up from the bottom of vimrc so syntax highlighing gets turned on correctly
"source ~/.vim/vimrc 
"call SourceIfExists("~/.vim/vimrc")
call SourceIfExists("$HOME/.vim/vimrc")
" include key mappings and functions in separate .map and .functions files
"source ~/.vim/vimrc.map 
"call SourceIfExists("~/.vim/vimrc.map")
call SourceIfExists("$HOME/.vim/vimrc.map")
"source ~/.vim/vimrc.functions 
"call SourceIfExists("~/.vim/vimrc.functions")
call SourceIfExists("$HOME/.vim/vimrc.functions")

" Abbreviations
iab #i #include

" Abbreviations to fix common spelling errors
iab alos      also
iab aslo      also
iab bianry    binary
iab bianries  binaries
iab charcter  character
iab charcters characters
iab convence  convince
iab exmaple   example
iab exmaples  examples
iab mroe      more
iab possiblities    possibilities
iab reciently recently
iab receintly recently
iab shoudl    should
iab seperate  separate
iab serveral  several
iab teh       the
iab tpyo      typo
iab wwww   www

" In text files, always limit the width of text to 78 characters #vim from RH61 complains about this
" autocmd BufRead *.txt set tw=78 

" Don't use Ex mode, use Q for formatting
map Q gq

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set background=dark
  set hlsearch
  hi StatusLine cterm=bold ctermfg=lightgreen ctermbg=darkblue gui=bold guifg=lightgreen guibg=blue
endif

" Turn on black BG grey FG in gvim
if has("gui_running")
  highlight Normal guibg=black
  highlight Normal guifg=grey
endif

" Give me the right colours regaurdless of if you were called gvim or
"   vim. if you were smart you'd do this auto-friggin-magically
"
"hi Comment    ctermfg=DarkCyan
hi Comment    ctermfg=Blue
hi Identifier ctermfg=DarkCyan
"hi Identifier ctermfg=Grey
hi Constant   ctermfg=DarkMagenta
"hi Special    ctermfg=Red
"hi Statement  ctermfg=yellow
hi PreProc    ctermfg=LightCyan
hi Type       ctermfg=LightGreen
hi Error      ctermfg=Black      ctermbg=Red
hi Todo       ctermfg=Black      ctermbg=Yellow
"hi Search     ctermfg=Blue  ctermbg=Cyan
"hi Conditional ctermfg=Green

augroup cprog
  " Remove all cprog autocommands
  au!

  " When starting to edit a file:
  "   For *.c and *.h files set formatting of comments and set C-indenting on.
  "   For other files switch it off.
  "   Don't change the order, it's important that the line with * comes first.
"  autocmd BufRead *       set formatoptions=tcql nocindent comments&
"  autocmd BufRead *.c,*.h set formatoptions=croql cindent comments=sr:/*,mb:*,el:*/,://
augroup END

"augroup gzip
"  " Remove all gzip autocommands
"  au!
"
"  " Enable editing of gzipped files
"  "   read: set binary mode before reading the file
"  "  uncompress text in buffer after reading
"  "  write: compress file after writing
"  " append: uncompress file, append, compress file
"  autocmd BufReadPre,FileReadPre *.gz set bin
"  autocmd BufReadPost,FileReadPost *.gz let ch_save = &ch|set ch=2
"  autocmd BufReadPost,FileReadPost *.gz '[,']!gunzip
"  autocmd BufReadPost,FileReadPost *.gz set nobin
"  autocmd BufReadPost,FileReadPost *.gz let &ch = ch_save|unlet ch_save
"  autocmd BufReadPost,FileReadPost *.gz execute ":doautocmd BufReadPost " . expand("%:r")

"  autocmd BufWritePost,FileWritePost *.gz !mv <afile> <afile>:r
"  autocmd BufWritePost,FileWritePost *.gz !gzip <afile>:r

"  autocmd FileAppendPre   *.gz !gunzip <afile>
"  autocmd FileAppendPre   *.gz !mv <afile>:r <afile>
"  autocmd FileAppendPost  *.gz !mv <afile> <afile>:r
"  autocmd FileAppendPost  *.gz !gzip <afile>:r
"augroup END

" When editing a file, always jump to the last cursor position.
" This must be after the uncompress commands.
autocmd BufReadPost * if line("'\"") && line("'\"") <= line("$") | exe "normal `\"" | endif

