#!/bin/bash
# Parallel Job Example

# standard job submission options
#SBATCH --job-name=parallel             # create a short name for your job
#SBATCH --mail-type=begin,end,fail      # send email when job begins,ends,fails
#SBATCH --mail-user=username@wistar.org # email to send alerts to
#SBATCH --output slurm.%N.%j.out        # Output file name and Location
#SBATCH --error slurm.%N.%j.err         # Error file name and Location

# parallelization dependent options
#SBATCH --time=01:00:00                 # total run time limit (HH:MM:SS)
#SBATCH --partition=defq                # shared partition (queue)
#SBATCH --ntasks=3                      # total number of tasks across all nodes
#SBATCH --cpus-per-task=1               # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=1GB               # total memory allocated for all tasks

module load Python/3.10.4-GCCcore-11.3.0

srun --ntasks=$SLURM_NTASKS python fibonacci.py 10 >> 10.out &
srun --ntasks=$SLURM_NTASKS python fibonacci.py 20 >> 20.out &
srun --ntasks=$SLURM_NTASKS python fibonacci.py 30 >> 30.out &
wait
