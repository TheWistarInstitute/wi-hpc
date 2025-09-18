#!/usr/bin/env bash
#SBATCH --job-name=bundle         # Name of job
#SBATCH --cpus-per-task=20        # Prioritize CPUs (pigz)
#SBATCH --mem=10G                 # General memory utilization
#SBATCH --time=3-00:00:00         # Give more time than needed
#SBATCH --output=%x_%j.out        # STDOUT file
#SBATCH --error=%x_%j.err         # STDERR file
#SBATCH --array=1-3%1             # Array size and step; use `cat input.txt | wc -l` to get number of folders; step is how many to run at a time

# Load modules
module load wi-bundler

# Generate Vars
input=`sed -n "$SLURM_ARRAY_TASK_ID"p input.txt |  awk '{print $1}'` # Gets nth line of input.txt (depending on array iteration)
output=/wistar/lab/path/to/output/$(basename $input)                 # Sets the output folder

# Run the bundle tool
unbundle --source_dir $input --output_dir $output --yes
