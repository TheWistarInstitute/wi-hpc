#!/bin/bash

# Job Options - must be before ANY executable lines!!!

#SBATCH --job-name="Hello-World-Example"
#SBATCH --output=Hello-World.%j.out

echo "Hello, World!"
