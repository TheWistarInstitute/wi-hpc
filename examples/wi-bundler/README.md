# Bundle and Unbundle Examples

For all information relating to archiving and bundling, please see [https://hpc.apps.wistar/archive](https://hpc.apps.wistar/archive).

## Bundle

To prepare data for archiving, one must first "bundle" their data into one or more `.tar.gz` files. This is required due to AWS storage class requirements, storage server limitations, and archiving best practices.

1. Files must be at least 128KB or larger, otherwise, you will be charged for 128KB. In other words, if pushing a 1KB file to an S3 bucket, it will be seen and charged as 128KB. Even though this cost is negiable for one file, if you have millions of files the cost grows very quickly.
2. Our NAS (**N**twork **A**ttached **S**torage) has a file size limit of 4TB. If you attempt to pack a 10TB dataset into a single `.tar.gz`, it will stop at 4TB, rendering the `.tar.gz` incomplete. This script provides an easily solution to this by using the `split` command to split `.tar.gz` files into 3TB **chunks** (1TB buffer).
3. Finally, this script provides detailed `tree` output and `sha256sum`s on your data to provide you with details about your archived data.

### How To Run

First, there is a `input.txt` file in where you will put the **full path** of all the directories, datasets, or projects you wish to bundle. 

```bash
/wistar/lab/path/to/data1
/wistar/lab/path/to/data2
/wistar/lab/path/to/data3
```

Next, there is a `bundle.sh` script that utilizes [Slurm Job Arrays](https://slurm.schedmd.com/job_array.html) to run multiple jobs in succession. The main idea here is to use the `$SLURM_ARRAY_TASK_ID` environment to grab the nth line from the `input.txt` file. For example, on the first iteration the script will bundle `/wistar/lab/path/to/data1`; the second interation will bundle `/wistar/lab/path/to/data2`; and so forth. This way, you can just run `sbatch bundle.sh` and let it run until all directories have been bundled.

> [!IMPORTANT]
> The `input.txt` file and `bundle.sh` file **must exist in the same directory**; Otherwise, you will need to provide the full path in the `..."$SLURM_ARRAY_TASK_ID"p path/to/input.txt...` line.

> [!IMPORTANT]
> Using an `sbatch` script with the `bundle` tool requires the `-y/--yes` flag to ensure auto-accepting of confirmations. Otherwise, the job will fail. 


### Unbundle

Once you have received the `.tar.gz` files back from archive (via ticket), you will need to "unbundle" the data back to its original folder structure. The `unbundle` tool will make it easy to unpack all **chunks** back into a single folder.
