/*
Se utilizează memorie partajată (shm_open, ftruncate, mmap) pentru a permite fiecărui proces copil să stocheze 
rezultatele secvenței Collatz într-un spațiu de memorie accesibil tuturor proceselor copil și părintelui.
Fiecare copil primește un buffer în care stochează rezultatele secvenței Collatz.
După ce toate procesele copil se termină, părintele afișează rezultatele pentru fiecare secvență Collatz calculată în copii.
Memoria partajată este eliminată și resursele alocate pentru ea sunt eliberate (shm_unlink, munmap).
*/

#include <stdio.h>
#include <errno.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/wait.h>
#include <sys/mman.h>
#include <fcntl.h>

// Funcția face secvența Collatz și stochează rezultatele într-un buffer partajat
void collatz(int *buf, int value) 
{
    int len = 0;
    do {
        buf[len++] = value;
        if (value % 2 == 0) 
            value /= 2;
        else 
            value = value * 3 + 1;
    } while (value != 1);
    buf[len] = value;
    buf[0] = len;
    printf("Done Parent %d Me %d\n", getppid(), getpid());

}

int main(int argc, char **argv) 
{
    // Verifică dacă a fost furnizat cel puțin un argument în cmd line
    if (argc < 2) 
        return -1;

    // Declarații pentru gestionarea memoriei partajate
    pid_t pids[argc];
    char shm_name[] = "collatz";
    int shm_fd, i, j, *shm_ptr;

    // Crearea unui obiect de memorie partajată
    shm_fd = shm_open(shm_name, O_CREAT | O_RDWR, S_IRUSR | S_IWUSR);
    if (shm_fd < 0) 
    {
        perror(NULL);
        return errno;
    }

    // Alocarea dimensiunii pentru memoria partajată și gestionarea erorilor
    size_t shm_size = getpagesize() * argc;
    if (ftruncate(shm_fd, shm_size) == -1) 
    {
        perror(NULL);
        shm_unlink(shm_name);
        return errno;
    }

    // Realizarea mapării memoriei partajate și gestionarea erorilor
    shm_ptr = mmap(0, shm_size, PROT_WRITE, MAP_SHARED, shm_fd, 0);
    if (shm_ptr == MAP_FAILED) 
    {
        perror(NULL);
        shm_unlink(shm_name);
        return errno;
    }

    // Mesaj de început pentru procesul părinte
    printf("Starting parent %d\n", getpid());

    // Crearea proceselor copil și execuția funcției collatz în fiecare copil
    for (i = 0; i < argc - 1; i++) 
    {
        pids[i] = fork();
        if (pids[i] < 0) 
        {
            perror(NULL);
            shm_unlink(shm_name);
            return errno;
        } 
        else if (pids[i] == 0) 
        {
            // Determinarea adreselor de început ale bufferelor pentru fiecare copil
            int *buf = shm_ptr + i * getpagesize() / sizeof(int);
            if (buf == MAP_FAILED) 
            {
                perror(NULL);
                shm_unlink(shm_name);
                return errno;
            }

            // Executarea funcției collatz în fiecare copil
            collatz(buf, atoi(argv[i + 1]));

            // Terminarea procesului copil
            return 0;
        }
    }

    // Așteptarea finalizării tuturor proceselor copil
    for (i = 0; i < argc; i++) 
    {
        wait(NULL);
    }

    // Afișarea rezultatelor pentru fiecare secvență Collatz calculată în fiecare copil
    for (i = 0; i < argc - 1; i++) 
    {
        int n = atoi(argv[i+1]);
        int *buf = &shm_ptr[i * getpagesize() / sizeof(int)];
        int size = buf[0];
        printf("%d: ", n);
        for (j = 1; j <= size; j++) 
        {
            printf("%d ", buf[j]);
        }
        printf("\n");
    }

    // Eliberarea resurselor pentru memoria partajată
    shm_unlink(shm_name);
    munmap(shm_ptr, shm_size);

    printf("Done Parent %d Me %d\n", getppid(), getpid());
    return 0;
}
