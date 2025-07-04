#!/bin/bash

echo "changing to light mode"
gsettings set org.cinnamon.desktop.background picture-uri  "file:////home/david/Documents/Pictures/Wallpapers/clouds.jpg"
gsettings set org.cinnamon.theme name 'WhiteSur-light'
gsettings set org.cinnamon.desktop.interface icon-theme 'WhiteSur'
gsettings set org.cinnamon.desktop.wm.preferences theme 'WhiteSur-light'
# NOTE: capitalization matters here!!!
gsettings set org.cinnamon.desktop.interface gtk-theme 'WhiteSur-Light'
