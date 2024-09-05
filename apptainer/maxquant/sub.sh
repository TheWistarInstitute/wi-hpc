#!/bin/bash

#SBATCH --job-name=maxquant-container-test
#SBATCH --time=02:00:00
#SBATCH --mail-type=begin,end,fail      # send email when job begins,ends,fails
#SBATCH --mail-user=aharral@wistar.org # email to send alerts to
#SBATCH --output=$SLURM_SUBMIT_DIR/slurm-%j-%N.out
#SBATCH --error=$SLURM_SUBMIT_DIR/slurm-%j-%N.err
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --nodes=1
#SBATCH --mem=10G

module load apptainer


if ! test -f maxquant.sif; then
  echo "Container does not exist...building"
  apptainer build maxquant.sif maxquant.def
fi

apptainer run maxquant.sif
