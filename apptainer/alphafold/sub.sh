# This is the container version of Alphafold

#!/bin/bash
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
module load apptainer

# if the .sif file does not exist, build it
if ! test -f alphafold.sif; then
  echo "Container does not exist...building"
  apptainer build alphafold.sif alphafold.def
fi

apptainer run -nv --bind=path/to/data:path/to/mount alphafold.sif \
  --fasta_paths=path/to/fasta \
  --data_dir=path/to/data \
  --output_dir=path/to/output \
  --model_preset=monomer \
  --max_template_date=YYYY-MM-DD \
  --gpu_devices=0   # uses first GPU allocated [0,1,2,3]
