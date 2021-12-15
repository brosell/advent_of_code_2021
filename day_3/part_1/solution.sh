#! /bin/bash

b2d() {
    echo $((2#$1))
}

d2b() {
    bc <<< "obase=2;$1"
}
bits=()
rowCount=0

while IFS= read -r next || [[ -n "$next" ]]; do
    len=${#next}
    rowCount=$(( rowCount + 1 ))
    for (( i=0; i<$len; i++ )); do 
        [[ "${next:$i:1}" == "1" ]] && bits[$i]=$(( bits[$i] + 1 ))
    done
done 

len=${#bits[@]}
gammaB=""
epsilonB=""

halfRowCount=$(( rowCount / 2 ))

for (( i=0; i<$len; i++ )); do
    [[ ${bits[$i]} -gt $halfRowCount ]] && { gammaB="${gammaB}1"; epsilonB="${epsilonB}0"; } || { gammaB="${gammaB}0"; epsilonB="${epsilonB}1"; }
done

gamma=$(b2d $gammaB)
epsilon=$(b2d $epsilonB)
echo gamma: $gamma
echo epsilon: $epsilon

echo power consumption: $(( gamma * epsilon ))