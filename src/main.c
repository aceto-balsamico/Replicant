#include "common.h"
#include "userfunc.h"


struct timespec start, end;

void start_timer() {
    clock_gettime(CLOCK_MONOTONIC, &start);
}
void stop_timer() {
    clock_gettime(CLOCK_MONOTONIC, &end);
    double elapsed = (end.tv_sec - start.tv_sec) + 
                     (end.tv_nsec - start.tv_nsec) / 1e9;
    printf("Elapsed time: %.9f seconds, (%.6f ms)\n", elapsed, elapsed * 1e3);
}


int main(int argc, char *argv[]) 
{   
    // int Loop = 10000;
    // int ret_userfunc = 0;
    // start_timer();
    // for(int i = 0; i < Loop; i++) 
    // {
    //     ret_userfunc += userfunc(argc, argv);
    // }
    // stop_timer();
    // printf("Total userfunc return value: %d\n", ret_userfunc);
    
    int ret_userfunc = userfunc(argc, argv);
    if (ret_userfunc != 0) 
    {
        fprintf(stderr, "userfunc returned an error: %d\n", ret_userfunc);
        return ret_userfunc;
    }
    return 0;
}