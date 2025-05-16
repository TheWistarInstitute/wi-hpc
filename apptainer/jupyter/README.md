# Jupyter Notebook

Running a jupyter notebook in the WI-HPC cluster requires [Apptainer](https://hpc.apps.wistar.org/apptainer) and [SSH Tunneling](https://www.ssh.com/academy/ssh/tunneling).

This process is best done through an interactive `srun` session as you will be required to input your password (same one you use to login to the HPC cluster with).

1. Login to `wi-hpc` and start an interactive session, where the `--options` will be your requested resources. See [Key Slurm Flags](https://apps.wistar.org/scheduling/#key-slurm-flags) for a list of all available options.

```bash
ssh wi-hpc
srun --pty --options /bin/bash
```

2. Load the Apptainer module and pull down the image you would like to use from [Docker Hub](https://hub.docker.com). See the [Jupyter Project](https://hub.docker.com/u/jupyter) for a full list of all the available types of Jupyter notebooks.

```bash
module load apptainer
apptainer pull docker://jupyter/scipy-notebook:latest
```

3. Set up a port to use, for this example we will use 8888. However, only ONE notebook can run on a single port at a time. The better way to to do this is to choose a port at random.

```bash
PORT=8888
# or select at random with =$(shuf -i 8888-9999 -n 1)
```

4. Execute the command to setup the SSH tunnel from the container back to the HPC cluster

```bash
apptainer exec scipy-notebook_latest.sif /usr/bin/ssh -N -f -R $PORT:localhost:$PORT wi-hpc
```

5. Start up the notebook in the container over the specified port.

> [!IMPORTANT]
> COPY OF THE URL STARTING WITH http://127.0.0.1 (also known as localhost)

```bash
apptainer exec scipy-notebook_latest.sif jupyter-notebook --no-browser --port=$PORT
```

6. Finally, setup the SSH tunnel from your laptop/desktop to the HPC cluster. Make sure to set the port number same as before.

```bash
$PORT=8888
ssh -N -L $PORT:localhost:$PORT wi-hpc
```

7. Open your preferred browser (Chrome, Firefox, or Edge) and paste in the URL you copied earlier. You are now logged into the Jupyter Notebook!
