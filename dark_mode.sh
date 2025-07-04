#!/bin/bash

echo "changing to dark mode!"

gsettings set org.cinnamon.desktop.background picture-uri  "file:////home/david/Documents/Pictures/Wallpapers/galaxy.jpg"


gsettings set org.cinnamon.theme name 'WhiteSur-dark'
gsettings set org.cinnamon.desktop.interface icon-theme 'WhiteSur'
gsettings set org.cinnamon.desktop.wm.preferences theme 'WhiteSur-dark'
# NOTE: capitalization matters here!!!
gsettings set org.cinnamon.desktop.interface gtk-theme 'WhiteSur-Dark'


