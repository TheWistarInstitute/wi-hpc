#!/bin/bash
#SBATCH --job-name=sample               # create a short name for your job
#SBATCH --partition=defq                # shared partition (queue)
#SBATCH --nodes=1                       # node count
#SBATCH --ntasks=2                      # total number of tasks across all nodes
#SBATCH --cpus-per-task=1               # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem=3GB                       # total memory allocated for all tasks
#SBATCH --time=00:01:00                 # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin,end,fail      # send email when job begins,ends,fails
#SBATCH --mail-user=username@wistar.org # email to send alerts to
#SBATCH --output slurm.%N.%j.out        # Output file name and Location
#SBATCH --error slurm.%N.%j.err         # Error file name and Location

# Load the apptainer module
module load apptainer

# Build Image (suggested)
# able to use a definition file (container.def)
# to make changes to the container (cannot when pulled)
# if the .sif file does not exist, build it
# to be used with job arrays, so container is not rebuilt each time
if ! test -f container.sif; then
  echo "Container does not exist...building"
  apptainer build container.sif recipe.def
fi

# or Pull Image (verified only)
# apptainer pull docker://<image>


# execute command within image
apptainer exec container.sif <command>
