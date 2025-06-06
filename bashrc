# . /ivi/ilps/personal/dju/miniconda3/etc/profile.d/conda.sh
export LANGUAGE=UTF-8
export LC_ALL=en_US.UTF-8
export LANG=UTF-8
export LC_CTYPE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_COLLATE=$LANG
export LC_CTYPE=$LANG
export LC_MESSAGES=$LANG
export LC_MONETARY=$LANG
export LC_NUMERIC=$LANG
export LC_TIME=$LANG
export LC_ALL=$LANG

# Add this for runing GPU on UvA's slurm
# export CUDA_HOME="/usr/local/cuda-12.3"
# export CUDA_HOME="/usr/local/cuda-11"
# export PATH="${CUDA_HOME}/bin:${PATH}"
export LIBRARY_PATH="${CUDA_HOME}/lib64:${LIBRARY_PATH}"
export PATH="$PATH:/home/dju/temp/nvim-linux-x86_64/bin"
export LD_LIBRARY_PATH="${CUDA_HOME}/lib64:${LD_LIBRARY_PATH}"
unset LD_LIBRARY_PATH
# export CUDA_HOST_COMPILER=/usr/bin/gcc

# My personal storage link
export DATA_DIR=/ivi/ilps/personal/dju/datasets/
export INDEX_DIR=/ivi/ilps/personal/dju/indexes/
export MODEL_DIR=/ivi/ilps/personal/dju/checkpoints/

# You want $TERM to be screen-256color when tmux is running, and you want it to be xterm-256color when tmux is not running.
export TERM=screen-256color

# Customized plugin 
function show_jobs {
    squeue --format="%.18i %.9P %.30j %.8u %.8T %.10M %.9l %.6D %R" --me
}
function enter_conda {
    source /ivi/ilps/personal/dju/miniconda3/etc/profile.d/conda.sh 
}
function pretty_csv {
    column -t -s, -n "$@" | less -F -S -X -K
}
function value_counts {
    cut -f "$2" "$1" | sort | uniq -c | sort -nr
}
function rm_empty {
    find . -type f -empty -print -delete
}
function big_file_ignore {
    find . -size +50M | cat >> .gitignore
}
function ipynb2py {
    jupyter nbconvert "$@" --to python
} 
function git_pretty_log {
    git log --format='%h (%ad) %s' --date=short
} 
function get_my_pids {
    ps aux | grep -E 'dju' | awk '{print $2, $9, $11, $12, $13}'
}
function watch_me { 
    watch "squeue -u $(whoami)"
}
function see_gpu {
    echo squeue -u $USER | tail -1| awk '{print $1}'
    srun -jobid=$jobid nvidia-smi
}


# Add this for slurm
function see_gpu_name(){
    sinfo -o "%30N %20m %50G"
}

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
function cpucount(){
    declare -a names
    list=()
    for x in $(squeue -p cpu -o "%u %t %C"); do
        list+=( "$x" )
        #echo $x
    done
    names=()
    cpus=()
    total=0
    for (( i=3; i<${#list[*]}; i+=3)); do
        existing=-1
        #echo "${list[i+1]}"
        if [ "${list[i+1]}" = "R" ]; then
            for (( j=0; j<${#names[*]}; j+=1)); do
                if [ "${list[i]}" = "${names[j]}" ]; then
                    existing=$j
                    break
                fi
            done

            total=$(( $total + ${list[$((i+2))]} ))
            if [ $existing -eq -1 ]; then
                names+=( "${list[i]}" )
                cpus+=( "${list[$((i+2))]}" )
            else
                cpus[$existing]=$((${cpus[$existing]}+${list[$((i+2))]}))
            fi
        fi
    done

    for (( i=0; i<${#names[*]}; i+=1 )); do
        printf '%20s  : %6s\n' "${names[i]}" "${cpus[i]}"
    done
    printf '%20s----%6s\n' "--------" "------"
    printf '%20s  : %6s\n' "total" "$total"
}

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
