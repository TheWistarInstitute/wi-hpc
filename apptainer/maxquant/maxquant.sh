#!/bin/bash
#SBATCH --job-name=maxquant
#SBATCH --mem=100G
#SBATCH --ntasks=1

### UPDATE THIS NUMBER TO MATCH THE <numThreads> IN mqpar.xml
#SBATCH --cpus-per-task=4

#SBATCH --time=03:00:00
#SBATCH --mail-user=aharral@wistar.org
#SBATCH --mail-type=ALL
#SBATCH --output=slurm_%N_%j.out
#SBATCH --error=slurm_%N_%j.err

module load apptainer

# Use this to ensure you do not pull an already existing container
# UPDATE THIS .sif FILE NAME IF YOU WANT TO CHANGE IT (optional)
if ! test -f maxquant.sif; then
    echo "Container does not exist...building"
    apptainer build --bind=/applications/maxquant/:/apps/ maxquant.sif maxquant.def
    echo "Container maxquant.sif was build successfully"
else
    echo "Container already exists...deleting and building again"
    rm maxquant.sif
    apptainer build --bind=/applications/maxquant/:/apps/ maxquant.sif maxquant.def
    echo "Container maxquant.sif was build successfully"
fi

# Run MaxQuant
apptainer run --bind=/wistar/:/mnt/ --writable-tmpfs maxquant.sif

# Clean up apptainer
apptainer cache clean --force
