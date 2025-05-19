# Dock

[Dock6 Manual](https://dock.compbio.ucsf.edu/DOCK_6/dock6_manual.htm#introduction)

## Requirements

This `recipe.def` file must exist in the dock6 directory. You must unpack the dock6-latest.tgz file with `tar -xzf dock6-latest.tgz` first.


To build this container, use the `apptainer build` command

```bash
tar -xzf dock6-latest.tgz
cd dock6/
module load apptainer
apptainer build dock6.sif recipe.def
``` 
