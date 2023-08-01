#!/bin/bash
##############################################################################
# File Organizer SH - Bash Script
# Description: A bash script to organize files into specific directories based on their file extensions and backup the user directory.
# Author: Dor Dahan
# License: MIT (See details in the LICENSE file or at the end of this script)
##############################################################################
Green='\033[0;32m'
Reset='\033[0m' 
Red='\033[0;31m'
Bold='\033[1m'
Blue='\033[0;34m'
user=$(whoami)

if [ "$user" == "root" ]; then
    main_directory="/$user"
else
    main_directory="/home/$user"
fi

img_arr=(".jpg" ".png" ".gif" ".jpeg" ".bmp" ".tiff" ".webp" ".svg" ".ico" ".psd")
doc_arr=(".pdf" ".json" ".csv" ".txt" ".doc" ".docx" ".xls" ".xlsx" ".ppt" ".pptx" ".odt" ".ods" ".odp" ".rtf" ".xml")
scr_arr=(".sh" ".py" ".c" ".cpp" ".java" ".js" ".php" ".pl" ".rb" ".swift" ".bash" ".ps1" ".bat" ".cmd")
aud_arr=(".mp3" ".wav" ".ogg" ".flac" ".m4a" ".aac" ".wma" ".aiff" ".ape" ".alac" ".opus" ".mid" ".amr" ".ra")
vid_arr=(".mp4" ".avi" ".mkv" ".gif" ".wmv" ".m4v" ".m4p" ".mpg" ".mpeg" ".flv" ".nsv" ".mxf" ".viv")
unknown=("")
function main(){
    current_date=$(date +"%Y_%m_%d")
    check_install_zip
    backup_dir "$main_directory" "$current_date"
    checker "$main_directory" "file_structure"
    checker "$main_directory/file_structure" "$current_date"
    set_transfor
    final_step "$main_directory/file_structure/$current_date"
}


function backup_dir() {
    backup_path="/var/backup/"
    if [ -d "$backup_path" ]; then
        echo -e "${Blue}${Bold}Backup directory already exists${Reset}."
    else
        echo -e "${Red}${Bold}Backup directory not found. Creating it...${Reset}"
        mkdir -p "$backup_path" || {
            echo "-e ${Red}${Bold}Error: Failed to create backup directory.${Reset}"
            exit 1
        }
    fi
    cd "$backup_path" || {
        echo -e "${Red}${Bold}Error: Failed to enter backup directory.${Reset}"
        exit 1
    }
    mkdir -p "$2" || {
        echo -e "${Red}${Bold}Error: Failed to create backup directory.${Reset}"
        exit 1
    }
    cd "$2" || {
        echo -e "${Red}${Bold}Error: Failed to enter backup directory.${Reset}"
        exit 1
    }
    cp -r "$1" .
    cd ..
    chmod 700 "$2"
    chown "$user":"$user" "$2"
    zip "$2.zip" "$2"
    mkdir -p "backup_$2" || {
       echo -e "${Red}${Bold}Error: Failed to create backup directory.${Reset}"
       exit 1
   }
   mv "$2" "$2.zip" "backup_$2"
   cd -
}

function check_install_zip() {
    echo -e "${Blue}${Bold}Starting installation check...${Reset}"
    if ! command -v zip &>/dev/null; then
        echo -e "${Blue}${Bold}Zip command not found. Installing zip...${Reset}"
        if command -v apt-get &>/dev/null; then
            sudo apt-get update >/dev/null
            sudo apt-get install -y zip >/dev/null
        elif command -v yum &>/dev/null; then
            sudo yum install -y zip >/dev/null
        elif command -v dnf &>/dev/null; then
            sudo dnf install -y zip >/dev/null
        elif command -v pacman &>/dev/null; then
            sudo pacman -Syu --noconfirm zip >/dev/null 
        else
            echo -e "${Red}${Bold}Error: Cannot install zip. Unsupported package manager.${Reset}"
            exit 1
        fi
        
        if ! command -v zip &>/dev/null; then
            echo -e "${Red}${Bold}Error: Failed to install zip. Please install it manually.${Reset}"
            exit 1
        fi
        echo -e "${Green}${Bold}zip installed successfully.${Reset}"
    fi
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
        mkdir -p "$2" 2>/dev/null
    else
        echo -e "${Blue}${Bold}This folder is already there${Reset}"
    fi
    cd "$2"
}

function find_elements(){
    elements=$(find "$main_directory" -type f -name "*$1" 2>/dev/null)
    IFS=$'\n'
    for name in $elements; do
        mv "$name" "$2"
    done
}

function set_options(){
    if [ "$2" == "" ]; then
        path="unknown"
        mkdir "unknown" 2>/dev/null
    else
        path="$1"
        mkdir "$path" 2>/dev/null
    fi
    for ext in "${@:2}"; do
        find_elements "$ext" "$path"
    done
}

function set_transfor() {
    set_options "images" "${img_arr[@]}"
    set_options "documents" "${doc_arr[@]}"
    set_options "scripts" "${scr_arr[@]}"
    set_options "audios" "${aud_arr[@]}"
    set_options "videos" "${vid_arr[@]}"
}

function final_step(){
    main_path="$1"
    cd "$main_path"
    listing_folder=$(ls "$1")
    for value in $listing_folder; do
        listing=$(ls "$value")
        if [ -z "$listing" ]; then
            echo -e "${Red}${Bold}The folder '$value' is empty.${Reset}"
            rmdir "$value" 2>/dev/null
        else
            echo -e "${Green}${Bold}The folder '$value' is not empty.${Reset}"
        fi
    done
}

if [ "${BASH_SOURCE[0]}" = "$0" ]; then
    main
fi

# License Information
# This script is open-source and released under the MIT License.
# MIT License
# Copyright (c) 2023 Dor Dahan
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.
# For more details, see the LICENSE file in the root directory of this repository
# or visit https://github.com/D0rDa4aN919/File_Organizer_Sh_Script.
