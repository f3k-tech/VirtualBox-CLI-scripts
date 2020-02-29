#!/bin/bash

select mediumtype in "${mediumlist[@]}"
do
    case $mediumtype in
        read -p ""
        break;;
        *) break;;
    esac
done