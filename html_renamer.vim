let g:can_rename = 0
let g:rename_highlight = "rename_highlight"
"highlight link CursorColumn highlight_tag
"let g:textProp_props = { 
"			\"type": 'highlight_tag'
"			\}
"call prop_type_add(g:rename_highlight, props)

function! Rename_tag()
	"echom 'mode when using remap is: ' . mode()
	"if match(&cpo, 'c')
	"	echo 'cpo has c'
	"	set cpo-=c
	"endif
	"execute '^C'
	"norm ^C%
	let current_line = getline(".") "return line as string
	let cursor_pos = getcursorcharpos() "return [bufnum,line,col,curswant]
	"col starts at 1
	let char_col = cursor_pos[2] - 1
	let target_char = current_line[char_col]
	"echom "char on cursor is: " . target_char
	if target_char !=? "<" && target_char !=? ">"
		"if searchpos("<[^<>]\%#",Wb) && searchpos("[^<]\{-}>",Wz)
		"endif
		"echo 'not a < or > char so safe'
		let [result_line,result_col] = searchpos('\(\_[<][^<>]*\)\@<=\%#\_[^<]\{1,}>','Wzc')
		"echom 'searchpos result is ' . string([result_line,result_col])
		if [result_line,result_col] == [cursor_pos[1],cursor_pos[2]]
			echom "entered condition so match the pair"
			"call listener_add(Rename_cb)
			"call feedkeys("\<esc>%")
			"call feedkeys("%")
			"call feedkeys("%")
			normal %
			let g:end_tag_pos = getcursorcharpos()
			let g:end_tag_pos[2] = g:end_tag_pos[2] + 1
			"let g:initial_end = g:end_tag_pos[2]
			let g:second_tag_match = search("\%#\(\w*\)","cez" )
			let g:end_end = getcursorcharpos()[2]
			normal %
			let g:start_tag_pos = getcursorcharpos()
			"call cursor(cursor_pos[1:]) "putting cursor in its original place
			"echom 'old cursor: ' . string(cursor_pos)
			echom 'start of end tag: ' . string(g:end_tag_pos)
			echom 'start of start tag: ' . string(g:start_tag_pos)
			"startinsert
			"call feedkeys("ciw")
			"while 1
			"	let char =getcharstr() 
			"	if char ==? "^["
			"		break
			"	endif
			"	echo char
			"endwhile
			let g:first_tag_match = matchadd('sel_line_mode', '<\@<=\(\w*\)\%#\(\w*\)')
			"let g:can_rename = 1
			"echom 'value of can_rename: ' . g:can_rename
			call Update_tags()
		endif
	else
		let g:can_rename = 0
		echom 'value of can_rename: ' . g:can_rename
	endif
	"regex matching that cursor is inside tag
	"=> searchpos("\(\_[<][^<>]*\)@<=\_[^<]\{-}>")

	"call feedkeys("\<esc>%")
	"let cursor_pos[2] = cursor_pos[2] + 1
	"echom cursor_pos
	"return ""
	"use cursor() function to replace the cursor
	"
	"
	"this command below is to be typed after catching the new tag
	"norm ciw^R=my_vary^@(my_vary is the name of the variable)
endfunction

function! Update_tags()
	"echom 'from update tags func'
	"call prop_add()
	"let g:last_char = v:char 
	"let g:old_pos = getcursorcharpos()
	"call cursor(line(".")+1, 0)
	"normal! a^R=@.^@
	"call feedkeys("text")
	"call cursor(g:old_pos[1:2])
	let g:new_pos = g:end_tag_pos
	normal diw
	call cursor(g:end_tag_pos[1:2])
	normal diw 
	call cursor(g:start_tag_pos[1:2])

	startinsert
	"set eventignore=InsertCharPre
	while 1
		let l:myChar = getcharstr()
		if l:myChar ==? ""
			stopinsert
			call clearmatches()
			break
		endif
		execute "normal! i" . l:myChar
		let g:old_pos = getcursorcharpos()
		let g:old_pos[2] = g:old_pos[2] + 1
		"echo g:old_pos
		call cursor(g:new_pos[1:2])
		execute "normal! i" . l:myChar
		let g:new_pos = getcursorcharpos()
		let l:line = g:end_tag_pos[1]
		let l:col = g:end_tag_pos[2]
		let l:length = g:new_pos[2] - g:end_tag_pos[2] +1
		echo [line,col,length]
		let g:end_tag_hi = matchaddpos('sel_line_mode',[[l:line,l:col,l:length]])
		let g:new_pos[2] = g:new_pos[2] + 1
		"echom g:new_pos
		"execute 'normal! a' . @.
		"echo 'old: '. string(g:old_pos) . ' and new: '. string(g:new_pos)
		call cursor(g:old_pos[1:2])
		redraw
	endwhile
	"set eventignore=""
	"call feedkeys(v:char)
endfunction

function! Rename_callback()
	
endfunction
"
"augroup highlight_new_tag
"	autocmd!
"	autocmd
"augroup end
"

"augroup get_char
"	autocmd!
"	autocmd InsertCharPre * call Update_tags()
"augroup END

"augroup paste_text
"	autocmd!
"	autocmd TextChangedI * call listener_add("Update_tags")"
"augroup END

augroup add_html_renamer
	autocmd!
	autocmd FileType html,php nnoremap <buffer> gr :call Rename_tag()<CR>
augroup end
"nnoremap gr :call Rename_tag()<CR>
