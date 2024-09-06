#!/usr/bin/bash
# ICON=$HOME/Pictures/lock.png
TMPBG=/tmp/screen.png
if [ -f "$TMPBG" ]
then
    rm /tmp/screen.png
fi
scrot /tmp/screen.png
# convert $TMPBG -scale 10% -scale 1000% $TMPBG
magick $TMPBG -blur 0x8 $TMPBG
# convert $TMPBG -blur 0x8 $TM
# convert $TMPBG $ICON -gravity center -composite -matte $TMPBG
i3lock -i $TMPBG -ef
