"MAIN CONFIG FILE FOR NVIM

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
set lines =50
set columns =120
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
set listchars=tab:>-,space:·,eol:↴,multispace:···•,
set noundofile
set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching 
set ignorecase              " case insensitive 
set mouse=v                 " middle-click paste with 
"set hlsearch                " highlight search 
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab 
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
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
set timeoutlen=400
set cursorline
set cursorlineopt=both

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
    "Plug 'morhetz/gruvbox'
    "Plug 'EdenEast/nightfox.nvim'
    "Plug 'sonph/onehalf', {'rtp':'vim'}
    "Plug 'kyoz/purify', { 'rtp': 'vim' }
    Plug 'vim-airline/vim-airline'
    "Plug 'vim-airline/vim-airline-themes'
    Plug 'ap/vim-css-color'
    Plug 'srcery-colors/srcery-vim'
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
    Plug 'neovim/nvim-lspconfig'
    "Plug 'williamboman/nvim-lsp-installer'

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
if getcwd() ==? 'C:\Windows\System32' || 'C:\Program Files (x86)\Neovim\bin'
    cd '~/Desktop'
endif


"-----------------------------------MAPPINGS START-----------------------------------

"opening windows easily
let mapleader= " "

"get the column of the mark
nnoremap <leader>' `
"cursor on line above on first non-blank char
nnoremap <C-k> -

"having pairs for common special characters
"inoremap kj <Esc> removed because autohotkey script remaps Caps to Esc
inoremap <A-'> ''<Left>
inoremap <A-[> []<Left>
inoremap <C-'> ""<Left>
inoremap <C-;> {}<Left>
inoremap <C-,> ()<Left>

"--------------------WINDOWS REMAPPINGS--------------------
nnoremap <leader>h <C-W>h
nnoremap <leader>j <C-W>j
nnoremap <leader>k <C-W>k
nnoremap <leader>l <C-W>l
nnoremap <leader>sl <C-W>s
nnoremap <leader>vl <C-W>v
nnoremap <leader>c <C-W>c
"open new window (same as :split or :vsplit and :enew)
nnoremap <silent> <leader>vn :vnew<CR>
nnoremap <silent> <leader>sn :new<CR>
"quit and hard quit! window
nnoremap <leader>q <C-W>q
nnoremap <leader>fq :q!<CR>
"split horiz or vert with a filename
nnoremap <leader>sf :split 
nnoremap <leader>vf :vsplit 

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
"increase window height
nnoremap <leader>fi 5<C-W>+
"decrease window height
nnoremap <leader>fd 5<C-W>-
"increase window width
nnoremap <leader>f, 5<C-W><
"decrease window width
nnoremap <leader>f; 5<C-W>>
"make all windows equal
nnoremap <leader>fe <C-W>=
"make horiz and vert equalizer remaps
"nnoremap <leader>fe <C-W>=
"nnoremap <leader>fe <C-W>=

"SWAPPING WINDOWS PLACE
"exchange window place with next one if last change with previous
"with count exchange with Nth window
nnoremap <leader>fx <C-W>x
"rotate downwards/rightwards row or column of windows the curr win is in
nnoremap <leader>fro <C-W>r
"rotate upwards/leftwards row or column of windows the curr win is in
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
nnoremap <leader>fs <C-W>f

"quit all windows except focused one
nnoremap <leader>fo <C-W>o

"split window and edit alternate file
nnoremap <leader>fa <C-W>^

"--------------------BUFFER REMAPPINGS--------------------
nnoremap <leader>ia :badd 
nnoremap <leader>it :balt 

nnoremap <leader>ii :buf 
nnoremap <leader>ihi :buf! 
nnoremap <leader>is :sbuf 

nnoremap <leader>id :bdel 
nnoremap <leader>idi :bdel<CR>
nnoremap <leader>ihd :bdel! 
nnoremap <leader>ihdi :bdel!<CR>
nnoremap <leader>ird :bdel<Left><Left><Left><Left>
nnoremap <leader>ihrd :bdel!<Left><Left><Left><Left><Left>

nnoremap <leader>iw :bwipe 
nnoremap <leader>iwi :bwipe<CR>
nnoremap <leader>ihw :bwipe! 
nnoremap <leader>ihwi :bwipe!<CR>
nnoremap <leader>irw :bwipe<Left><Left><Left><Left>
nnoremap <leader>ihrw :bwipe!<Left><Left><Left><Left><Left><Left>

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

nnoremap <leader>im :bmod 
nnoremap <leader>imi :bmod<CR>
nnoremap <leader>ihm :bmod!
nnoremap <leader>ihmi :bmod!<CR>
nnoremap <leader>ism :sbmod 
nnoremap <leader>ismi :bmod<CR>
"-----------------------------------MAPPINGS END-----------------------------------

"unsetting/setting relative number for focus and insert mode 
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
  autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
augroup END

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
