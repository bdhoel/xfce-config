#!/usr/bin/env bash

# reference https://forum.xfce.org/viewtopic.php?pid=43171#p43171
# useful command to debug: 
# to list panels property: xfconf-query --channel 'xfce4-panel' --property '/panels' --list --verbose
# to list plugins property: xfconf-query --channel 'xfce4-panel' --property '/plugins' --list --verbose
# see current xml config: cat ~/.config/xfce4/xfconf/xfce-perchannel-xml/xfce4-panel.xml

set -e

xfce4-panel --quit

# Remove launcher (from panel-2) configuration files
for launcher_id in {13..16}; do
    rm -rf ~/.config/xfce4/panel/launcher-${launcher_id}
done

# Delete all panels and plugins. We will recreate them later.
# Note: -rR can be replaced with --reset --recursive
xfconf-query --channel 'xfce4-panel' --property '/panels' --reset --recursive
xfconf-query -c xfce4-panel -p /plugins -rR



# recreate plugin 
xfconf-query --channel 'xfce4-panel' --property '/plugins/plugin-1' --create --type string --set whiskermenu
xfconf-query --channel 'xfce4-panel' --property '/plugins/plugin-2' --create --type string --set tasklist
xfconf-query --channel 'xfce4-panel' --property '/plugins/plugin-2/grouping' --create --type bool --set false
xfconf-query --channel 'xfce4-panel' --property '/plugins/plugin-2/show-handle' --create --type bool --set false
xfconf-query --channel 'xfce4-panel' --property '/plugins/plugin-2/show-labels' --create --type bool --set true
xfconf-query --channel 'xfce4-panel' --property '/plugins/plugin-2/show-tooltips' --create --type bool --set false
xfconf-query --channel 'xfce4-panel' --property '/plugins/plugin-3' --create --type string --set separator
xfconf-query --channel 'xfce4-panel' --property '/plugins/plugin-3/expand' --create --type bool --set true
xfconf-query --channel 'xfce4-panel' --property '/plugins/plugin-3/style' --create --type uint --set 0
xfconf-query --channel 'xfce4-panel' --property '/plugins/plugin-4' --create --type string --set systray
xfconf-query --channel 'xfce4-panel' --property '/plugins/plugin-4/square-icons' --create --type bool --set true
xfconf-query --channel 'xfce4-panel' --property '/plugins/plugin-5' --create --type string --set separator
xfconf-query --channel 'xfce4-panel' --property '/plugins/plugin-5/style' --create --type uint --set 0
xfconf-query --channel 'xfce4-panel' --property '/plugins/plugin-6' --create --type string --set clock
xfconf-query --channel 'xfce4-panel' --property '/plugins/plugin-6/digital-layout' --create --type uint --set 3
xfconf-query --channel 'xfce4-panel' --property '/plugins/plugin-6/digital-time-font' --create --type string --set "Sans 10"
xfconf-query --channel 'xfce4-panel' --property '/plugins/plugin-7' --create --type string --set separator
xfconf-query --channel 'xfce4-panel' --property '/plugins/plugin-7/style' --create --type uint --set 0


# recreate panel
xfconf-query --channel 'xfce4-panel' --property '/panels' --force-array --create --type int --set 1
xfconf-query --channel 'xfce4-panel' --property '/panels/dark-mode' --create --type bool --set true
xfconf-query --channel 'xfce4-panel' --property '/panels/panel-1/icon-size' --create --type uint --set 16
xfconf-query --channel 'xfce4-panel' --property '/panels/panel-1/length' --create --type uint --set 100
xfconf-query --channel 'xfce4-panel' --property '/panels/panel-1/position' --create --type string --set "p=8;x=960;y=1066"
xfconf-query --channel 'xfce4-panel' --property '/panels/panel-1/position-locked' --create --type bool --set true
xfconf-query --channel 'xfce4-panel' --property '/panels/panel-1/size' --create --type uint --set 26
xfconf-query -c xfce4-panel -p /panels/panel-1/plugin-ids --force-array --create \
    --type int --set 1 \
    --type int --set 2 \
    --type int --set 3 \
    --type int --set 4 \
    --type int --set 5 \
    --type int --set 6 \
    --type int --set 7

xfce4-panel &



echo "XFCE panel configuration completed."