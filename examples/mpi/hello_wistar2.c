#include <mpi.h>
#include "stdio.h"

int main(int argc, char** argv) {

        // Initalize MPI Environment
        MPI_Init(NULL, NULL);

        // Get rank of process
        int PID;
        MPI_Comm_rank(MPI_COMM_WORLD, &PID);

        // Get Number of processes
        int num_processes;
        MPI_Comm_size(MPI_COMM_WORLD, &num_processes);

        // Get name of the processor
        char processor_name[MPI_MAX_PROCESSOR_NAME];
        int name_len;
        MPI_Get_processor_name(processor_name, &name_len);

        // Print hello world message
        printf("Process PID %d out of %d processes on machine %s\n", PID, num_processes, processor_name);

        // Finalize mpi environment
        MPI_Finalize();

        return 0;
}
