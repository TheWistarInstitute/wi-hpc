# This is the module version, please checkout the apptainer version at apptainer/alphafold folder

#!/bin/bash
# Requesting one gpu in the 'gpu' partition (required)
#SBATCH --gres=gpu:1
#SBATCH --partition=gpu

# Rest of standard config
#SBATCH --job-name=example               # job name
#SBATCH --nodes=1                       # node count
#SBATCH --ntasks=2                      # total number of tasks across all nodes
#SBATCH --cpus-per-task=1               # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem=1GB                       # total memory allocated for all tasks
#SBATCH --time=00:01:00                 # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin,end,fail      # send email when job begins,ends,fails
#SBATCH --mail-user=username@wistar.org # email to send alerts to
#SBATCH --output slurm.%N.%j.out        # Output file name and Location
#SBATCH --error slurm.%N.%j.err         # Error file name and Location

# Load the necessary modules
module load CUDA/11.3.1                     # Load the correct CUDA version
module load AlphaFold/2.2.2-foss-2021a-CUDA-11.3.1 # Load the AlphaFold module
module load Anaconda3/2022.05             # Load the correct conda environment

# Activate the appropriate environment
conda activate path/to/alphafold_env       # Adjust path to your virtual environment

# Set AlphaFold paths and run the software with a .fasta input
DATA_DIR=/resources/AlphaFoldDB/
FASTA_PATH=path/to/example.fasta        # Path to your .fasta input file
OUTPUT_DIR=path/to/output               # Path to store results

# Run AlphaFold job
python alphafold \
  --fasta_paths=$FASTA_PATH \
  --data_dir=$DATA_DIR \
  --output_dir=$OUTPUT_DIR \
  --model_preset=monomer \
  --max_template_date=2024-10-21 \
  --gpu_devices=0

# Deactivate environment after the job
deactivate
