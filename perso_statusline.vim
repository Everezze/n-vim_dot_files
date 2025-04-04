"-----------STATUSLINE-----------
"\"n":"NORMAL %#rounded_corners#",
let g:modes_long_names = {
			\"n":"NORMAL ",
			\"no":"OP-PENDING ",
			\"v":"VIS-CHAR ",
			\"V":"VIS-LINE ",
			\"":"VIS-BLOCK ",
			\"i":"INSERT ",
			\"R":"REPLACE ",
			\"c":"CMD-LINE ",
			\"s":"SEL-CHAR",
			\"S":"SEL-LINE",
			\"":"SEL-BLOCK",
			\}

let g:mode_highlights = {
			\"n":"normal_mode",
			\"no":"op_pending_mode",
			\"v":"vis_char_mode",
			\"V":"vis_line_mode",
			\"":"vis_block_mode",
			\"i":"insert_mode",
			\"R":"replace_mode",
			\"c":"command_mode",
			\"s":"sel_char_mode",
			\"S":"sel_line_mode",
			\"":"sel_block_mode",
			\}

"other color: #E6DBAC / #BDA55D / #F34100 / #DAA520
"guifg=#04c8ad

highlight normal_mode guifg=black guibg=#04C8AD
highlight op_pending_mode guifg=white guibg=#FF8243
highlight insert_mode guifg=black guibg=#9381FF
highlight vis_char_mode guifg=black guibg=#F9E076
highlight vis_line_mode guifg=black guibg=#FEBA4F
highlight vis_block_mode guifg=black guibg=#E1AD01
highlight command_mode guifg=white guibg=#6500B0
highlight replace_mode guifg=black guibg=#E32636
highlight sel_char_mode guifg=#0e1c36 guibg=#7EBC89
highlight sel_line_mode guifg=#f7f0f5 guibg=#499167
highlight sel_block_mode guifg=#f7f0f5 guibg=#3d7068
highlight rounded_corners guibg=#29335C
highlight git guifg=black guibg=#EADEDA
highlight git_rounded_corners guifg=#EADEDA guibg=#303030
highlight right_side guifg=black guibg=#EADEDA
highlight right_side_corner guifg=#EADEDA guibg=#303030
"#29335C -> some sort of navy blue
"#D5D5FF -> some sort of navy blue

"combine
"fg =#023436 / #8FC0A9
"fg =#0e1c36 / #dcd6f7
"fg =#0e1c36 / #38405F
"fg =#0e1c36 / #a6b1e1
"fg =#f7f0f5 / #424874

" green shades: #499167 / #3F4531 / #7EBC89 / #3D7068


let g:opending_indicator = 0
function! Get_mode_name()
	"if w:statusactive
	"	let l:statusmode = mode()
	"else
	"	let l:statusmode ="n"
	"endif
	if win_getid(winnr()) != g:active_winid
		let l:statusmode = "n"
	elseif g:opending_indicator
		let g:opending_indicator = 0
		let l:statusmode = "no"
	else
		let l:statusmode = mode()
	endif

	let g:current_hi = g:mode_highlights[l:statusmode]
	return "%#" . g:mode_highlights[l:statusmode] . "# " . g:modes_long_names[l:statusmode]
	"return g:modes_long_names[mode()]
endfunction
"." "

"augroup statusline
"	autocmd!
"	autocmd WinEnter,BufEnter * let w:statusactive = 1
"	autocmd WinLeave,BufLeave * let w:statusactive = 0
"augroup end

augroup statusline
	autocmd!
	autocmd WinEnter,BufEnter * let g:active_winid = win_getid()
augroup end
let g:active_winid = 1000

function! Redrawstatline()
	"echom"opending mode entered"
	"echo g:modes_long_names[mode()]
	let g:opending_indicator = 1
	redrawstatus
endfunction

function! Redrawstatline1()
	"echom"opending mode entered"
	"echo g:modes_long_names[mode()]
	let g:opending_indicator = 0
	redrawstatus
endfunction


augroup check_pending_mode
	autocmd!
	autocmd ModeChanged *:no* call Redrawstatline()
	autocmd ModeChanged no*:n call Redrawstatline1()
augroup end

function! Is_dir_git()
	"echom $HOME . ".;"
	"let g:git_dir = finddir(".git", ".;" . $HOME)
	"if g:git_dir != ""
	"	echom "a repo exist" 
	"else
	"	echom "no repo found"
	"endif
	return " git:gud %#git_rounded_corners#"
endfunction

function! Get_rounded_borders()
	let l:current_highlight = execute('hi ' . g:current_hi)
	let l:current_fg = matchstr(l:current_highlight,'guibg=#\w*')[-7:-1]
	"echo l:current_fg
	execute 'hi' 'rounded_corners' 'guifg=' . l:current_fg . ' guibg=' . '#EADEDA'
	return "%#rounded_corners#"
endfunction

set statusline=%{%Get_mode_name()%}%{%Get_rounded_borders()%}%*
"set statusline+=%f
set statusline+=%#git#%{%Is_dir_git()%}%*
set statusline+=%y
set statusline+=%=
"set statusline+=%=%=
set statusline+=%f
set statusline+=%r
set statusline+=%m
set statusline+=%=
set statusline+=%#right_side_corner#
set statusline+=%#right_side#
set statusline+=buf:%n\ \|\ 
set statusline+=%l\\%L
set statusline+=\(%p\%%)
