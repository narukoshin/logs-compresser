#!/bin/bash

folders=("/mnt/d/Dev/logs" "/mnt/d/Dev/logs2")
file_ext="log"

for f in "${folders[@]}"; do
    if [[ -d "${f}" ]]; then
        cd $f
        if $(compgen -G "*.$file_ext" > /dev/null); then
            prev_month=0`expr $(date +"%m") - 1`
            archive_name=$(date -d $(date +"%Y-$prev_month-%d") '+%B-%Y').tar.gz
            tar -zcvf $archive_name *.$file_ext --remove-files > /dev/null
        fi
    fi
done