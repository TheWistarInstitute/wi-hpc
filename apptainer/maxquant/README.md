# MaxQuant

- MaxQuant Home Page: https://www.maxquant.org/
- MaxQuant Container (hosted by quay.io): https://quay.io/repository/biocontainers/maxquant
- MaxQuant tags/versions (see below): https://quay.io/repository/biocontainers/maxquant?tab=tags

Please use apptainer to leverage the containerized version of maxquant.

```bash
# request resources
srun --pty --mem=10G /bin/bash

# load apptainer
module load apptainer

# pull maxquant image from quay.io, where <tag> is the specific version you want to use
# see https://quay.io/repository/biocontainers/maxquant?tab=tags
apptainer pull docker://quay.io/biocontainers/maxquant:<tag>

# execute container
apptainer exec maxquant.sif maxquant
```
