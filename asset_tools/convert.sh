#! /usr/bin/env bash

for file in ./*; do
	if [ -f "$file" ]; then
        magick "$file" "${file%.dds}.png"; 
    fi
done
