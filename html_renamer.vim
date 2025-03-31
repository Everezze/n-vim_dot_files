function! Rename_tag()
	let current_line = getline(".") "return line as string
	let cursor_pos = getcursorcharpos() "return [bufnum,line,col,curswant]
	"col starts at 1
	let char_col = cursor_pos[2] - 1
	let target_char = current_line[char_col]
	if target_char !=? "<" && target_char !=? ">"
		let [result_line,result_col] = searchpos('\(\_[<][^<>]*\)\@<=\%#\_[^<]\{1,}>','Wzc')
		if [result_line,result_col] == [cursor_pos[1],cursor_pos[2]]
			echom "entered condition so match the pair"
			normal %
			let l:end_tag_pos = getcursorcharpos()
			let l:end_tag_pos[2] = l:end_tag_pos[2] + 1
			"let l:second_tag_match = search("\%#\(\w*\)","cez" )
			"let l:end_end = getcursorcharpos()[2]
			normal %
			let l:start_tag_pos = getcursorcharpos()
			echom 'start of end tag: ' . string(l:end_tag_pos)
			echom 'start of start tag: ' . string(l:start_tag_pos)
			let l:first_tag_match = matchadd('sel_line_mode', '<\@<=\(\w*\)\%#\(\w*\)')
			"echo "first col char for both: " . string(l:end_tag_pos[2]) . " ". string(l:start_tag_pos[2])
			call Update_tags(l:start_tag_pos,l:end_tag_pos)
		endif
	else
		let g:can_rename = 0
		echom 'value of can_rename: ' . g:can_rename
	endif
endfunction

function! Update_tags(start_tag_start,end_tag_start)
	let l:new_pos = a:end_tag_start
	normal diw
	call cursor(a:end_tag_start[1:2])
	normal diw 
	call cursor(a:start_tag_start[1:2])

	startinsert
	while 1
		let l:myChar = getcharstr()
		if l:myChar ==? ""
			stopinsert
			call clearmatches()
			break
		endif
		execute "normal! i" . l:myChar
		let l:old_pos = getcursorcharpos()
		let l:old_pos[2] = l:old_pos[2] + 1
		call cursor(l:new_pos[1:2])
		execute "normal! i" . l:myChar
		let l:new_pos = getcursorcharpos()
		let [l:line,l:col] = a:end_tag_start[1:2]
		let l:length = l:new_pos[2] - a:end_tag_start[2] +1
		call matchaddpos('sel_line_mode',[[l:line,l:col,l:length]])
		let l:new_pos[2] = l:new_pos[2] + 1
		call cursor(l:old_pos[1:2])
		redraw
	endwhile
endfunction

augroup add_html_renamer
	autocmd!
	autocmd FileType html,php nnoremap <buffer> gr :call Rename_tag()<CR>
augroup end
