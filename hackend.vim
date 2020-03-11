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
badd +110 src/Application.hs
badd +1 src/Settings.hs
badd +95 ~/.config/nvim/init.vim
badd +13 config/settings.yml
badd +1 config/routes
badd +1 handler
badd +1 src/Handler/Home.hs
badd +4 templates/homepage.hamlet
badd +1 templates/homepage.lucius
badd +1 templates/homepage.julius
badd +1 ~/Projects/react_site/src/App.js
badd +1 src/Foundation.hs
badd +7 src/Handler/NewHome.hs
badd +1 src/Handler/Profile.hs
badd +1 src/Handler/Comment.hs
badd +17 src/Handler/Common.hs
badd +1 templates/site-layout-wrapper.hamlet
badd +3 templates/site-layout-wrapper.lucius
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
badd +1 stack.yaml
badd +1 templates/footer/footer.hamlet
badd +1 templates/footer/footer.cassius
badd +27 src/Handler/About.hs
badd +1 templates/navbar/navbar.hamlet
badd +1 templates/navbar/navbar.cassius
badd +94 config/keter.yml
badd +0 templates/about/about.hamlet
badd +1 templates/about/about.cassius
badd +1 templates/christmas/christmas.cassius
badd +73 templates/site-layout.lucius
badd +1 src/Handler/Resources.hs
badd +0 templates/resources/resources.hamlet
badd +4 Layouts/HomeLayout.hs
badd +0 src/Layouts/HomeLayout.hs
argglobal
%argdel
$argadd app/main.hs
set stal=2
edit src/Foundation.hs
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd w
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 116 + 116) / 233)
exe '2resize ' . ((&lines * 25 + 26) / 53)
exe 'vert 2resize ' . ((&columns * 116 + 116) / 233)
exe '3resize ' . ((&lines * 24 + 26) / 53)
exe 'vert 3resize ' . ((&columns * 116 + 116) / 233)
argglobal
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal nofen
let s:l = 171 - ((26 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
171
normal! 026|
wincmd w
argglobal
if bufexists("src/Application.hs") | buffer src/Application.hs | else | edit src/Application.hs | endif
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal nofen
let s:l = 49 - ((19 * winheight(0) + 12) / 25)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
49
normal! 024|
lcd ~/Projects/hackend
wincmd w
argglobal
if bufexists("~/Projects/hackend/src/Settings.hs") | buffer ~/Projects/hackend/src/Settings.hs | else | edit ~/Projects/hackend/src/Settings.hs | endif
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal nofen
let s:l = 12 - ((8 * winheight(0) + 12) / 24)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
12
normal! 0
lcd ~/Projects/hackend
wincmd w
exe 'vert 1resize ' . ((&columns * 116 + 116) / 233)
exe '2resize ' . ((&lines * 25 + 26) / 53)
exe 'vert 2resize ' . ((&columns * 116 + 116) / 233)
exe '3resize ' . ((&lines * 24 + 26) / 53)
exe 'vert 3resize ' . ((&columns * 116 + 116) / 233)
tabedit ~/Projects/hackend/src/Layouts/HomeLayout.hs
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
let s:l = 1 - ((0 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
tabedit ~/Projects/hackend/templates/site-layout-wrapper.hamlet
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
exe 'vert 1resize ' . ((&columns * 119 + 116) / 233)
exe 'vert 2resize ' . ((&columns * 113 + 116) / 233)
argglobal
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal nofen
let s:l = 4 - ((3 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
4
normal! 05|
wincmd w
argglobal
if bufexists("~/Projects/hackend/templates/site-layout-wrapper.lucius") | buffer ~/Projects/hackend/templates/site-layout-wrapper.lucius | else | edit ~/Projects/hackend/templates/site-layout-wrapper.lucius | endif
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal nofen
let s:l = 1 - ((0 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
wincmd w
exe 'vert 1resize ' . ((&columns * 119 + 116) / 233)
exe 'vert 2resize ' . ((&columns * 113 + 116) / 233)
tabedit ~/Projects/hackend/stack.yaml
set splitbelow splitright
wincmd _ | wincmd |
vsplit
wincmd _ | wincmd |
vsplit
2wincmd h
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd w
wincmd w
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe '1resize ' . ((&lines * 24 + 26) / 53)
exe 'vert 1resize ' . ((&columns * 77 + 116) / 233)
exe '2resize ' . ((&lines * 25 + 26) / 53)
exe 'vert 2resize ' . ((&columns * 77 + 116) / 233)
exe 'vert 3resize ' . ((&columns * 77 + 116) / 233)
exe 'vert 4resize ' . ((&columns * 77 + 116) / 233)
argglobal
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal nofen
let s:l = 50 - ((13 * winheight(0) + 12) / 24)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
50
normal! 03|
lcd ~/Projects/hackend
wincmd w
argglobal
if bufexists("~/Projects/hackend/config/keter.yml") | buffer ~/Projects/hackend/config/keter.yml | else | edit ~/Projects/hackend/config/keter.yml | endif
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal nofen
let s:l = 4 - ((3 * winheight(0) + 12) / 25)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
4
normal! 074|
lcd ~/Projects/hackend
wincmd w
argglobal
if bufexists("~/Projects/hackend/package.yaml") | buffer ~/Projects/hackend/package.yaml | else | edit ~/Projects/hackend/package.yaml | endif
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal nofen
let s:l = 46 - ((5 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
46
normal! 017|
lcd ~/Projects/hackend
wincmd w
argglobal
if bufexists("~/Projects/hackend/config/routes") | buffer ~/Projects/hackend/config/routes | else | edit ~/Projects/hackend/config/routes | endif
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal nofen
let s:l = 14 - ((13 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
14
normal! 025|
lcd ~/Projects/hackend
wincmd w
exe '1resize ' . ((&lines * 24 + 26) / 53)
exe 'vert 1resize ' . ((&columns * 77 + 116) / 233)
exe '2resize ' . ((&lines * 25 + 26) / 53)
exe 'vert 2resize ' . ((&columns * 77 + 116) / 233)
exe 'vert 3resize ' . ((&columns * 77 + 116) / 233)
exe 'vert 4resize ' . ((&columns * 77 + 116) / 233)
tabedit ~/Projects/hackend/src/Handler/Home.hs
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
exe 'vert 1resize ' . ((&columns * 119 + 116) / 233)
exe 'vert 2resize ' . ((&columns * 113 + 116) / 233)
argglobal
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal nofen
let s:l = 43 - ((39 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
43
normal! 0191|
lcd ~/Projects/hackend
wincmd w
argglobal
if bufexists("~/Projects/hackend/templates/home.lucius") | buffer ~/Projects/hackend/templates/home.lucius | else | edit ~/Projects/hackend/templates/home.lucius | endif
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal nofen
let s:l = 1 - ((0 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 03|
lcd ~/Projects/hackend
wincmd w
exe 'vert 1resize ' . ((&columns * 119 + 116) / 233)
exe 'vert 2resize ' . ((&columns * 113 + 116) / 233)
tabedit ~/Projects/hackend/src/Handler/About.hs
set splitbelow splitright
wincmd _ | wincmd |
vsplit
wincmd _ | wincmd |
vsplit
2wincmd h
wincmd w
wincmd w
wincmd t
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe 'vert 1resize ' . ((&columns * 77 + 116) / 233)
exe 'vert 2resize ' . ((&columns * 77 + 116) / 233)
exe 'vert 3resize ' . ((&columns * 77 + 116) / 233)
argglobal
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal nofen
let s:l = 1 - ((0 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
lcd ~/Projects/hackend
wincmd w
argglobal
if bufexists("~/Projects/hackend/templates/about/about.hamlet") | buffer ~/Projects/hackend/templates/about/about.hamlet | else | edit ~/Projects/hackend/templates/about/about.hamlet | endif
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal nofen
let s:l = 15 - ((8 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
15
normal! 0901|
lcd ~/Projects/hackend
wincmd w
argglobal
if bufexists("~/Projects/hackend/templates/about/about.cassius") | buffer ~/Projects/hackend/templates/about/about.cassius | else | edit ~/Projects/hackend/templates/about/about.cassius | endif
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal nofen
let s:l = 5 - ((4 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
5
normal! 0
lcd ~/Projects/hackend
wincmd w
exe 'vert 1resize ' . ((&columns * 77 + 116) / 233)
exe 'vert 2resize ' . ((&columns * 77 + 116) / 233)
exe 'vert 3resize ' . ((&columns * 77 + 116) / 233)
tabedit ~/Projects/hackend/src/Handler/Resources.hs
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
exe 'vert 1resize ' . ((&columns * 116 + 116) / 233)
exe 'vert 2resize ' . ((&columns * 116 + 116) / 233)
argglobal
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal nofen
let s:l = 18 - ((17 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
18
normal! 037|
lcd ~/Projects/hackend
wincmd w
argglobal
if bufexists("~/Projects/hackend/templates/resources/resources.hamlet") | buffer ~/Projects/hackend/templates/resources/resources.hamlet | else | edit ~/Projects/hackend/templates/resources/resources.hamlet | endif
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal nofen
let s:l = 1 - ((0 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 024|
lcd ~/Projects/hackend
wincmd w
2wincmd w
exe 'vert 1resize ' . ((&columns * 116 + 116) / 233)
exe 'vert 2resize ' . ((&columns * 116 + 116) / 233)
tabedit ~/Projects/hackend/templates/navbar/navbar.hamlet
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
exe 'vert 1resize ' . ((&columns * 119 + 116) / 233)
exe 'vert 2resize ' . ((&columns * 113 + 116) / 233)
argglobal
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal fen
let s:l = 16 - ((11 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
16
normal! 0
lcd ~/Projects/hackend
wincmd w
argglobal
if bufexists("~/Projects/hackend/templates/navbar/navbar.cassius") | buffer ~/Projects/hackend/templates/navbar/navbar.cassius | else | edit ~/Projects/hackend/templates/navbar/navbar.cassius | endif
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal nofen
let s:l = 1 - ((0 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
lcd ~/Projects/hackend
wincmd w
exe 'vert 1resize ' . ((&columns * 119 + 116) / 233)
exe 'vert 2resize ' . ((&columns * 113 + 116) / 233)
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
exe 'vert 1resize ' . ((&columns * 119 + 116) / 233)
exe 'vert 2resize ' . ((&columns * 113 + 116) / 233)
argglobal
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal nofen
let s:l = 1 - ((0 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
lcd ~/Projects/hackend
wincmd w
argglobal
if bufexists("~/Projects/hackend/templates/banner/banner.lucius") | buffer ~/Projects/hackend/templates/banner/banner.lucius | else | edit ~/Projects/hackend/templates/banner/banner.lucius | endif
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal nofen
let s:l = 1 - ((0 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
1
normal! 0
lcd ~/Projects/hackend
wincmd w
exe 'vert 1resize ' . ((&columns * 119 + 116) / 233)
exe 'vert 2resize ' . ((&columns * 113 + 116) / 233)
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
exe 'vert 1resize ' . ((&columns * 119 + 116) / 233)
exe 'vert 2resize ' . ((&columns * 113 + 116) / 233)
argglobal
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal nofen
let s:l = 2 - ((1 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
2
normal! 0
lcd ~/Projects/hackend
wincmd w
argglobal
if bufexists("~/Projects/hackend/templates/preview_card/preview_card.cassius") | buffer ~/Projects/hackend/templates/preview_card/preview_card.cassius | else | edit ~/Projects/hackend/templates/preview_card/preview_card.cassius | endif
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal nofen
let s:l = 14 - ((0 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
14
normal! 0
lcd ~/Projects/hackend
wincmd w
exe 'vert 1resize ' . ((&columns * 119 + 116) / 233)
exe 'vert 2resize ' . ((&columns * 113 + 116) / 233)
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
exe 'vert 1resize ' . ((&columns * 119 + 116) / 233)
exe 'vert 2resize ' . ((&columns * 119 + 116) / 233)
argglobal
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal nofen
let s:l = 15 - ((13 * winheight(0) + 33) / 66)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
15
normal! 026|
lcd ~/Projects/hackend
wincmd w
argglobal
if bufexists("~/Projects/hackend/templates/projects/projects.cassius") | buffer ~/Projects/hackend/templates/projects/projects.cassius | else | edit ~/Projects/hackend/templates/projects/projects.cassius | endif
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal nofen
let s:l = 36 - ((35 * winheight(0) + 33) / 66)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
36
normal! 011|
lcd ~/Projects/hackend
wincmd w
exe 'vert 1resize ' . ((&columns * 119 + 116) / 233)
exe 'vert 2resize ' . ((&columns * 119 + 116) / 233)
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
exe 'vert 1resize ' . ((&columns * 99 + 116) / 233)
exe 'vert 2resize ' . ((&columns * 133 + 116) / 233)
argglobal
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal nofen
let s:l = 7 - ((5 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
7
normal! 027|
lcd ~/Projects/hackend
wincmd w
argglobal
if bufexists("~/Projects/hackend/templates/contact/contact.cassius") | buffer ~/Projects/hackend/templates/contact/contact.cassius | else | edit ~/Projects/hackend/templates/contact/contact.cassius | endif
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal nofen
let s:l = 62 - ((0 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
62
normal! 05|
lcd ~/Projects/hackend
wincmd w
exe 'vert 1resize ' . ((&columns * 99 + 116) / 233)
exe 'vert 2resize ' . ((&columns * 133 + 116) / 233)
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
exe 'vert 1resize ' . ((&columns * 102 + 116) / 233)
exe 'vert 2resize ' . ((&columns * 130 + 116) / 233)
argglobal
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal nofen
let s:l = 7 - ((5 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
7
normal! 08|
lcd ~/Projects/hackend
wincmd w
argglobal
if bufexists("~/Projects/hackend/templates/footer/footer.cassius") | buffer ~/Projects/hackend/templates/footer/footer.cassius | else | edit ~/Projects/hackend/templates/footer/footer.cassius | endif
setlocal fdm=syntax
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=2
setlocal fml=1
setlocal fdn=10
setlocal nofen
let s:l = 8 - ((0 * winheight(0) + 25) / 50)
if s:l < 1 | let s:l = 1 | endif
exe s:l
normal! zt
8
normal! 02|
lcd ~/Projects/hackend
wincmd w
exe 'vert 1resize ' . ((&columns * 102 + 116) / 233)
exe 'vert 2resize ' . ((&columns * 130 + 116) / 233)
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
