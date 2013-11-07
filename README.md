line-comment
============
### Description

An vim plugin, comment single line code

一個單行注釋代碼的小插件.

目前只支持以下幾種語言 

`vim script` `php` `python` `css` `c` `html` `xml`

### Install

* 拷貝 `line-comment.vim` 到~/.vim/plugin/, 重啟vim即可.
* 或在clone 當前版本庫, 編輯.vimrc 文件裏. `source clone-dir/line-comment.vim`

### How to use

已綁定快捷鍵

`;c` 注釋單前行

`\c` 取消注釋

如果跟現有的快捷鍵衝突,可自行綁定,只要在vim中執行:

`:nmap <silent> key :call LineComment()<CR>`

`:nmap <silent> key :call UnLineComment()<CR>`

### Change Log

* 2013-11-07 init release