/*
Funcția reverse primește un pointer la un șir de caractere și returnează un pointer la un nou șir care este inversul șirului de intrare.
În funcția main:
Un fir de execuție este creat pentru a apela funcția reverse cu argumentul argv[1] (primul argument de la cmd line).
pthread_join așteaptă ca firul de execuție să se termine și obține rezultatul (șirul inversat).
Rezultatul este apoi afișat și memoria alocată pentru șirul inversat este eliberată folosind free.
*/


#include <stdio.h>
#include <pthread.h>
#include <errno.h>
#include <stdlib.h>
#include <string.h>

// Funcția executată în cadrul threadului pentru a inversa un șir de caractere
void* reverse(void *v)
{
    int len = 0;

    // Calculul lungimii șirului
    while (((char*)v)[len]!='\0')
        len++;
        
    // Alocarea unui nou șir pentru inversarea caracterelor
    char *rev = malloc(sizeof(char) * len);

    // Inversarea caracterelor
    for (int i = 0; i < len; i++)
        rev[i] = ((char*)v)[len - i - 1];

    // Returnarea rezultatului (șirul inversat)
    return rev;
}

int main(int argc, char **argv)
{
    pthread_t thr;
    void *result;

    // Crearea unui thread care să apeleze funcția reverse
    if (pthread_create(&thr, NULL, reverse, argv[1])) 
    {
        perror(NULL);
        return errno;
    }

    // Așteptarea finalizării firului de execuție și obținerea rezultatului
    if (pthread_join(thr, &result))
    {
        perror(NULL);
        return errno;
    }

    // Afișarea rezultatului (șirul inversat)
    printf("%s\n", (char*)result);

    // Eliberarea memoriei alocate pentru șirul inversat
    free(result);

    return 0;
}
