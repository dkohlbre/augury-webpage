let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/projects/augury-webpage
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
argglobal
%argdel
$argadd ~/projects/reverie/_config.yml
edit ~/projects/reverie/_pages/faq_text.md
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
wincmd =
argglobal
balt ~/projects/reverie/_pages/about_text.md
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 1 - ((0 * winheight(0) + 32) / 64)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 0
wincmd w
argglobal
if bufexists("page.md") | buffer page.md | else | edit page.md | endif
if &buftype ==# 'terminal'
  silent file page.md
endif
balt ~/projects/reverie/index.md
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 37 - ((30 * winheight(0) + 32) / 64)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 37
normal! 0
wincmd w
wincmd =
tabnext 1
badd +33 ~/projects/reverie/index.md
badd +52 ~/projects/reverie/_config.yml
badd +15 ~/projects/reverie/_layouts/post.html
badd +10 ~/projects/reverie/assets/style.scss
badd +19 ~/projects/reverie/_posts/2019-8-12-code-snippets.md
badd +3 ~/projects/reverie/_posts/2019-7-27-this-post-demonstrates-post-content-styles.md
badd +34 ~/projects/reverie/_layouts/default.html
badd +7 ~/projects/reverie/_layouts/page.html
badd +4 ~/projects/reverie/_pages/about.md
badd +7 ~/projects/reverie/_pages/faq.md
badd +103 ~/projects/reverie/_site/index.html
badd +1 ~/projects/reverie/assets/button.scss
badd +4 ~/projects/reverie/_sass/_button.scss
badd +21 ~/projects/reverie/_pages/cite.md
badd +1 ~/projects/reverie/_pages/about_text.md
badd +1 ~/projects/reverie/_pages/faq_text.md
badd +1 ~/projects/reverie/_pages/tools.md
badd +0 page.md
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 shortmess=filnxtToOFAI
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
let g:this_session = v:this_session
let g:this_obsession = v:this_session
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
