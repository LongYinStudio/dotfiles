#!/usr/bin/env bash

directory=~/Pictures/wallpaper
monitor=$(hyprctl monitors | grep Monitor | awk '{print $2}')

if [ -d "$directory" ]; then
	# while true; do
	random_background=$(ls $directory/*.{jpg,png} | shuf -n 1)

	hyprctl hyprpaper unload all
	hyprctl hyprpaper preload "$random_background"
	hyprctl hyprpaper wallpaper "$monitor, $random_background"

	# 	sleep 900
	# done
fi
