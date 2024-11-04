#!/bin/bash
#SBATCH --job-name=diann               # create a short name for your job
#SBATCH --partition=defq                # shared partition (queue)
#SBATCH --nodes=1                       # node count
#SBATCH --ntasks=1                      # total number of tasks across all nodes
#SBATCH --cpus-per-task=1               # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem=3GB                       # total memory allocated for all tasks
#SBATCH --time=00:01:00                 # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin,end,fail      # send email when job begins,ends,fails
#SBATCH --mail-user=username@wistar.org # email to send alerts to
#SBATCH --output slurm.%N.%j.out        # Output file name and Location
#SBATCH --error slurm.%N.%j.err         # Error file name and Location

# Load the apptainer module
module load apptainer

# if the .sif file does not exist, build/pull it
if ! test -f diann.sif; then
    echo "Container does not exist...building"
    apptainer build diann.sif recipe.def
fi

# execute command within image
apptainer exec diann.sif diann-linux <options>

