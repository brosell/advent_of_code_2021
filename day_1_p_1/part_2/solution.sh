#! /bin/bash

previous=$(( 0 ))
window=()

count=$(( -1 ))

while IFS= read -r next || [[ -n "$next" ]]; do
    window+=($next)
    [[ "${#window[@]}" == "3" ]] && {
        current=$(( window[0] + window[1] + window[2] ))
        window=("${window[@]:1}")
        [[ current -gt previous ]] && { count=$(( count + 1 )); }
        previous=$current
    }
done 

echo $count
