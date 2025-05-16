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
port=$(shuf -i 6000-9999 -n 1)

# define container name
container=base-notebook:latest

# load apptainer module
module load apptainer

# if the .sif file does not exist, pull it
if ! test -f $container; then
  echo "Container does not exist...pulling"
  apptainer pull docker://jupyter/$container
fi

# forward port to head node
apptainer exec $container /usr/bin/ssh -N -f -R $port:localhost:$port wi-hpc

# start the notebook
apptainer exec $container jupyter-notebook --no-browser --port=$port

echo "run the following on your local machine:
ssh -N -L 9999:localhost:9999 wi-hpc
and then access the web ui through the link provided that starting with http://127.0.0.1"
