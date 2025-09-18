#!/usr/bin/env bash
#SBATCH --job-name=rstudio
#SBATCH --cpus-per-task=4
#SBATCH --mem=30G
#SBATCH --time=5:00:00
#SBATCH --mail-user=username@wistar.org
#SBATCH --mail-type=ALL
#SBATCH --output=output.out
#SBATCH --error=error.err

# Load modules
module load apptainer

# Create temporary directory to be populated with directories to bind-mount in the container
# where writable file systems are necessary. Adjust path as appropriate for your computing environment.
workdir=$(mktemp -d)

# Set R_LIBS_USER to an existing path specific to rocker/rstudio to avoid conflicts with
# personal libraries from any R installation in the host environment
cat > ${workdir}/rsession.sh <<"END"
#!/bin/sh
export R_LIBS_USER=${HOME}/R/rocker-rstudio/4.5.1
mkdir -p "${R_LIBS_USER}"
## custom Rprofile & Renviron (default is $HOME/.Rprofile and $HOME/.Renviron)
# export R_PROFILE_USER=/path/to/Rprofile
# export R_ENVIRON_USER=/path/to/Renviron
exec /usr/lib/rstudio-server/bin/rsession "${@}"
END

chmod +x ${workdir}/rsession.sh

export APPTAINER_BIND="${workdir}/rsession.sh:/etc/rstudio/rsession.sh"

# Do not suspend idle sessions.
# Alternative to setting session-timeout-minutes=0 in /etc/rstudio/rsession.conf
# https://github.com/rstudio/rstudio/blob/v1.4.1106/src/cpp/server/ServerSessionManager.cpp#L126
export APPTAINERENV_RSTUDIO_SESSION_TIMEOUT=0

export APPTAINERENV_USER=$(id -un)
export APPTAINERENV_PASSWORD=$(openssl rand -base64 15)
# get unused socket per https://unix.stackexchange.com/a/132524
# tiny race condition between the python & singularity commands
readonly PORT=$(python3 -c 'import socket; s=socket.socket(); s.bind(("", 0)); print(s.getsockname()[1]); s.close()')
cat 1>&2 <<END
1. SSH tunnel from your workstation using the following command:

   ssh -N -L 8787:${HOSTNAME}:${PORT} ${APPTAINERENV_USER}@LOGIN-HOST

   and point your web browser to http://localhost:8787

2. log in to RStudio Server using the following credentials:

   user: ${APPTAINERENV_USER}
   password: ${APPTAINERENV_PASSWORD}

When done using RStudio Server, terminate the job by:

1. Exit the RStudio Session ("power" button in the top right corner of the RStudio window)
2. Issue the following command on the login node:

      scancel -f ${SLURM_JOB_ID}
END

apptainer exec --cleanenv \
                 --scratch /run,/tmp,/var/lib/rstudio-server \
                 --workdir ${workdir} \
                 rstudio_latest.sif \
    rserver --www-port ${PORT} \
            --auth-none=0 \
            --auth-pam-helper-path=pam-helper \
            --auth-stay-signed-in-days=30 \
            --auth-timeout-minutes=0 \
            --server-user=$(whoami) \
            --rsession-path=/etc/rstudio/rsession.sh
printf 'rserver exited' 1>&2
