#!/usr/bin/env bash
cached_command_folder="$HOME/.cache/wallust"
cached_command_path="$cached_command_folder/apply_wallpaper.sh"
launch_cmd=""
input=""
wallpaper_png=""

function restartWayBar {
    killall -SIGUSR2 waybar
}

function hyprpaperUnload {
    hyprctl hyprpaper unload all
}

function killMpvpaper {
    killall mpvpaper
}

function checkcmd {
    declare -n failstatus=$2
    if ! command -v "$1" >/dev/null 2>&1; then
        echo "$1 is not installed" >&2
        failstatus=1
    fi
}

function waitForHyprpaper {
    until hyprctl hyprpaper; do echo "Waiting for hyprpaper to start..."; sleep 1; done
}

checkcmd mpvpaper failed
checkcmd hyprctl failed
checkcmd ffmpeg failed
checkcmd wallust failed

[ -z $failed ] || exit

waitForHyprpaper

args=($@)
for ((i=0; i <= ${#args[@]}; i++)); do
    case ${args[i]} in
        "-R")
            killMpvpaper
            hyprpaperUnload
            test -f $cached_command_path && exec $cached_command_path &
            exit
        ;;
        "-i")
            input="$(realpath "${args[i+1]}")"
            wallpaper_png="$input"
        ;;
        "-h" | "--help")
            echo "-h, --help    Send this help message"
            echo "-R            Restore last session's wallpaper and colorscheme"
            echo "-i            Path to wallpaper file, png or mp4"
            echo "              If this flag is absent then the last agrument"
            echo "              must be the path to a wallpaper file"
            exit
        ;;

    esac
done

if [ -z "$input" ]; then
    input="$(realpath ${args[-1]})"
    wallpaper_png="$input"
    if [ ! -f "$input" ] ;then
        echo "File does not exist" >&2
        exit
    fi
fi

is_vidya=false
if ffprobe "$input" -hide_banner -loglevel panic -select_streams v:0 -show_entries stream=codec_name | grep -q "h264" ; then
    wallpaper_png="/tmp/extracted_frame.png"
    ffmpeg -i "$input" -vframes 1 -y "$wallpaper_png" &> /dev/null
    is_vidya=true
fi

wallust run $wallpaper_png

if [ $? != 0 ]; then
    echo "wallust run command failed, exiting..." >&2
    exit
fi

if [ "$is_vidya" = true ] ; then
    hyprpaperUnload
    launch_cmd="mpvpaper -f ALL \"$input\""
else
    killMpvpaper
    launch_cmd="hyprctl hyprpaper reload ,\"$input\""
fi

[ -d "$cached_command_folder" ] || mkdir "$cached_command_folder"

restartWayBar

echo "$launch_cmd" > "$cached_command_path"
chmod +x "$cached_command_path"
exec "$cached_command_path"

cp -- $wallpaper_png /usr/share/wallpapers/wal

pidof dunst && killall dunst
cat $HOME/.config/dunst/dunstrc ~/.cache/wallust/dunst-color | dunst -conf - &
