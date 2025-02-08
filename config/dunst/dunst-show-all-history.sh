#!/bin/bash

hist_size="$(dunstctl count history)"
for i in $(seq 1 "$hist_size"); do
    dunstctl history-pop
done
