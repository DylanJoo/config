#!/bin/sh
# The following lines instruct Slurm 
#SBATCH --job-name=analysis
#SBATCH --cpus-per-task=32
#SBATCH --nodes=2
#SBATCH --mem=30G
#SBATCH --ntasks-per-node=1
#SBATCH --time=03:00:00
#SBATCH --output=%x-%j.out

# Set-up the environment.
source ${HOME}/.bashrc
conda activate exa-dm_env

# Start the experiment.
cd examine-domain-mismatch
bash analyze_corpus_idf.sh
# bash analyze_corpus.sh
