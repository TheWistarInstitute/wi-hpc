#!/bin/bash
#SBATCH --job-name=sample               # job name
#SBATCH --nodes=1                       # node count
#SBATCH --ntasks=2                      # total number of tasks across all nodes
#SBATCH --cpus-per-task=1               # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem=1G                        # total memory allocated for all tasks
#SBATCH --mem-per-cpu=1G                # allocate memory based on # of cpus
#SBATCH --gres=gpu:1                    # REQUIRED - # of GPUs to use
#SBATCH --partition=gpu                 # REQUIRED - gpu partition
#SBATCH --time=00:01:00                 # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin,end,fail      # send email when job begins,ends,fails
#SBATCH --mail-user=username@wistar.org # email to send alerts to
#SBATCH --output slurm.%N.%j.out        # Output file name and Location
#SBATCH --error slurm.%N.%j.err         # Error file name and Location

echo "Hello Wistar! Printing out GPU devices:"
nvidia-smi
