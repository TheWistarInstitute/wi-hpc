# Workshop Demo

The following files and folders are from the Wistar Containers in HPC presentation that took place on Jan 3, 10, and 17 of 2024.

## Submission Script

The `sub.sh` file is used to schedule a job in the WI-HPC Cluster with specified resources. These resource values are subject to change depending on the application/process you are running. In this demo case, we are running simple python scripts, hence the low number of resources.

The first command `module load apptainer` is used to load the apptainer module so that we may use the apptainer application.

The if statement, is meant to build the container if it does not already exist. It is best practice to use this with every container, as if this was running under a job array, we do not want to build the container each at each job step.

The two `apptainer exec` commands are executing simple python scripts.

Where as the `apptainer run` command runs the default container command. See the `%runscript` section in `python_recipe.def`.

## Definition File


## Python Scripts

The `fibonacci.py` and `sums.py` are simple python programs to generate the nth term of the fibonacci sequence and add two numbers together respectively.

And the my_script.py pulled from github in the `python_recipe.def` file is the same as `fibonacci.py` where instead it asks for input.
