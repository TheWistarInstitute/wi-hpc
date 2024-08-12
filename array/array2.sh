#!/bin/bash
#SBATCH --nodes=1 --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --array=1-5%2
#SBATCH --mem-per-cpu=50MB
#SBATCH --output=array_test_%A_%a.out
#SBATCH --error=array_test_%A_%a.error
#SBATCH -J btialg
#SBATCH --time=60:00:00


samplesheet=$PWD/InputFile2.txt


nm=`sed -n "$SLURM_ARRAY_TASK_ID"p $samplesheet |  awk '{print $1}'` 


python $PWD/testCode.py $nm 2 $PWD ${SLURM_ARRAY_TASK_ID}