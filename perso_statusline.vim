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
			\}

let g:mode_highlights = {
			\"n":"normal_mode",
			\"OP-PENDING":"op_pending_mode",
			\"v":"vis_char_mode",
			\"V":"vis_line_mode",
			\"":"vis_block_mode",
			\"i":"insert_mode",
			\"R":"replace_mode",
			\"c":"command_mode",
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
highlight rounded_corners guibg=#29335C
highlight git guifg=black guibg=#EADEDA
highlight git_rounded_corners guifg=#EADEDA guibg=#303030
highlight right_side guifg=black guibg=#EADEDA
highlight right_side_corner guifg=#EADEDA guibg=#303030
"#29335C -> some sort of navy blue
"#D5D5FF -> some sort of navy blue


let g:opending_indicator = 1
function! Get_mode_name()
	if g:opending_indicator
		let g:opending_indicator = 0
		let g:current_hi = g:mode_highlights["OP-PENDING"]
		return "%#" . g:mode_highlights["OP-PENDING"] . "# " . "OP-PENDING "
	else
		let g:current_hi = g:mode_highlights[mode()]
		return "%#" . g:mode_highlights[mode()] . "# " . g:modes_long_names[mode()]
	endif
	"return g:modes_long_names[mode()]
endfunction
"." "

function! Redrawstatline()
	"echom"opending mode entered"
	"echo g:modes_long_names[mode()]
	let g:opending_indicator = 1
	redrawstatus
endfunction

augroup check_pending_mode
	autocmd!
	autocmd ModeChanged *:no* call Redrawstatline()
augroup end

augroup get_git
	autocmd!
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

function! Determine_bg()
	return "%#status_line#"
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

function! Tst_string()
	if("C:\\users\\random\\Desktop\\fem_projects\\todo_app")
		echo "string not evaluated to 0"
	else
		echo "finddir returned string evalutes to 0"
	endif
endfunction
