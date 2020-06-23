#cvt 1920 1080 
#xrandr --newmode "1920x1080"  173.00  1920 2048 2248 2576  1080 1083 1088 1120 -hsync +vsync
#xrandr --addmode Virtual1 "1920x1080"
#xrandr --output Virtual1 --mode "1920x1080"

xrandr --output Screen0 --mode "1920x1080" &
feh --bg-center /home/ajie/Downloads/beach.jpg &
compton -b 
if [ -f ~/.Xmodmap ]; then xmodmap ~/.Xmodmap; fi
exec dwm
