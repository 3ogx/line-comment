"--------------------------------------------------
" 對齊賦值運算符
" 
" Instals:
"
" Copy AlignAssignments.vim into .vim/plugins/
" 
" ChangeLog
"
" Sat Nov  9 10:26:11 CST 2013
" Init release
" 
" See:
" http://www.ibm.com/developerworks/cn/linux/l-vim-script-2/
"-------------------------------------------------- 

function! AlignAssignments()
    let s:assign_op   = '[-+*/%|&]\?=\@<!=[=~]\@!'
    let s:assign_line = '^\(.\{-}\)\s*\('.s:assign_op.'\)'

    let s:indent_pat = '^' . matchstr(getline('.'), '^\s*'). '\S'
    let s:firstline = search('^\%('. s:indent_pat . '\)\@!', 'bnW') + 1
    let s:lastline = search('^\%('. s:indent_pat . '\)\@!', 'nW') - 1
    if s:lastline < 0
        let s:lastline = line('$')
    endif

    let s:max_align_col = 0
    let s:max_op_width = 0
    for s:linetxt in getline(s:firstline, s:lastline)
        let s:leftwidth = match(s:linetxt, '\s*' . s:assign_op)

        if s:leftwidth >= 0
            let s:max_align_col = max([s:max_op_width, s:leftwidth])
            let s:op_width     = strlen(matchstr(s:linetxt, s:assign_op))
            let s:max_op_width = max([s:max_op_width, s:op_width + 1])
        endif
    endfor

    let l:formater = '\=printf("%-*s%*s", s:max_align_col, submatch(1), s:max_op_width, submatch(2))'

    for s:linenum in range(s:firstline, s:lastline)
        let s:oldline = getline(s:linenum)
        let s:newline = substitute(s:oldline, s:assign_line, l:formater, "")
        call setline(s:linenum, s:newline)
    endfor
endfunction


