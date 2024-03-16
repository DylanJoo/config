#!/bin/sh
# The following lines instruct Slurm to allocate one GPU.
#SBATCH --job-name=dr
#SBATCH --partition gpu
#SBATCH --gres=gpu:maxwell:1
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --time=10:00:00
#SBATCH --output=%x-%j.out
#SBATCH --mem=20gb

# Set-up the environment.
source ${HOME}/.bashrc
conda activate exa-dm_env

# Start the experiment.
cd examine-domain-mismatch

# bash run_beir_dr.sh
# bash run_lotte_dr.sh
bash run_msmarco.sh
