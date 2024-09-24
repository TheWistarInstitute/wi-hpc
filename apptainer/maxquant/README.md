# MaxQuant

MaxQuant Home Page: https://www.maxquant.org/

Please use apptainer to leverage the containerized version of maxquant.


1. Create the `maxquant.def` file and use apptainer to build the container
2. Use the `maxquant.sh` script to build the container and run the maxquant
3. Update paths in all files to point to the correct paths

***NOTE***: You will need to update the file paths to your data in the `mqpar.xml` file as well as the number of ***threads*** you wish to use in the following lines. The `<numThreads>` MUST match the `cpus-per-task=` option in the `maxquant.sh` submission script.

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
