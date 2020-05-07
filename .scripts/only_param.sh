#!/bin/sh

thunar_exec="$1"
thunar_wm_class="$2"

# no thunar started, so start one
if [ -z "`wmctrl -lx | grep emacs`" ]; then
    $thunar_exec &
else
    # search for existing thunars on current desktop
    current_desk=`wmctrl -d | grep '*' | cut -d ' ' -f 1`
    thunar_on_this_desk=`wmctrl -lx | grep "$current_desk[ ]*$thunar_wm_class" | cut -d ' ' -f 1`
    if [ -n "$thunar_on_this_desk" ]; then
        wmctrl -i -a $thunar_on_this_desk
    else
        # no thunars on any desktop, so open a new one
        wmctrl -x -R $thunar_wm_class
    fi;
fi;
