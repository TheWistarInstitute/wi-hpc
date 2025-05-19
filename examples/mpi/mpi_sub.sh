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
mpicc -o hello_wistar2 hello_wistar2.c

#mpirun -n 20 ./$EXEC
srun --mpi=pmi2 ./hello_wistar
srun --mpi=pmi2 ./hello_wistar2

# Remove the executable
rm hello_wistar
rm hello_wistar2