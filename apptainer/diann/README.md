# DiaNN

GitHub: https://github.com/vdemichev/DiaNN

## Building Container

Build the container with the `apptainer build` command with the `recipe.def` file:

```bash
apptainer build diann.sif recipe.def
```

## Running Container

You may use the default run command (see `%runscript` section in the `recipe.def` file).

```bash
apptainer run diann.sif
```

You can update the `%runscript` section in the `recipe.def` file to change the default run command.

OR

Run the container with the `apptainer exec` command which will allow you to pass a command to the container:

```bash
apptainer exec diann.sif <command>
```

Please see DiaNN's [Command-line reference](https://github.com/vdemichev/DiaNN?tab=readme-ov-file#command-line-reference) for more information on how to run DiaNN through the command line.
