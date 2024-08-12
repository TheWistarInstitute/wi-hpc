# Job Parallelization

Running in parallel in the WI-HPC cluster can be achieved in multiple ways. This is ideal when wanting to run several **independent** jobs.

Please note that in order to run multiple independent jobs, you **must** request more than one task, i.e `--ntasks=3`.

## Method 1

The first example, `sub1.sh` requests 3 tasks and runs 3 independent `srun` commands. In the `srun` commands we assign 1 task to each command for a total of 3 tasks.

Please note the `&` at the each of end line. This `AND` operator allows all 3 commands to start at the same time.

Using the `&&` operator will wait until the first command to execute. If and only if it is successful, the second command will then start.

```bash
#!/bin/bash
# Parallel Job Example

# standard job submission options
#SBATCH --job-name=parallel             # create a short name for your job
#SBATCH --mail-type=begin,end,fail      # send email when job begins,ends,fails
#SBATCH --mail-user=username@wistar.org # email to send alerts to
#SBATCH --output slurm.%N.%j.out        # Output file name and Location
#SBATCH --error slurm.%N.%j.err         # Error file name and Location

# parallelization dependent options
#SBATCH --time=01:00:00                 # total run time limit (HH:MM:SS)
#SBATCH --partition=defq                # shared partition (queue)
#SBATCH --ntasks=3                      # total number of tasks across all nodes
#SBATCH --cpus-per-task=1               # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=1GB               # total memory allocated for all tasks

module load Python/3.10.4-GCCcore-11.3.0

srun --ntasks=$SLURM_NTASKS python fibonacci.py 10 >> 10.out &
srun --ntasks=$SLURM_NTASKS python fibonacci.py 20 >> 20.out &
srun --ntasks=$SLURM_NTASKS python fibonacci.py 30 >> 30.out &
wait
```

## Method 2 (Preferred)

The second example, `sub2.sh` uses and array to submit the job multiple times (without having to add additional `srun` commands).

This is the preferred method as simple adding new lines to the input.txt file and increasing the array size and step will work. Whereas, in **Method 1** you would need to add many more `srun` commands and manually specify each input and output value.

This methods also uses the `sed` and `awk` commands.
- `sed`: uses the current sub job ID to iterate through the lines of `input2.txt` and return the row's value.
- `awk`: returns the specified column value (`$1` is the first column and `$2` is the second column).

```bash
#!/bin/bash
# Parallel Job Example

# standard job submission options
#SBATCH --job-name=parallel             # create a short name for your job
#SBATCH --mail-type=begin,end,fail      # send email when job begins,ends,fails
#SBATCH --mail-user=username@wistar.org # email to send alerts to
#SBATCH --output slurm.%N.%j.out        # Output file name and Location
#SBATCH --error slurm.%N.%j.err         # Error file name and Location

# parallelization dependent options
#SBATCH --time=01:00:00                 # total run time limit (HH:MM:SS)
#SBATCH --partition=defq                # shared partition (queue)
#SBATCH --ntasks=3                      # total number of tasks across all nodes
#SBATCH --cpus-per-task=1               # cpu-cores per task (>1 if multi-threaded tasks)
#SBATCH --mem-per-cpu=1GB               # total memory allocated for all tasks
#SBATCH --array=1-12%3                  # job array from 1 - 12 with step 3 (3 sub jobs at a time)

module load Python/3.10.4-GCCcore-11.3.0

input=`sed -n "$SLURM_ARRAY_TASK_ID"p input.txt |  awk '{print $1}'`
output=`sed -n "$SLURM_ARRAY_TASK_ID"p input.txt |  awk '{print $2}'`

python fibonacci.py $input >> $output
```

If our input.txt file looks like:
```
10  10.out
20  20.out
30  30.out
40  10.out
50  20.out
60  30.out
70  10.out
80  20.out
90  30.out
100 10.out
110 110.out
120 120.out
```

The first iteration (i.e. $SLURM_ARRAY_TASK_ID = 1), the input and output variables are evaluated to:
```bash
input=10
output=10.out
```

And the fifth iteration (i.e. $SLURM_ARRAY_TASK_ID = 5), the input and output variables are evaluated to:
```bash
input=50
output=50.out
```

And so fourth.

This array runs a total of 12 sub jobs, 3 at a time. (`#SBATCH --array=1-12%3`)

Please note, as soon as 1 sub jobs completes, the next one starts. In other words, if 1, 2, and 3 all start at the same time, then 1 completes, 4 will then start (even if 2 and 3 are still running).

