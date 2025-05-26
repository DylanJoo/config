# Symbolic link due to disk quota (mkdir first)
```
ln -s /project/project_465001339/datasets ~/datasets
ln -s /project/project_465001339/huggingface ~/.cache/huggingface
ln -s /project/project_465001339/singularity ~/.singularity
```

# Search for the eligidible docker (e.g. dockerHub, AMD Infinity Hub)
```
https://www.amd.com/en/developer/resources/infinity-hub.html
```

# Pull the docker using singularity
# [NOTE] since the image might larger than disk quota. Specify the path for saving image file or run the command on other directory.
```
singularity pull docker:<name_tag> 
# e.g. name_tag=rocm/vllm:rocm6.2_mi300_ubuntu22.04_py3.9_vllm_7c5fd50 --> but this only support MI300
# rocm-vllm_ubuntu20.04_rocm6.1.2_py3.9_vllm0.5.5.sif --> llama 3 is OK/ llama 3.1 is no go
# rocm-vllm_ubuntu22.04_rocm6.2_py3.10_torch2.3.0_vllm0.5.5.sif (this one is more stable)) --> llama3.1-8B is OK. llam3.1-70B you can only build vllm-server and inference
```

# Build with cotainr
```
module load CrayEnv
module load cotainr
```

# Start a vllm server and run from the node
```
sbatch script/server_api.sh (as follow)
singularity exec --bind /scratch/project_465001339 ${IMAGE} <command>
# [NOTE] remember to log jobid
# run the requesting codes
srun --jobid=${jobid} -o ${jobid}.out -e ${jobid}.errr bash scripts/server/generate_x.sh &
```

# Run
# [NOTE] See if gitlfs has been installed and Download the model from HF
# [NOTE] You have to call -B/--bind to attach file systems other than HOME
# [NOTE] You can use singularity shell <container.sif> to install in a normal way 
# (so it might be a portable docker)
#
