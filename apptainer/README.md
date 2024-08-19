# Apptainer

[Apptainer](https://apptainer.org/) is a container software similar to [Docker](https://www.docker.com/) that is specifically designed for use in HPC enviornments.

Please see https://hpc.apps.wistar.org/apptainer/ for more information on the usage of container in the WI-HPC cluster.

Each folder will container a definition file (`.def`) that is used to build a container with the `apptainer build` command.

***PLEASE NOTE***: You must request resources before using apptainer. Please see examples below:


## Interactive Job

```bash
srun --pty --mem=30G --ntasks=1 --cpus-per-task=1 --time=01:00:00 /bin/bash
module load apptainer
apptainer <command>
```

## Scheduled Job

```bash
#SBATCH --job-name=example
#SBATCH --mem=30G
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=1
#SBATCH --time=01:00:00

module load apptainer

# Use this to ensure you do not pull an already existing container
if ! test -f example.sif; then
  echo "Container does not exist...pulling"
  apptainer pull docker://example:latest example.sif
fi
```
