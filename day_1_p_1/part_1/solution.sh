#! /bin/bash

previous=$(( 0 ))
count=$(( -1 ))

while IFS= read -r next || [[ -n "$next" ]]; do
    [[ next -gt previous ]] && { count=$(( count + 1 )); }
    previous=$next
done 

echo $count
