#!/bin/bash
#SBATCH --job-name=mpi_example
#SBATCH --partition=defq
#SBATCH --mem=1GB
#SBATCH --output=output.out
#SBATCH --error=error.err
#SBATCH --cpus-per-task=6
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=2

# load the mpich module
module load mpich/ge/gcc/64/

# Compile the C code into executable
mpicc -o hello_wistar hello_wistar.c

# 2*2*6=24
mpirun -np 24 ./hello_wistar

# or better yet use srun (don't need to specify # of cores)
srun --mpi=pmi2 ./hello_wistar

# Remove the executable
rm hello_wistar