#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdbool.h>
#include <errno.h>

#define BUF_SIZE 4096  // Dimensiunea bufferului

int main(int argc, char** argv) {
    
    char buffer[BUF_SIZE];
    
    // Deschide fisierul sursa pentru citire
    int arg1 = open(argv[1], O_RDONLY);
    if (arg1 == -1) {
        perror("Eroare deschidere fisier sursa");
        exit(1);
    }
    
    // Deschide fisierul destinatie pentru scriere, cu O_TRUNC pentru a sterge continutul anterior
    int arg2 = open(argv[2], O_WRONLY | O_TRUNC);
    if (arg2 == -1) {
        perror("Eroare deschidere fisier destinatie");
        close(arg1);
        exit(1);
    }
    
    ssize_t bytesRead, bytesWritten;
    
    // Citeste si scrie date pana cand intregul continut al fisierului sursa este procesat
    while ((bytesRead = read(arg1, buffer, sizeof(buffer))) > 0) {
        bytesWritten = write(arg2, buffer, bytesRead);
        if (bytesWritten != bytesRead) {
            perror("Eroare scriere fisier destinatie");
            close(arg1);
            close(arg2);
            exit(1);
        }
    }
    
    if (bytesRead == -1) {
        perror("Eroare citire fisier sursa");
        exit(1);
    }
    
    close(arg1);
    close(arg2);

    return 0;
}
