#!/bin/sh

# creates a suspended menu for selection of the
# audio output

# this is for newlines
nl='
'

card=$(pactl list short cards | head -n 1 | cut -f 2)
profiles=""
active=""

while read line; do
    if echo "$line" | grep -q "Card #"; then
        while read line; do
            if echo "$line" | grep -q "Profiles:"; then
                while read line; do
                    if echo "$line" | grep -q "Active Profile:"; then
                        active=$(echo $line | sed 's/Active Profile: output://' | sed 's/+input:analog-stereo//')
                        break
                    elif echo "$line" | grep -q "+input:analog-stereo"; then
                        profiles="$profiles${profiles:+$nl}$(echo "$line" | sed -E 's/output:([^ ]*)\+input:analog-stereo.*/\1/')"
                    fi
                done
                break
            fi
        done
        break
    fi
done < <(pactl list cards)

selected="$(echo "$profiles" | rofi -dmenu -select $active -theme-str 'inputbar { enabled: false; } window { location: center; y-offset: 0; } message{ background-color: transparent; padding: 0; margin: 0; }' -mesg '<span font_size="18000">Audio output</span>' -no-custom)"

if [ "$selected" = "" ]; then
    exit
fi

pactl set-card-profile $card "output:$selected+input:analog-stereo" &
notify-send "switched audio output to ${selected}." -t 5000 -u low
