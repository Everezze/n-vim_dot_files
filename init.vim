"MAIN CONFIG FILE FOR NVIM
runtime html_renamer.vim

set encoding=utf-8
scriptencoding utf-8
"language messages English_United States
"set langmenu=en_US.UTF-8  

" Vim with all enhancements
"source $VIMRUNTIME/vimrc_example.vim ------------ my comment here : "It was in the vimrc config file

" Use the internal diff if available.
" Otherwise use the special 'diffexpr' for Windows.
if &diffopt !~# 'internal'
  set diffexpr=MyDiff()
endif
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg1 = substitute(arg1, '!', '\!', 'g')
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg2 = substitute(arg2, '!', '\!', 'g')
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let arg3 = substitute(arg3, '!', '\!', 'g')
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  let cmd = substitute(cmd, '!', '\!', 'g')
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction


"set guifont=JetBrains\ 14
"set guifont=JetBrains_Mono:h12:cDEFAULT
"set guifont=Iosevka_SS18:h14:cDEFAULT
"set lines =50
"set columns =120
"winpos 350 150
set textwidth=80
set linebreak
set wrapmargin=0
set formatoptions=cqt
set wildmenu
set splitbelow splitright
set winheight =15
set list
"set listchars=tab:>-,trail:.
set listchars=tab:\|·,space:·,eol:↴,multispace:···•
set noundofile
set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching 
set ignorecase              " case insensitive 
set mouse=v                 " middle-click paste with 
"set hlsearch                " highlight search 
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab 
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
"set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
filetype plugin indent on   "allow auto-indenting depending on file type
set number                  " add line numbers
set relativenumber
set wildmode=longest,list   " get bash-like tab completions
set cc=200                  " set an 200 column border for good coding style
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamed       " using system clipboard
set showcmd
set hidden
set guioptions-=m
set guioptions-=T
set nohlsearch
set complete+=kspell
set completeopt=menuone,noinsert
set spell spelllang=en_us
set spellsuggest=best,9
set noswapfile
set nobackup
set timeoutlen=400
set cursorline
set cursorlineopt=both
set fileformat=unix
set fileformats=unix
set foldcolumn=1
set matchtime=2
set noshowmode
set noruler

if (has("termguicolors"))
 set termguicolors
endif
"----------------------- MY PLUGINS -----------------------------

call plug#begin(stdpath("config") . '/plugged')
    Plug 'folke/tokyonight.nvim', {'branch':'main'}
    Plug 'luisiacc/gruvbox-baby', {'branch':'main'}
    Plug 'rose-pine/neovim'
    Plug 'bluz71/vim-nightfly-colors'
    Plug 'rebelot/kanagawa.nvim'
    Plug 'ap/vim-css-color'

    "Plug 'morhetz/gruvbox'
    "Plug 'EdenEast/nightfox.nvim'
    "Plug 'sonph/onehalf', {'rtp':'vim'}
    "Plug 'kyoz/purify', { 'rtp': 'vim' }
    "Plug 'srcery-colors/srcery-vim'
    "Plug 'ayu-theme/ayu-vim'
    "Plug 'jmoggee/mirage.vim'
    "Plug 'elvessousa/sobrio'
    "Plug 'atelierbram/Base2Tone-vim'
    "Plug 'yegappan/lsp'
    "Plug 'neoclide/coc.nvim', {'branch': 'release'} 
    "Plug 'dracula/vim', { 'as': 'dracula' }
    "Plug 'navarasu/onedark.nvim'
    "Plug 'matsuuu/pinkmare'
    "Plug 'mhartington/oceanic-next'
    "Plug 'williamboman/nvim-lsp-installer'

    Plug 'neovim/nvim-lspconfig'

    "Snippet plugin for creating snippets and customize them
    Plug 'L3MON4D3/LuaSnip'

    "Classifying auto-completion engine and sources subject to the classification
    Plug 'hrsh7th/nvim-cmp'
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-buffer'
    Plug 'hrsh7th/cmp-path'
    Plug 'saadparwaiz1/cmp_luasnip'
    Plug 'f3fora/cmp-spell'

    "for a better syntax highlighting
    "Plug 'sheerun/vim-polyglot'
call plug#end()

"let g:gruvbox_(option) = '(value)'"
"autocmd vimenter * ++nested colorscheme gruvbox



"let g:gruvbox_contrast_dark = 'hard'
"let g:gruvbox_termcolors = 256
"let ayucolor="mirage"




"----------------------- THEME SETUP -----------------------------

"set background= dark
"let g:srcery_black = '#282828'
colorscheme kanagawa
"let g:onedark_config = {
    "\'style': 'warmer',
"\}
"let g:airline_theme='badwolf'
"let g:airline_left_sep = ''
"let g:airline_right_sep = ''
"
"

"changing default path for saving the files
if getcwd() ==? 'C:\Windows\System32' || getcwd() ==? 'C:\Program Files (x86)\Neovim\bin'
    cd ~/Desktop
endif


"-----------------------------------MAPPINGS START-----------------------------------

let mapleader= " "

"get the column of the mark
noremap <leader>' `

nnoremap <leader>o :vsplit $MYVIMRC<CR>
nnoremap <leader>at @
nnoremap <silent> gs :w<CR>
"gs above is initially for 'go sleep' command

"--------------------NAVIGATE ALONG A LINE--------------------
"cursor on line above on first non-blank char
noremap <C-k> -
noremap <C-h> _
noremap <C-l> g_
noremap <C-j> +
noremap <C-;> kg_
noremap <C-m> jg_
noremap <leader>gj j0
noremap <leader>gk k0
noremap <leader>g; k$
noremap <leader>gm j$
noremap <leader>gh 0
noremap <leader>gl $
noremap gm gM
noremap gM gm

"having pairs for common special characters
"inoremap kj <Esc> removed because autohotkey script remaps Caps to Esc
inoremap <C-/> ''<Left>
inoremap <C-/><C-/> ''
inoremap <C-.> []<Left>
inoremap <C-.><C-.> []
inoremap <C-'> ""<Left>
inoremap <C-'><C-'> ""
inoremap <C-;> {}<Left>
inoremap <C-;><C-;> {}
inoremap <C-,> ()<Left>
inoremap <C-,><C-,> ()

"--------------------WINDOWS REMAPPINGS--------------------
nnoremap <leader>h <C-W>h
nnoremap <leader>j <C-W>j
nnoremap <leader>k <C-W>k
nnoremap <leader>l <C-W>l
nnoremap <leader>c <C-W>c

"open new window (same as :split or :vsplit and :enew)
nnoremap <silent> <leader>vn :vnew<CR>
nnoremap <silent> <leader>sn :new<CR>
nnoremap <leader>sk <C-W>s
nnoremap <leader>vk <C-W>v
"split horiz or vert with a filename
nnoremap <leader>sf :split 
nnoremap <leader>vf :vsplit 

"quit and hard quit! window
nnoremap <leader>q <C-W>q
nnoremap <leader>fq :q!<CR>

"put focused window at top/bottom  full width or far right/left full height
nnoremap <leader>fj <C-W>J
nnoremap <leader>fk <C-W>K
nnoremap <leader>fl <C-W>L
nnoremap <leader>fh <C-W>H


"EQUALIZE, INCREASE OR DECREASE WINDOWS
"set window height by N or max default
nnoremap <leader>fwh <C-W>_
"set window width by N or max default
nnoremap <leader>fww <C-W>\|
"increase window width
nnoremap <leader>fi 5<C-W>>
"decrease window width
nnoremap <leader>fd 5<C-W><
"decrease window height
nnoremap <leader>f, 5<C-W>-
"increase window height
nnoremap <leader>f; 5<C-W>+
"make all windows equal
nnoremap <leader>fe <C-W>=
"make horiz and vert equalizer remaps
"nnoremap <leader>fe <C-W>=
"nnoremap <leader>fe <C-W>=

"SWAPPING WINDOWS PLACE
"exchange window place with next one if last change with previous
"with count exchange with Nth window
"cursor is put in the other window
nnoremap <leader>fx <C-W>x

"rotate downwards/rightwards row or column of windows the curr win is in
"cursor remains in the same window
nnoremap <leader>fro <C-W>r

"rotate upwards/leftwards row or column of windows the curr win is in
"cursor remains in the same window
nnoremap <leader>fri <C-W>R

"SWAPPING WINDOWS FOCUS
"cursor to below/right window of curr one
nnoremap <leader>fm <C-W>w
"cursor to above/left window of curr one
nnoremap <leader>fg <C-W>W
"cursor to top-left window
nnoremap <leader>ft <C-W>t
"cursor to bottom-right window
nnoremap <leader>fb <C-W>b
"last accessed window
nnoremap <leader>fp <C-W>p

"focus on preview/floating(fl) window
nnoremap <leader>fy <C-W>P

"search file on cursor and split it if found else do nothing
"go to specified line for fsl
nnoremap <leader>fsk <C-W>f
nnoremap <leader>fsl <C-W>F

"quit all windows except focused one or Nth one
"changes not lost so safe command
nnoremap <leader>fo <C-W>o

"split window and edit alternate file or the Nth buffer
nnoremap <leader>fa <C-W>^

"move current window to NEW tabpage, will be opened after current tabpage or
"before the Nth one specified
"Fails if there is only one window
nnoremap <leader>fn <C-W>T

"--------------------BUFFER REMAPPINGS--------------------
"add filename to buffer list without loading it
"balt sets alternate file for current window to filename
nnoremap <leader>ia :badd 
nnoremap <leader>it :balt 

nnoremap <leader>ii :buf 
nnoremap <leader>ihi :buf! 
nnoremap <leader>is :sbuf 

"changes are lost with '!'
nnoremap <leader>id :bdel 
nnoremap <leader>idi :bdel<CR>
nnoremap <leader>ihd :bdel! 
nnoremap <leader>ihdi :bdel!<CR>
nnoremap <leader>ird :bdel<Left><Left><Left><Left>
nnoremap <leader>ihrd :bdel!<Left><Left><Left><Left><Left>

"changes are lost with '!'
nnoremap <leader>iw :bwipe 
nnoremap <leader>iwi :bwipe<CR>
nnoremap <leader>ihw :bwipe! 
nnoremap <leader>ihwi :bwipe!<CR>
nnoremap <leader>irw :bwipe<Left><Left><Left><Left>
nnoremap <leader>ihrw :bwipe!<Left><Left><Left><Left><Left><Left>

"changes are lost with '!'
nnoremap <leader>iu :bunload 
nnoremap <leader>iui :bunload<CR>
nnoremap <leader>ihu :bunload! 
nnoremap <leader>ihui :bunload!<CR>
nnoremap <leader>iru :bunload<Left><Left><Left><Left><Left><Left><Left>
nnoremap <leader>ihru :bunload!<Left><Left><Left><Left><Left><Left><Left><Left>

nnoremap <leader>in :bnext 
nnoremap <leader>ini :bnext<CR>
nnoremap <leader>ihn :bnext! 
nnoremap <leader>ihni :bnext!<CR>
nnoremap <leader>isn :sbnext 
nnoremap <leader>isni :sbnext<CR>

nnoremap <leader>ib :bprev 
nnoremap <leader>ibi :bprev<CR>
nnoremap <leader>ihb :bprev! 
nnoremap <leader>ihbi :bprev!<CR>
nnoremap <leader>isb :sbprev 
nnoremap <leader>isbi :sbprev<CR>

nnoremap <leader>if :bfirst<CR>
nnoremap <leader>ihf :bfirst!<CR>
nnoremap <leader>isf :sbfirst<CR>

nnoremap <leader>il :blast<CR>
nnoremap <leader>ihl :blast!<CR>
nnoremap <leader>isl :sblast<CR>

"also looks for unlisted buffers, if no modified buffers command fails
nnoremap <leader>im :bmod 
nnoremap <leader>imi :bmod<CR>
nnoremap <leader>ihm :bmod!
nnoremap <leader>ihmi :bmod!<CR>
nnoremap <leader>ism :sbmod 
nnoremap <leader>ismi :sbmod<CR>

"open one window for each buffer in the buff list
"max number of window to open can be given with N
nnoremap <leader>isa :sball 

"switch between current and alternate buffer
nnoremap <leader>al <C-^>
"--------------------CASE exchanges REMAPPINGS--------------------
"re-routing prefix gu to avoid typing uppercase letters as shift key
"can be hard to reach
nnoremap gu gU
nnoremap guk gUU
nnoremap gl gu
nnoremap ga g~
nnoremap gak g~~

"--------------------TAB PAGES MAPPINGS--------------------
"go to next tab page, previous tab page and last accessed tab page
"here gT goes to nth tab pages back not taking tab page number unlike gt
nnoremap <leader>tj gT
nnoremap <leader>tk gt
nnoremap <leader>tt g<Tab>

"new tab with empty window of on a buffer filename, placed after the current tab
"or after the Nth tab specified
nnoremap <leader>tn :tabnew 
nnoremap <leader>tnk :tabnew<CR>
nnoremap <leader>tcn :tabnew <Left><Left><Left><Left><Left><Left><Left>

"new tab and edit filename found in 'path' option
"place the tab after the current one or after the Nth one specified
nnoremap <leader>ts :tabfind 
nnoremap <leader>tcs :tabfind <Left><Left><Left><Left><Left><Left><Left><Left>

"go to first and last tab page
nnoremap <leader>tfk :tabfirst<CR>
nnoremap <leader>tl :tablast<CR>

"new tab on the filename under cursor (go to specific line for tfl)
nnoremap <leader>tfi <C-W>gf
nnoremap <leader>tfl <C-W>gF

"destroy(close) current tab page or the Nth one specified
"safe command changes never lost
nnoremap <leader>td :tabclose<CR>
nnoremap <leader>tcd :tabclose 
nnoremap <leader>thd :tabclose!<CR>
nnoremap <leader>thcd :tabclose! 

"close all but the current tab page or the Nth one specified
"safe command changes never lost
nnoremap <leader>to :tabonly<CR>
nnoremap <leader>tco :tabonly 
nnoremap <leader>tho :tabonly!<CR>
nnoremap <leader>thco :tabonly! 

"move tabs place after tab page N if no N it is made the last one.
nnoremap <leader>tm :tabmove<CR>
nnoremap <leader>tcm :tabmove 
"move tab page Nth places to right or left
nnoremap <leader>tpk :tabmove +
nnoremap <leader>tpj :tabmove -

nnoremap <leader>tsa :tab sball 
"--------------------FUNCTIONAL REMAPPINGS--------------------
inoremap <expr> <C-j> Add_indent_to_new_line()
nnoremap c<C-,> :call Rename_tag()<CR>
"--------------------GET HSL COLORS FOR CSS FILES--------------------
if has('linux')
	augroup get_hsl
		autocmd!
		autocmd FileType css nnoremap gcl :.!get-hsl.sh<CR>
	augroup END
endif
"-----------------------------------MAPPINGS END-----------------------------------

"unsetting/setting relative number for focus and insert mode 
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

function Add_indent_to_new_line() 
    echomsg "called"
    let cursor_position  = col(".")
    let char_before = cursor_position - 1
    let char_after = cursor_position + 1
    echomsg 'cursor pos: '.cursor_position
    echomsg 'char before: '.char_before
    echomsg 'char after: '.char_after
    echomsg type(getline(".")[col(".")-2]) . "(".getline(".")[col(".")-2].")"
    echomsg type(getline(".")[col(".")]) . "(".getline(".")[col(".")].")"
    "normal! a O
    "execute "normal! a"."\<cr>"."\<C-o>O"."\<Esc>"
    ""execute "insert"." "."O"
    "return "\<C-j>\<C-o>O"


    "if getline(".")[col(".")-1] == ">" && getline(".")[col(".")+1] == "<"
    "    insert <C-j>
    "    normal O
    "else
    "    echo 'ok'
    "endif
    if getline(".")[charcol(".")-2] == "{" && getline(".")[charcol(".")] == ""
        return "\<C-j>\<C-o>O"
    "        insert <C-j>
    "        normal O
    "    endif
    elseif getline(".")[charcol(".")-2] == "(" && getline(".")[charcol(".")] == ""
        return "\<C-j>\<C-o>O"
    "        insert <C-j>
    "        normal O
    "    endif
    elseif getline(".")[charcol(".")-2] == "[" && getline(".")[charcol(".")] == ""
        return "\<C-j>\<C-o>O"
    "        insert <C-j>
    "        normal O
    "    endif
    elseif getline(".")[charcol(".")-2] == ">" && getline(".")[charcol(".")] == "/"
        return "\<C-j>\<C-o>O"
    "        insert <C-j>
    "        normal O
    "    endif
    else
        return "\<C-j>"
    endif
endfunction

"-----------------------------------netrw mappings-----------------------------------
nnoremap <leader>n :Vexplore!<CR>

let g:html_indent_script1="inc"
let g:html_indent_style1="inc"

augroup add_php_indent
	autocmd!
	"autocmd FileType php let b:PHP_default_indenting=1
	autocmd FileType php set autoindent
augroup end

runtime highlight_yank.vim
runtime perso_statusline.vim

lua << EOF
 require('my_lsp_config')
EOF


lua << EOF
local kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}
local cmp = require'cmp'

  -- Setup nvim-cmp.
  cmp.setup{

    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
      end,
    },

    mapping = {
      ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item()),
      ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item()),
      ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
      ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
      ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
      ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
      ['<C-e>'] = cmp.mapping({
        i = cmp.mapping.abort(),
        c = cmp.mapping.close(),
      }),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },

    sources = {
      { name = 'nvim_lsp' },
      { name = 'luasnip' }, -- For luasnip users.
      { name = 'buffer'},
      { name ='spell', keyword_length=5},
    },

    formatting={
        fields= {"abbr","kind","menu"},
        format = function(entry, vim_item)
            vim_item.kind=string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
            vim_item.menu= ({
                nvim_lsp=' ',
                luasnip='',
                buffer=' ',
                path='ﱮ ',
                spell='暈',
            })[entry.source.name]
            return vim_item
        end,
    }

  }
EOF


"---------macro assignment and changing surroundings---------
"function! AssignCharToMacro()
    "let chr =""
    "let action= getchar()
    "let oldchar= getchar()
    "let newchar= getchar()
    "echom action,oldchar,newchar
"endfunction


"function! Add_new_line()
    "call append(".","")
"endfunction
