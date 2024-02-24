#include <stdio.h>
#include <errno.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/wait.h>

int main(int argc, char **argv)
{
    // Verifică dacă a fost exista un argument in cmd line
    if (argc < 2) 
        return -1;

    // Converteste primul argument într-un număr întreg
    int n = atoi(argv[1]);
    
    // Creează un proces copil
    pid_t pid = fork();
    
    // Verifică dacă fork() a fost realizat cu succes
    if (pid < 0)
        return errno;
    
    // Procesul copil
    while (pid == 0 && n > 1)
    {
        // Afișează numărul curent
        printf("%d ", n); 

        // Calculează următorul număr din secvența Collatz
        n = (n % 2) ? (3 * n + 1) : (n / 2);

        // Verifică dacă am ajuns la finalul secvenței (n = 1)
        if (n == 1)
            printf("%d ", n);
    }

    // În afara buclei pentru procesul părinte
    if (pid != 0)
    {
        // Așteaptă ca procesul copil să se termine
        wait(NULL);

        // Afișează un mesaj de finalizare pentru procesul părinte
        printf("\nChild %d finished\n", getpid());
    }
    

    return 0;
}
