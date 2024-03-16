#!/bin/sh                                                                       

#SBATCH --job-name=index
#SBATCH --partition gpu
#SBATCH --gres=gpu:1
#SBATCH --nodes=1
#SBATCH --array=1-4%4
#SBATCH --mem=10G                                                           
#SBATCH --time=05:00:00
#SBATCH --output=%x-%j.out

# [NOTE] Please indicate one gpu per node in this case. 
# [NOTE] The array argument would clone n parallel task with new subnode.

# Set-up the environment.
source ${HOME}/.bashrc
conda activate exa-dm_env

# Start the experiment.
cd examine-domain-mismatch
HPARAMS_FILE=${HOME}/examine-domain-mismatch/myHyperparameters.txt

python encode/dense.py input \
    --corpus /home/dju/datasets/msmarco/collection \
    --fields text \
    $(head -$SLURM_ARRAY_TASK_ID $HPARAMS_FILE | tail -1) output \
    --embeddings /home/dju/indexes/msmarco-contriever.faiss \
    --to-faiss encoder \
    --encoder-class contriever \
    --encoder facebook/contriever \
    --fields text \
    --batch 32 \
    --max-length 256 \
    --device cuda 
