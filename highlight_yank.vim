"-----------HIGHLIGHT YANKED TEXT-----------
highlight mycustomhighlight ctermfg=black ctermbg=white guifg=black guibg=#04C8AD
augroup yanked_text_highlight
	autocmd!
	autocmd TextYankPost * call Addhighlight()
augroup end

function! Removehighlight(timerID)
	while !empty(g:text_matches)
		let match = remove(g:text_matches,0)
		let g:deletion_result = matchdelete(match[0],match[1])
	endwhile
endfunction

function! Addhighlight()
	if !exists('g:text_matches')
		let g:text_matches = []
	endif
	let matchId = matchadd("mycustomhighlight", ".\\%>'\\[\\_.*\\%<']..")
	let winId = winnr()
	call add(g:text_matches, [matchId,winId])
	call timer_start(300,'Removehighlight')
	"let g:mycustommatch = matchadd("mycustomhighlight", '.\\%>'\\[\\_.*\\%<']..")
endfunction
