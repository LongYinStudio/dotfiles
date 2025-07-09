#!/bin/bash
# Author: LongYinStudio <1606776851@qq.com> (https://github.com/LongYinStudio)
# Date: 2025-05-26 16:52:26
# Desc: 随机播放几个视频

VIDEO_DIR="$HOME/Videos"
VLC="vlc --loop"
MPV="mpv"

if [ -d "$VIDEO_DIR" ] && [ "$(ls -A "$VIDEO_DIR")" ]; then
  # 生成随机视频文件列表 8个
  IFS=$'\n' read -r -d '' -a VIDEOS < <(find "$VIDEO_DIR" -maxdepth 1 -type f \( \
    -iname "*.mp4" -o -iname "*.mkv" -o -iname "*.avi" \) | shuf -n 8 && printf '\0')

  for video in "${VIDEOS[@]}"; do
    ${VLC} "$video" 2>/dev/null &
  done

else
  echo "视频文件夹不存在或者为空"
fi
