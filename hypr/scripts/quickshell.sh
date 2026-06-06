#!/bin/bash

if pgrep -x "qs" > /dev/null; then
    pkill -x qs
else
    qs -c caelestia &
fi
