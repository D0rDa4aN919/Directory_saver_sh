#!/bin/bash
user=$(whoami)

if [ "$user" == "root" ]; then
    main_directory="/$user"
else
    main_directory="/home/$user"
fi
img_arr=("jpg" "png" "gif" "jpeg" "bmp" "tiff" "webp" "svg" "ico" "psd")
doc_arr=("pdf" "json" "csv" "txt" "doc" "docx" "xls" "xlsx" "ppt" "pptx" "odt" "ods" "odp" "rtf" "xml")
scr_arr=("sh" "py" "c" "cpp" "java" "js" "php" "pl" "rb" "swift" "bash" "ps1" "bat" "cmd")
aud_arr=("mp3" "wav" "ogg" "flac" "m4a" "aac" "wma" "aiff" "ape" "alac" "opus" "mid" "amr" "ra")
vid_arr=("mp4" "avi" "mkv" "gif" "wmv" "m4v" "m4p" " mpg" "mpeg" "flv" "nsv" "mxf" "viv")

function main(){
    checker "$main_directory" "file_structure"
    current_date=$(date +"%Y_%m_%d")
    checker "$main_directory/file_structure" "$current_date"
    set_transfor
    final_step "$main_directory/file_structure/$current_date"
}
function checker() {
    num=2
    check=$(ls "$1")
    for name in $check; do
        if [ "$name" == "$2" ]; then
            num=1
            break
        fi
    done
    num_check "$num" "$1/$2"
}

function num_check() {
    if [ $1 -eq 2 ]; then
        mkdir -p "$2"
    else
        echo "This folder is already there"
    fi
    cd "$2"
}

function find_elements(){
    elements=$(find "$main_directory" -type f -name "*.$1" 2>/dev/null)
    for name in $elements; do
        mv "$name" "$2"
    done
}

function set_options(){
    mkdir "$1"
    for ext in $2; do
        find_elements "$ext" "$1"  # Passed the correct folder name as the second argument
    done
}

function set_transfor() {
    set_options "documents" "${doc_arr[@]}"
    set_options "images" "${img_arr[@]}"
    set_options "videos" "${vid_arr[@]}"
    set_options "scripts" "${scr_arr[@]}"
    set_options "audios" "${aud_arr[@]}"
}

function final_step(){
    dirs=$(ls "$1")
    for dir in $dirs; do
        listing=$(ls "$1/$dir")
        if [ -z "$listing" ]; then
            echo "The folder $dir is empty."
            rmdir "$1/$dir"
        else
            echo "The folder $dir is not empty."
        fi
    done
}

if [ "${BASH_SOURCE[0]}" = "$0" ]; then
    main
fi
