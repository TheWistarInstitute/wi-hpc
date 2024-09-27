# MaxQuant

[MaxQuant](https://www.maxquant.org) is a quantitative proteomics software package designed for analyzing large mass-spectrometric data sets. It is specifically aimed at high-resolution MS data.

## Setup

Download these files

```bash
wget https://raw.githubusercontent.com/TheWistarInstitute/wi-hpc/refs/heads/main/apptainer/maxquant/maxquant.def
wget https://raw.githubusercontent.com/TheWistarInstitute/wi-hpc/refs/heads/main/apptainer/maxquant/maxquant.sh
wget https://raw.githubusercontent.com/TheWistarInstitute/wi-hpc/refs/heads/main/apptainer/maxquant/mqpar.xml
```

Edit the mqpar.xml configuration file to point to your `.fasta` files and `.raw` files. As well as the `<numThreads>` option to match the number of threads you wish to use. E.g:

```bash
# fasta file path
<fastaFilePath>/opt/data/fasta/20240806_UP000002311_Scerevisiae_559292_CI.fasta</fastaFilePath>

# raw file path
<filePaths>
       <string>/opt/data/raw/081924_Yeast_DDA_OA-AfterAP.raw</string>
</filePaths>

# number of threads
<numThreads>4</numThreads>
```

Edit the `maxquant.sh` script to set the `#SBATCH cpus-per-task=` option to match the number of threads you wish to use. E.g:

```bash
#SBATCH --cpus-per-task=4
...
export OUT_PATH="/wistar/it/"
apptainer exec cp -r /opt/data $OUT_PATH
```

Edit the `maxquant.def` file to point to your `mqpar.xml` file and `data/` folder. E.g:

```bash
cp /wistar/it/mqpar.xml /opt/
cp -r /wistar/it/data/ /opt/
```

## Running MaxQuant

Once you have made all above changes, run the submission script:

```bash
sbatch maxquant.sh
```

Then review the `.out` and `.err` files in your working directory

```bash
tail -f *.out
tail -f *.err
```

## Troubleshooting

If you enounter errors, you can try:

1. Deleting the container and rerunning the submission script.
2. Use an interactive session and attempt to run MaxQuant on the fly with a small set of data.
3. Email the [IT Help Desk](mailto::helpdesk@wistar.org) for support with any errors or screenshots.

