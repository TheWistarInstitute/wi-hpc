#!/bin/bash
#SBATCH --job-name=maxquant
#SBATCH --mem=100G
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --time=01:00:00
#SBATCH --mail-user=aharral@wistar.org
#SBATCH --mail-type=ALL
#SBATCH --output=slurm_%N_%j.out
#SBATCH --error=slurm_%N_%j.err

module load apptainer

export OUT_PATH="it/aharral/maxquant_out_data"

# Use this to ensure you do not pull an already existing container
if ! test -f maxquant.sif; then
    echo "Container does not exist...building"
    apptainer build --bind=/wistar/:/mnt/ maxquant.sif maxquant.def
    echo "Container maxquant.sif was build successfully"
else
    echo "Container already exists, please delete it and run again."
    exit 0 # exit if container exists
fi

# Run MaxQuant
apptainer run --writable-tmpfs maxquant.sif

# Copy out data
apptainer --bind=/wistar/:/mnt/ exec cp -r /opt/data /mnt/$OUT_PATH

# Clean up
apptainer cache clean --force
