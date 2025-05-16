#!/bin/bash
#SBATCH --job-name=jupyter              # create a short name for your job
#SBATCH --partition=defq                # shared partition (queue)
#SBATCH --nodes=1                       # node count
#SBATCH --ntasks=1                      # total number of tasks across all nodes
#SBATCH --cpus-per-task=1               # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem=10GB                       # total memory allocated for all tasks
#SBATCH --time=00:05:00                 # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin,end,fail      # send email when job begins,ends,fails
#SBATCH --mail-user=username@wistar.org # email to send alerts to
#SBATCH --output slurm-%j.out        # Output file name and Location
#SBATCH --error slurm-%j.err         # Error file name and Location

# generate a random port
PORT=$(shuf -i 6000-9999 -n 1)

# define container name
IMAGE=scipy-notebook:latest
CONTAINER=scipy-notebook_latest.sif

# load apptainer module
module load apptainer

# if the .sif file does not exist, pull it
if ! test -f $IMAGE; then
  echo "Image does not exist...pulling"
  apptainer pull docker://jupyter/$IMAGE
fi

# forward port to head node
apptainer exec $CONTAINER /usr/bin/ssh -N -f -R $PORT:localhost:$PORT wi-hpc

# start the notebook
apptainer exec $CONTAINER jupyter-notebook --no-browser --port=$PORT

echo "run the following on your local machine:
ssh -N -L $PORT:localhost:$PORT wi-hpc
and then access the web ui through the link provided that starting with http://127.0.0.1"
