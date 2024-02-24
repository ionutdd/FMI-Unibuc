#include <unistd.h>
#include <stdio.h>
#include <errno.h>
#include <stdlib.h>
#include <sys/wait.h>

int main(int argc, char** argv)
{ 
    // Se creează un proces copil
    pid_t pid = fork();
    
    // Se verifică dacă fork() a fost realizat cu succes
    if (pid < 0) 
        return errno;  
    else if (pid != 0) // Procesul părinte
    {
        // Se așteaptă ca procesul copil să se termine
        wait(NULL);

        // Se afișează PID-urile procesului părinte și copilului
        printf("My PID=%d, Child PID=%d\n", getpid(), pid);

        // Se afișează mesajul că procesul copil s-a încheiat
        printf("Child %d finished\n", pid);
    }  
    else // Procesul copil
        // Se înlocuiește imaginea procesului copil cu o nouă imagine utilizând comanda "ls" 
        execve("/usr/bin/ls", argv, NULL);
    
    return 0;
}
