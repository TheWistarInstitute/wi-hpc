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

Or for the newest version, please build you own container

***NOTE***: You will need to provide the --bind option when using the ```apptainer build```

```bash
Bootstrap: docker
From: ubuntu:20.04

%post

  # update and upgrade
  apt -y update && apt -y upgrade

  # install dependices
  apt -y install wget dpkg unzip

  # install maxquant
  wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
  dpkg -i packages-microsoft-prod.deb
  apt-get update; \
  apt-get install -y apt-transport-https && \
  apt-get update && \
  apt-get install -y dotnet-sdk-8.0

  # copy over archive
  cp /mnt/aharral/software/MaxQuant_v2.6.3.0.zip /opt/

  # unpack
  cd /opt/
  unzip MaxQuant_v2.6.3.0
  rm MaxQuant_v2.6.3.0.zip


  alias maxquant='dotnet MaxQuant_v2.6.3.0/bin/MaxQuantCmd.dll'

  maxquant --create mqpar.xml
  maxquant mqpar.xml --changeFolder new_mqpar.xml /mnt/aharral/data/fasta /mnt/aharral/data/raw

%runscript

  cd /opt/
  alias maxquant='dotnet MaxQuant_v2.6.3.0/bin/MaxQuantCmd.dll'
  maxquant new_mqpar.xml

```
