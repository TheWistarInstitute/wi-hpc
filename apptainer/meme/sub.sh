#!/bin/bash
#SBATCH --job-name=meme_analysis
#SBATCH --output=meme_analysis.out
#SBATCH --error=meme_analysis.err
#SBATCH --mem=30G
#SBATCH --cpus-per-task=4
#SBATCH --nodes=4
#SBATCH --time=01:00:00

# Load modules
module load apptainer
module load OpenMPI

# if the .sif file does not exist, build it
# to be used with job arrays, so container is not rebuilt each time
# MAKE SURE meme.def IS IN YOUR CWD
if ! test -f meme.sif; then
  echo "Container does not exist...building"
  apptainer build meme.sif meme.def
fi

# execute the container
apptainer exec meme.sif mpirun -np 2 meme -h
