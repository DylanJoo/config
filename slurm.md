function gpucount(){
    declare -a names
    list=()
    for x in $(squeue -p gpu -o "%u %t %b %m"); do
        list+=( "$x" )
        #echo $x
    done
    names=()
    gpus=()
    rams=()
    total=0
    for (( i=4; i<${#list[*]}; i+=4)); do
        existing=-1
        #echo "${list[i+1]}"
        if [ "${list[i+1]}" = "R" ]; then
            for (( j=0; j<${#names[*]}; j+=1)); do
                if [ "${list[i]}" = "${names[j]}" ]; then
                    existing=$j
                    break
                fi
            done
            tmp=$(echo "${list[i+2]}" | tr ":" "\n")
            for x in $tmp; do
                gcnt=$x
            done
            tmp=$(echo "${list[i+3]}" | tr "G" "\n")
            for x in $tmp; do
                ramcnt=$x
            done
            total=$(( $total + 1 ))
            if [ $existing -eq -1 ]; then
                names+=( "${list[i]}" )
                gpus+=( "$gcnt" )
                rams+=( "$ramcnt" )
            else
                gpus[$existing]=$((${gpus[$existing]}+$gcnt))
                rams[$existing]=$((${rams[$existing]}+$ramcnt))
            fi
        fi
    done

    for (( i=0; i<${#names[*]}; i+=1 )); do
        printf '%20s  : %6s cores    %6sG\n' "${names[i]}" "${gpus[i]}" "${rams[i]}"
    done
    printf '%20s----%6s\n' "--------" "------"
    printf '%20s  : %6s cores\n' "total" "$total"
}
