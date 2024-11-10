#!/bin/bash

folders=($(cat /root/logs-compresser/folders.cfg))

for f in "${folders[@]}"; do
    echo "${f}"
    if [[ -d "${f}" ]]; then
        cd $f
        if $(compgen -G "*.$file_ext" > /dev/null); then
            echo true
	    prev_month=0`expr $(date +"%m") - 1`
            archive_name=$(date -d $(date +"%Y-$prev_month-%d") '+%B-%Y').tar.gz
            echo "$archive_name"
	    tar -zcvf $archive_name *.log *.txt --remove-files > /dev/null
        fi
    fi
done

# Reloading nginx server to enable writing to newly created logs
systemctl reload nginx
systemctl reload apache2
