let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/PX4-Autopilot
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +1 ~/PX4-Autopilot
badd +1 Tools/simulation/gz/worlds
badd +1 Tools/simulation/gazebo-classic/sitl_gazebo-classic
badd +1 Tools/simulation/gazebo-classic/sitl_gazebo-classic/models/depth_camera/model.config
badd +1 Tools/simulation/gazebo-classic/sitl_gazebo-classic/models/depth_camera
badd +1 Tools/simulation/gazebo-classic/sitl_gazebo-classic/models/depth_camera/depth_camera.sdf
badd +1 Tools/simulation/gazebo-classic/sitl_gazebo-classic/models
badd +81 Tools/simulation/gz/simulation-gazebo
badd +2 Tools/simulation/gz/tools/avl_automation/input.yml
badd +33 Tools/simulation/gz/sdf_parsing/check_sdf.cc
badd +1 Tools/simulation/gz/README.md
badd +1 Tools/simulation/gz/fuel_upload.sh
badd +1 Tools/simulation/gz/models/x500_depth/model.config
badd +1 Tools/simulation/gz/models/x500_depth/model.sdf
badd +1 Tools/simulation/gz/models/x500_depth/thumbnails/1.png
badd +1 Tools/simulation/sitl_multiple_run.sh
badd +1 Tools/simulation/gz/worlds/rover.sdf
badd +1 Tools/simulation/gz/models/x500_depth
badd +7 Tools/simulation/gz/models/OakD-Lite/model.sdf
badd +1 Tools/simulation/gz/models/OakD-Lite
badd +18 Tools/simulation/gz/models/x500/model.sdf
badd +1 Tools/simulation/gz/models/x500
badd +1 Tools/simulation/gz/LICENSE
badd +72 Tools/px4.py
badd +108 CMakeLists.txt
badd +1 build/px4_sitl_default/bin/px4
badd +1 build/px4_sitl_default/src/modules/simulation/gz_bridge/libmodules__simulation__gz_bridge.a
badd +1 ROMFS/px4fmu_common/init.d-posix/px4-rc.simulator
badd +67 src/modules/simulation/gz_bridge/CMakeLists.txt
badd +1 src/modules/simulation/gz_bridge
badd +87 src/modules/simulation/gz_bridge/GZBridge.cpp
badd +21 src/modules/simulation/gz_bridge/GZBridge.hpp
badd +36 src/modules/simulation/gz_bridge/GZMixingInterfaceESC.hpp
badd +1 Makefile
badd +206 Tools/simulation/gz/worlds/lawn.sdf
badd +977 Tools/simulation/gz/worlds/road.sdf
badd +3 term://~/PX4-Autopilot//173495:/usr/bin/zsh
badd +1 Tools/simulation/gz/models/x500_base/model.sdf
badd +48 Tools/simulation/gz/worlds/Tree1.dae
badd +1 Tools/simulation/gz/worlds/BarkDecidious0194_7_S.jpg
badd +74 Tools/simulation/gz/worlds/Leafs.dae
badd +1 Tools/simulation/gz/worlds/Leaves.dae
badd +29 build/px4_sitl_default/etc/init.d-posix/px4-rc.mavlink
argglobal
%argdel
$argadd Tools/simulation/gazebo-classic/sitl_gazebo-classic
set stal=2
tabnew +setlocal\ bufhidden=wipe
tabrewind
edit src/modules/simulation/gz_bridge/GZBridge.cpp
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
exe 'vert 1resize ' . ((&columns * 104 + 105) / 210)
exe 'vert 2resize ' . ((&columns * 105 + 105) / 210)
argglobal
balt Tools/simulation/gz/worlds/road.sdf
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
let s:l = 87 - ((35 * winheight(0) + 26) / 52)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 87
normal! 0
lcd ~/PX4-Autopilot
wincmd w
argglobal
if bufexists(fnamemodify("~/PX4-Autopilot/src/modules/simulation/gz_bridge/GZBridge.hpp", ":p")) | buffer ~/PX4-Autopilot/src/modules/simulation/gz_bridge/GZBridge.hpp | else | edit ~/PX4-Autopilot/src/modules/simulation/gz_bridge/GZBridge.hpp | endif
if &buftype ==# 'terminal'
  silent file ~/PX4-Autopilot/src/modules/simulation/gz_bridge/GZBridge.hpp
endif
balt ~/PX4-Autopilot/src/modules/simulation/gz_bridge/GZBridge.cpp
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
let s:l = 206 - ((50 * winheight(0) + 26) / 52)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 206
normal! 029|
lcd ~/PX4-Autopilot
wincmd w
exe 'vert 1resize ' . ((&columns * 104 + 105) / 210)
exe 'vert 2resize ' . ((&columns * 105 + 105) / 210)
tabnext
edit ~/PX4-Autopilot/Tools/simulation/gz/worlds/road.sdf
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
exe 'vert 1resize ' . ((&columns * 104 + 105) / 210)
exe 'vert 2resize ' . ((&columns * 105 + 105) / 210)
argglobal
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
let s:l = 544 - ((36 * winheight(0) + 26) / 52)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 544
normal! 012|
lcd ~/PX4-Autopilot
wincmd w
argglobal
if bufexists(fnamemodify("~/PX4-Autopilot/build/px4_sitl_default/etc/init.d-posix/px4-rc.mavlink", ":p")) | buffer ~/PX4-Autopilot/build/px4_sitl_default/etc/init.d-posix/px4-rc.mavlink | else | edit ~/PX4-Autopilot/build/px4_sitl_default/etc/init.d-posix/px4-rc.mavlink | endif
if &buftype ==# 'terminal'
  silent file ~/PX4-Autopilot/build/px4_sitl_default/etc/init.d-posix/px4-rc.mavlink
endif
balt ~/PX4-Autopilot/Tools/simulation/gz/worlds/road.sdf
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
let s:l = 30 - ((29 * winheight(0) + 26) / 52)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 30
normal! 0
lcd ~/PX4-Autopilot
wincmd w
exe 'vert 1resize ' . ((&columns * 104 + 105) / 210)
exe 'vert 2resize ' . ((&columns * 105 + 105) / 210)
tabnext 1
set stal=1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
nohlsearch
let g:this_session = v:this_session
let g:this_obsession = v:this_session
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
