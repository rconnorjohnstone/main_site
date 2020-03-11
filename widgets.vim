let SessionLoad = 1
let s:so_save = &so | let s:siso_save = &siso | set so=0 siso=0
let v:this_session=expand("<sfile>:p")
silent only
cd ~/Projects/hackend
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
set shortmess=aoO
badd +5 app/main.hs
badd +49 src/Application.hs
badd +13 src/Settings.hs
badd +95 ~/.config/nvim/init.vim
badd +13 config/settings.yml
badd +14 config/routes
badd +1 handler
badd +43 src/Handler/Home.hs
badd +4 templates/homepage.hamlet
badd +1 templates/homepage.lucius
badd +1 templates/homepage.julius
badd +1 ~/Projects/react_site/src/App.js
badd +171 src/Foundation.hs
badd +7 src/Handler/NewHome.hs
badd +1 src/Handler/Profile.hs
badd +1 src/Handler/Comment.hs
badd +17 src/Handler/Common.hs
badd +4 templates/site-layout-wrapper.hamlet
badd +1 templates/site-layout-wrapper.lucius
badd +1 ~/Projects/react_site/src/App.css
badd +1 templates/home.lucius
badd +1 templates/banner/banner.hamlet
badd +1 templates/banner/banner.lucius
badd +1 templates/preview_card/preview_card.hamlet
badd +6 src/Handler/PreviewCard.hs
badd +1 templates/preview_card/preview_card.cassius
badd +24 .gitignore
badd +1 templates/projects/projects.hamlet
badd +1 templates/projects/projects.cassius
badd +1 templates/contact/contact.hamlet
badd +1 templates/contact/contact.cassius
badd +46 package.yaml
badd +50 stack.yaml
badd +1 templates/footer/footer.hamlet
badd +1 templates/footer/footer.cassius
badd +1 src/Handler/About.hs
badd +1 templates/navbar/navbar.hamlet
badd +1 templates/navbar/navbar.cassius
badd +4 config/keter.yml
badd +15 templates/about/about.hamlet
badd +5 templates/about/about.cassius
badd +1 templates/christmas/christmas.cassius
badd +73 templates/site-layout.lucius
badd +18 src/Handler/Resources.hs
badd +1 templates/resources/resources.hamlet
badd +4 Layouts/HomeLayout.hs
badd +1 src/Layouts/HomeLayout.hs
badd +2 templates/posts/view.hamlet
badd +0 templates/posts/view.cassius
badd +0 templates/posts/all.hamlet
badd +0 templates/posts/view_draft.hamlet
badd +0 templates/posts/view_draft.cassius
badd +0 templates/posts/all_drafts.hamlet
badd +4 templates/posts/new.hamlet
badd +0 templates/posts/new.cassius
argglobal
silent! argdel *
$argadd app/main.hs
set stal=2
edit templates/navbar/navbar.hamlet
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 88 + 89) / 178)
exe 'vert 2resize ' . ((&columns * 89 + 89) / 178)
argglobal
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal fen
let s:l = 16 - ((10 * winheight(0) + 23) / 46)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
16
normal! 0
lcd ~/Projects/hackend
wincmd w
argglobal
if bufexists('~/Projects/hackend/templates/navbar/navbar.cassius') | buffer ~/Projects/hackend/templates/navbar/navbar.cassius | else | edit ~/Projects/hackend/templates/navbar/navbar.cassius | endif
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal nofen
let s:l = 1 - ((0 * winheight(0) + 23) / 46)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
lcd ~/Projects/hackend
wincmd w
exe 'vert 1resize ' . ((&columns * 88 + 89) / 178)
exe 'vert 2resize ' . ((&columns * 89 + 89) / 178)
tabedit ~/Projects/hackend/templates/banner/banner.hamlet
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 88 + 89) / 178)
exe 'vert 2resize ' . ((&columns * 89 + 89) / 178)
argglobal
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal nofen
let s:l = 1 - ((0 * winheight(0) + 23) / 46)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
lcd ~/Projects/hackend
wincmd w
argglobal
if bufexists('~/Projects/hackend/templates/banner/banner.lucius') | buffer ~/Projects/hackend/templates/banner/banner.lucius | else | edit ~/Projects/hackend/templates/banner/banner.lucius | endif
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal nofen
let s:l = 1 - ((0 * winheight(0) + 23) / 46)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
lcd ~/Projects/hackend
wincmd w
exe 'vert 1resize ' . ((&columns * 88 + 89) / 178)
exe 'vert 2resize ' . ((&columns * 89 + 89) / 178)
tabedit ~/Projects/hackend/templates/preview_card/preview_card.hamlet
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 88 + 89) / 178)
exe 'vert 2resize ' . ((&columns * 89 + 89) / 178)
argglobal
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal nofen
let s:l = 2 - ((1 * winheight(0) + 23) / 46)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
2
normal! 0
lcd ~/Projects/hackend
wincmd w
argglobal
if bufexists('~/Projects/hackend/templates/preview_card/preview_card.cassius') | buffer ~/Projects/hackend/templates/preview_card/preview_card.cassius | else | edit ~/Projects/hackend/templates/preview_card/preview_card.cassius | endif
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal nofen
let s:l = 14 - ((0 * winheight(0) + 23) / 46)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
14
normal! 0
lcd ~/Projects/hackend
wincmd w
exe 'vert 1resize ' . ((&columns * 88 + 89) / 178)
exe 'vert 2resize ' . ((&columns * 89 + 89) / 178)
tabedit ~/Projects/hackend/templates/projects/projects.hamlet
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 88 + 89) / 178)
exe 'vert 2resize ' . ((&columns * 89 + 89) / 178)
argglobal
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal nofen
let s:l = 15 - ((9 * winheight(0) + 23) / 46)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
15
normal! 026|
lcd ~/Projects/hackend
wincmd w
argglobal
if bufexists('~/Projects/hackend/templates/projects/projects.cassius') | buffer ~/Projects/hackend/templates/projects/projects.cassius | else | edit ~/Projects/hackend/templates/projects/projects.cassius | endif
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal nofen
let s:l = 36 - ((0 * winheight(0) + 23) / 46)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
36
normal! 011|
lcd ~/Projects/hackend
wincmd w
exe 'vert 1resize ' . ((&columns * 88 + 89) / 178)
exe 'vert 2resize ' . ((&columns * 89 + 89) / 178)
tabedit ~/Projects/hackend/templates/posts/view.hamlet
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 88 + 89) / 178)
exe 'vert 2resize ' . ((&columns * 89 + 89) / 178)
argglobal
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal nofen
let s:l = 1 - ((0 * winheight(0) + 23) / 46)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
lcd ~/Projects/hackend
wincmd w
argglobal
if bufexists('~/Projects/hackend/templates/posts/view.cassius') | buffer ~/Projects/hackend/templates/posts/view.cassius | else | edit ~/Projects/hackend/templates/posts/view.cassius | endif
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal nofen
let s:l = 1 - ((0 * winheight(0) + 23) / 46)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
lcd ~/Projects/hackend
wincmd w
exe 'vert 1resize ' . ((&columns * 88 + 89) / 178)
exe 'vert 2resize ' . ((&columns * 89 + 89) / 178)
tabedit ~/Projects/hackend/templates/posts/new.hamlet
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 88 + 89) / 178)
exe 'vert 2resize ' . ((&columns * 89 + 89) / 178)
argglobal
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal nofen
let s:l = 4 - ((3 * winheight(0) + 23) / 46)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
4
normal! 0
lcd ~/Projects/hackend
wincmd w
argglobal
if bufexists('~/Projects/hackend/templates/posts/new.cassius') | buffer ~/Projects/hackend/templates/posts/new.cassius | else | edit ~/Projects/hackend/templates/posts/new.cassius | endif
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal nofen
let s:l = 1 - ((0 * winheight(0) + 23) / 46)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
lcd ~/Projects/hackend
wincmd w
exe 'vert 1resize ' . ((&columns * 88 + 89) / 178)
exe 'vert 2resize ' . ((&columns * 89 + 89) / 178)
tabedit ~/Projects/hackend/templates/posts/view_draft.hamlet
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 88 + 89) / 178)
exe 'vert 2resize ' . ((&columns * 89 + 89) / 178)
argglobal
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal nofen
let s:l = 8 - ((7 * winheight(0) + 23) / 46)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
8
normal! 0
lcd ~/Projects/hackend
wincmd w
argglobal
if bufexists('~/Projects/hackend/templates/posts/view_draft.cassius') | buffer ~/Projects/hackend/templates/posts/view_draft.cassius | else | edit ~/Projects/hackend/templates/posts/view_draft.cassius | endif
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal nofen
let s:l = 23 - ((10 * winheight(0) + 23) / 46)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
23
normal! 014|
lcd ~/Projects/hackend
wincmd w
2wincmd w
exe 'vert 1resize ' . ((&columns * 88 + 89) / 178)
exe 'vert 2resize ' . ((&columns * 89 + 89) / 178)
tabedit ~/Projects/hackend/templates/posts/all_drafts.hamlet
set splitbelow splitright
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
argglobal
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal nofen
let s:l = 8 - ((7 * winheight(0) + 23) / 46)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
8
normal! 046|
lcd ~/Projects/hackend
tabedit ~/Projects/hackend/templates/posts/all.hamlet
set splitbelow splitright
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
argglobal
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal nofen
let s:l = 1 - ((0 * winheight(0) + 23) / 46)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
lcd ~/Projects/hackend
tabedit ~/Projects/hackend/templates/contact/contact.hamlet
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 88 + 89) / 178)
exe 'vert 2resize ' . ((&columns * 89 + 89) / 178)
argglobal
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal nofen
let s:l = 7 - ((4 * winheight(0) + 23) / 46)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
7
normal! 027|
lcd ~/Projects/hackend
wincmd w
argglobal
if bufexists('~/Projects/hackend/templates/contact/contact.cassius') | buffer ~/Projects/hackend/templates/contact/contact.cassius | else | edit ~/Projects/hackend/templates/contact/contact.cassius | endif
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal nofen
let s:l = 62 - ((0 * winheight(0) + 23) / 46)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
62
normal! 05|
lcd ~/Projects/hackend
wincmd w
exe 'vert 1resize ' . ((&columns * 88 + 89) / 178)
exe 'vert 2resize ' . ((&columns * 89 + 89) / 178)
tabedit ~/Projects/hackend/templates/footer/footer.hamlet
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 88 + 89) / 178)
exe 'vert 2resize ' . ((&columns * 89 + 89) / 178)
argglobal
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal nofen
let s:l = 1 - ((0 * winheight(0) + 23) / 46)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 08|
lcd ~/Projects/hackend
wincmd w
argglobal
if bufexists('~/Projects/hackend/templates/footer/footer.cassius') | buffer ~/Projects/hackend/templates/footer/footer.cassius | else | edit ~/Projects/hackend/templates/footer/footer.cassius | endif
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal nofen
let s:l = 8 - ((0 * winheight(0) + 23) / 46)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
8
normal! 02|
lcd ~/Projects/hackend
wincmd w
exe 'vert 1resize ' . ((&columns * 88 + 89) / 178)
exe 'vert 2resize ' . ((&columns * 89 + 89) / 178)
tabnext 7
set stal=1
if exists('s:wipebuf') && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20 winminheight=1 winminwidth=1 shortmess=filnxtToOF
let s:sx = expand("<sfile>:p:r")."x.vim"
if file_readable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &so = s:so_save | let &siso = s:siso_save
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
