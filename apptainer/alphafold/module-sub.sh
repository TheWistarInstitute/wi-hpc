!/bin/bash

# Requesting one gpu in the 'gpu' partition (required)
#SBATCH --gres=gpu:1
#SBATCH --partition=gpu

# Rest of standard config
#SBATCH --job-name=sample               # job name
#SBATCH --nodes=1                       # node count
#SBATCH --ntasks=2                      # total number of tasks across all nodes
#SBATCH --cpus-per-task=1               # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem=1GB                       # total memory allocated for all tasks
#SBATCH --time=00:01:00                 # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin,end,fail      # send email when job begins,ends,fails
#SBATCH --mail-user=username@wistar.org # email to send alerts to
#SBATCH --output slurm.%N.%j.out        # Output file name and Location
#SBATCH --error slurm.%N.%j.err         # Error file name and Location

# Load Required Modules
module load Python/3.10.4-GCCcore-11.3.0
module load AlphaFold/2.2.2-foss-2021a-CUDA-11.3.1

# Create output directory in /tmp (which is cleaned by slurm and mounted by apptainer)
output_dir = /tmp/output
mkdir -p $output_dir

# Check values of some environment variables
echo INFO: SLURM_GPUS_ON_NODE=$SLURM_GPUS_ON_NODE
echo INFO: SLURM_JOB_GPUS=$SLURM_JOB_GPUS
echo INFO: SLURM_STEP_GPUS=$SLURM_STEP_GPUS
echo INFO: ALPHAFOLD_DIR=$ALPHAFOLD_DIR
echo INFO: ALPHAFOLD_DATADIR=$ALPHAFOLD_DATADIR
echo INFO: TMP=$TMP
echo INFO: output_dir=$output_dir

### RUN PYTHON SCRIPT WITH ALPHAFOLD HERE

# Copy Alphafold output back to directory where "sbatch" command was issued.
mkdir $SLURM_SUBMIT_DIR/Output-$SLURM_JOB_ID
cp -R $output_dir $SLURM_SUBMIT_DIR/Output-$SLURM_JOB_ID
