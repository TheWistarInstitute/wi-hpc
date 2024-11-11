#!/bin/bash
#SBATCH --nodes=1 --ntasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --mem-per-cpu=5MB
#SBATCH --output=main_%A_%a.out
#SBATCH --error=main_%A_%a.error
#SBATCH -J mn
#SBATCH --time=60:00:00

FIRST=$(sbatch --parsable array1.sh)
SECOND=$(sbatch  --parsable  --dependency=afterok:$FIRST array2.sh)
THIRD=$(sbatch  --parsable  --dependency=afterok:$SECOND array3.sh)


