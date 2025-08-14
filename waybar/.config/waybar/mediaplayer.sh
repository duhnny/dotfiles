#!/bin/sh

prefix=""
artist=""
title=""

player_status=$(playerctl -p spotify status 2> /dev/null)

if [[ $player_status = "Playing" || $player_status = "Paused" ]]; then
    artist=$(playerctl -p spotify metadata artist)
    title=$(playerctl -p spotify metadata title)
fi

if [[ $player_status = "Paused" ]]; then
    prefix=""
fi

if [ ! -z "$title" ]; then
    echo "${prefix:+$prefix  }$artist - $title"
fi
