
#!/bin/bash

IMG=~./bsod.png
TMP=/tmp/lock.png
RES=$(xdpyinfo | awk '/dimensions/{print $2}')

magick "$IMG" -resize ${RES}^ -gravity center -extent ${RES} "$TMP"
i3lock -i "$TMP"
