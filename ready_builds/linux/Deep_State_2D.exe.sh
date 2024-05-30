#!/bin/sh
echo -ne '\033c\033]0;Deep_State_2D\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/Deep_State_2D.exe.x86_64" "$@"
