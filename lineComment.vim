"--------------------------------------------------
" Current code line comment
" Author: beiwei
" Email: 3ogx.com@gmail.com
" Version: 1.0
"
" Description:
" Comment line code
"
" Help:
"
" ChangeLog:
" 
" Wed Nov  6 23:40:19 CST 2013
"   init release
"-------------------------------------------------- 

"--------------------------------------------------
" Avoid multiple sourcing
"-------------------------------------------------- 
if exists("loaded_line_comment")
    finish
endif
let loaded_line_comment = 1

"--------------------------------------------------
" Key mapping
"-------------------------------------------------- 
nmap <silent> ;c :call LineComment()<CR>
nmap <silent> \c :call UnLineComment()<CR>

"--------------------------------------------------
" Comment string
"-------------------------------------------------- 
function! MyCommentStr()
    if &ft == "vim"
        let s:comment_start = '" '
        let s:comment_stop  = ''
    elseif &ft == "list"
        let s:comment_start = '; '
        let s:comment_stop  = ''
    elseif &ft == "php" || &ft == "javascript" || &ft == "java"
        let s:comment_start = '// '
        let s:comment_stop  = ''
    elseif &ft == "css" || &ft == "c"
        let s:comment_start = '/* '
        let s:comment_stop  = ' */'
    elseif &ft == "html" || &ft == "xml"
        let s:comment_start = '<!-- '
        let s:comment_stop  = ' -->'
    else
        let s:comment_start = '# '
        let s:comment_stop  = ''
    endif
endfunction

"--------------------------------------------------
" single line comment 
"-------------------------------------------------- 
function! LineComment() range
    let l:firstln = a:firstline
    let l:lastln  = a:lastline
    let l:indent  = indent(l:firstln) / &tabstop
    let l:line    = getline(l:firstln)
    echo l:indent

    let l:i = 0
    let l:pad = ""
    while l:i < l:indent
        let l:pad = l:pad . '\t'
        let l:i = l:i + 1
    endwhile

    call MyCommentStr()
    let l:cutline = strpart(l:line, indent(l:lastln))
    let l:cutindent = strpart(l:line, 0, indent(l:lastln))
    call setline(l:lastln, l:cutindent.s:comment_start.l:cutline.s:comment_stop) 
endfunction

"--------------------------------------------------
" Uncomment line code
"-------------------------------------------------- 
function! UnLineComment() range
    let l:firstln = a:firstline
    let l:lastln  = a:lastline
    let l:indent  = indent(l:firstln) / &tabstop
    let l:line    = getline(l:firstln)
    
    call MyCommentStr()
    
    let l:tmp = strpart(l:line, indent(l:firstln), strlen(s:comment_start))
    echo strlen(l:tmp)

    if strpart(l:line, indent(l:firstln), strlen(s:comment_start)) == s:comment_start 
        let l:cutline = strpart(l:line, indent(l:firstln) + strlen(s:comment_start))
        let l:cutindent = strpart(l:line, 0, indent(l:firstln))

        call setline(l:firstln, l:cutindent.l:cutline)
    endif
endfunction
