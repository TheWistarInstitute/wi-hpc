# Amber24

[Amber](https://ambermd.org/index.php) is a suite of biomolecular simulation programs.

The `amber.def` file is a definition file based on the latest ubuntu image from [Docker Hub](https://hub.docker.com).

## Requirements

- Amber24 and AmberTools24 .tar.bz2 packages downloaded (and saved in accessible path)
- Resources requested through Slurm (via `srun` or `sbatch`)
- Apptainer module loaded (`module load apptainer`)

## Usage

To build and run the amber24 container, first request resources on the WI-HPC cluster.

***NOTE***: You MUST place the `Amber24.tar.bz2` and `AmberTools24.tar.bz2` in your lab share. For example,

```bash
/wistar/testlab/username/software/Amber24.tar.bz2
/wistar/testlab/username/software/AmberTools24.tar.bz2


# Bind /wistar/testlab to container's /mnt directory
apptainer build --bind=/wistar/testlab:/mnt/ amber.sif amber.def

# In definition file, set the $ARCHIVE_DIR to:
ARCHIVE_DIR=/mnt/aharral/software

# These archives then are copied to the working/installation directory /opt/
```

### Interactive Job
```bash
[username@wi-hpc-hn1 ~]$ srun --pty --mem=10G --ntasks=1 --cpus-per-task=1 --time=02:00:00 /bin/bash
[username@node040 ~]$ module load apptainer
[username@node040 ~]$ apptainer build --bind=/wistar/testlab:/mnt/ amber.sif amber.def
...
...
...
[username@node040 ~]$ apptainer exec amber.sif pdb4amber -h

    usage: pdb4amber [-h] [-i FILE] [-o FILE] [-y] [-d] [-s STRIP_ATOM_MASK] [-m MUTATION_STRING] [-p] [-a] [--constantph] [--most-populous] [--keep-altlocs] [--reduce] [--no-reduce-db] [--pdbid] [--add-missing-atoms] [--model MODEL] [-l FILE] [-v] [--leap-template] [--no-conect] [--noter] [input]

    positional arguments:
      input                 PDB input file (default: stdin)

    options:
      -h, --help            show this help message and exit
      -i FILE, --in FILE    PDB input file (default: stdin)
      -o FILE, --out FILE   PDB output file (default: stdout)
      -y, --nohyd           remove all hydrogen atoms (default: no)
      -d, --dry             remove all water molecules (default: no)
      -s STRIP_ATOM_MASK, --strip STRIP_ATOM_MASK
                            Strip given atom mask, (default: no)
      -m MUTATION_STRING, --mutate MUTATION_STRING
                            Mutate residue
      -p, --prot            keep only protein residues (default: no)
      -a, --amber-compatible-residues
                            keep only Amber-compatible residues (default: no)
      --constantph          rename GLU,ASP,HIS for constant pH simulation
      --most-populous       keep most populous alt. conf. (default is to keep 'A')
      --keep-altlocs        Keep alternative conformations
      --reduce              Run Reduce first to add hydrogens. (default: no)
      --no-reduce-db        If reduce is on, skip using it for hetatoms. (default: usual reduce behavior for hetatoms)
      --pdbid               fetch structure with given pdbid, should combined with -i option. Subjected to change
      --add-missing-atoms   Use tleap to add missing atoms. (EXPERIMENTAL OPTION)
      --model MODEL         Model to use from a multi-model pdb file (integer). (default: use 1st model). Use a negative number to keep all models
      -l FILE, --logfile FILE
                            log filename
      -v, --version         version
      --leap-template       write a leap template for easy adaption (EXPERIMENTAL)
      --no-conect           do Not write S-S CONECT records
      --noter               do Not write TER records
```

### Scheduled Job

```bash
#!/bin/bash
#SBATCH --job-name=amber              # create a short name for your job
#SBATCH --partition=defq                # shared partition (queue)
#SBATCH --nodes=1                       # node count
#SBATCH --ntasks=1                      # total number of tasks across all nodes
#SBATCH --cpus-per-task=1               # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem=10GB                       # total memory allocated for all tasks
#SBATCH --time=02:00:00                 # total run time limit (HH:MM:SS)
#SBATCH --mail-type=begin,end,fail      # send email when job begins,ends,fails
#SBATCH --mail-user=username@wistar.org # email to send alerts to
#SBATCH --output slurm.%N.%j.out        # Output file name and Location
#SBATCH --error slurm.%N.%j.err         # Error file name and Location

# Load the module
module load apptainer

# if the .sif file does not exist, build it
if ! test -f amber.sif; then
  echo "Container does not exist...building"
  apptainer build --bind=/wistar/testlab/:/mnt/ amber.sif amber.def
fi

apptainer exec amber.sif pdb4amber -h
```
