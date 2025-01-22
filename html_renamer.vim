function Rename_tag()
	echom "mode when using remap is: " . mode()
	"if match(&cpo, "c")
	"	echo "cpo has c"
	"	set cpo-=c
	"endif
	"execute ""
	"norm %
	let current_line = getline(".") "return line as string
	let cursor_pos = getcurpos() "return [buf,line,col,curswant]
	"col starts at 1
	let char_col = cursor_pos[2] - 1
	let target_char = current_line[char_col]
	"echom "char on cursor is: " . target_char
	if target_char !=? "<" && target_char !=? ">"
		"if searchpos("<[^<>]\%#",Wb) && searchpos("[^<]\{-}>",Wz)
		"endif
		echo "not a < or > char so safe"
		let [result_line,result_col] = searchpos('\(\_[<][^<>]*\)\@<=\_[^<]\{-}>','Wzc')
		echom "searchpos result is " . string([result_line,result_col])
		if [result_line,result_col] == [cursor_pos[1],cursor_pos[2]]
			echom "entered condition so match the pair"
			call feedkeys("\<esc>%")
		endif
	endif
	"regex matching that cursor is inside tag
	"=> searchpos("\(\_[<][^<>]*\)@<=\_[^<]\{-}>")

	"call feedkeys("\<esc>%")
	"let cursor_pos[2] = cursor_pos[2] + 1
	"echom cursor_pos
	"return ""
	"use cursor() function to replace the cursor
endfunction



