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

# Use this to ensure you do not pull an already existing container
if ! test -f maxquant.sif; then
        echo "Container does not exist...building"
        apptainer build --bind=/wistar/it:/mnt/ maxquant.sif maxquant.def
        echo "Container maxquant.sif was build successfully"
fi

# Run MaxQuant
apptainer run --writable-tmpfs maxquant.sif

# Copy out data
apptainer exec --bind=/wistar/it:/mnt cp -r /opt/data /mnt/aharral/out_data

# Clean up
apptainer cache clean
