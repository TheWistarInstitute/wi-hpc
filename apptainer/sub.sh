#!/bin/bash
#SBATCH --job-name=sample
#SBATCH --mem=3GB

module load apptainer

# if the .sif file does not exist, build/pull it
if ! test -f container.sif; then
    apptainer pull docker://image               # pull image from registry
    apptainer build container.sif recipe.def    # OR build on definition file
fi

# execute command within image
apptainer exec container.sif commmand --args

# or run the container with default run command ()
apptainer run container.sif --args

# remove the container image once done
rm -f /path/to/sif
