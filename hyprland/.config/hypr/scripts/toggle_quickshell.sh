#!/bin/sh

if [[ $(pidof qs) ]]; then
    pkill qs
else
    qs & disown
fi
