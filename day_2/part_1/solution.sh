#! /bin/bash

depth=0
horizontal=0

while IFS= read -r next || [[ -n "$next" ]]; do
    movement=( $next )
    [[ ${movement[0]} == forward ]] && horizontal=$(( horizontal + movement[1] ))
    [[ ${movement[0]} == down ]] && depth=$(( depth + movement[1] ))
    [[ ${movement[0]} == up ]] && depth=$(( depth - movement[1] ))
done 

echo $(( horizontal * depth ))
