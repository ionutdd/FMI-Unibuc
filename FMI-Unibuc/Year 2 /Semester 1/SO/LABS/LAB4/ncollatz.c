#include <stdio.h>
#include <errno.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/wait.h>
///functie
void collatz(int x){
    printf("%d ", x);
    if(x == 1) 
        return;
    x = (x % 2) ? (3 * x + 1) : (x / 2);
    collatz(x);
}

int main(int argc, char **argv)
{
    ///inceputul
    printf("Starting parent %d\n", getpid());
    ///luam fiecare element
    pid_t pids[argc];
    for(int i = 0; i < argc; i++)
    {
        if((pids[i] = fork())<0)
            return errno;
        else if(pids[i] == 0)
        {
            int n = atoi(argv[i+1]);
            printf("%d: ", n);
            collatz(n);
            printf("\n");
            printf("Done Parent %d Me %d\n", getppid(), getpid());
            exit(0);
            
        }
        
    }
    ///stare finala
    for (int i = 0; i < argc; i++)
    {
    //  Așteaptă finalizarea oricărui proces copil al procesului apelant
    wait(NULL); //Atunci când un proces copil se termină, sistemul de operare trimite un semnal părintelui pentru a-i indica că procesul copil și-a încheiat execuția.

    // Afișează un mesaj care indică că procesul părinte a terminat așteptarea
    
    }
    printf("Done Parent %d Me %d\n", getppid(), getpid());
    return 0;
}