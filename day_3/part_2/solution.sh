#! /bin/bash

b2d() {
    echo $((2#$1))
}

mostByBit() { 
    bit=$1
    matchVal=$2
    shift; shift
    list=("$@")
    
    [[ $bit -gt 0 ]] && { dots=$(printf '%*s' "$bit" | tr ' ' "."  ); }
    reg="^${dots}"
    matchReg="^${dots}0"; noMatchReg="^${dots}1";
    [[ "$matchVal" == "1" ]] && { matchReg="^${dots}1"; noMatchReg="^${dots}0"; }
    
    # echo $matchVal, $matchReg, $noMatchReg > /dev/stderr

    with=( $(printf -- '%s\n' "${list[@]}" | grep "${matchReg}" ) )
    withOut=( $(printf -- '%s\n' "${list[@]}" | grep "${noMatchReg}" ) )

    [[ "$matchVal" == "1" ]] && {
        [[ ${#withOut[@]} -gt ${#with[@]} ]] && echo "${withOut[@]}" || echo "${with[@]}"
        return 0
    }
    
    [[ ${#withOut[@]} -lt ${#with[@]} ]] && echo "${withOut[@]}" || echo "${with[@]}"
    
}

reduce() {
    match=$1
    shift
    list=("$@")

    bit=0
    
    while [ ${#list[@]} -gt 1 ]
    do
        # echo bit: $bit: "${list[@]}" > /dev/stderr
        list=( $( mostByBit $bit $match "${list[@]}") )
        bit=$(( bit + 1 ))
    done
    echo $list
}

readarray -t fullList < "${1:-/dev/stdin}"

o2=$(b2d $( reduce 1 "${fullList[@]}" ) )
echo o2: $o2

co2=$(b2d $( reduce 0 "${fullList[@]}" ) )
echo co2: $co2

echo life support rating: $(( o2 * co2 ))



