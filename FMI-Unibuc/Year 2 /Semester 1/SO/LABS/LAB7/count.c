/*
Mutex-ul (pthread_mutex_t mtx) este folosit pentru a asigura accesul sincronizat la resurse în timpul operațiilor de creștere și descreștere a numărului de resurse disponibile.
Funcția decrease_count scade numărul de resurse disponibile cu o cantitate dată, iar increase_count face opusul, adică crește numărul de resurse disponibile.
Fiecare thread (my_thread) primește o cantitate de resurse și, în funcție de aceasta, efectuează operațiile corespunzătoare.
Se asigură că nu sunt eliberate mai multe resurse decât cele disponibile inițial (available_resources) și că numărul total de resurse rămâne între 0 și MAXRESOURCES.
Sunt afișate mesaje informative pentru a evidenția operațiile efectuate asupra resurselor.
După ce toate threadurile au terminat execuția, mutex-ul este distrus pentru eliberarea resurselor asociate cu acesta.
*/

#include <stdio.h>
#include <pthread.h>
#include <errno.h>
#include <stdlib.h>

#define MAXRESOURCES 5
#define MAXTHREADS 6

int available_resources = MAXRESOURCES;

pthread_mutex_t mtx;  // Mutex pentru sincronizarea accesului la resurse.
int size = MAXTHREADS;
int count_threads[MAXTHREADS] = {-2, 2, -2, 2, -1, 1};

// Funcție pentru a decrementa numărul de resurse disponibile.
int decrease_count(int count)
{
    int error = pthread_mutex_lock(&mtx);
    if (!error && count <= available_resources)
    { 
        available_resources -= count;
        printf("Got %d resources, %d remaining\n", count, available_resources);
    }
    else
        printf("Error while decreasing available resources\n");
    
    return pthread_mutex_unlock(&mtx);
}

// Funcție pentru a incrementa numărul de resurse disponibile.
int increase_count(int count)
{
    int error = pthread_mutex_lock(&mtx);
    if(!error && available_resources + count <= MAXRESOURCES)
    {
         available_resources += count;
         printf("Released %d resources, %d remaining\n", count, available_resources);
    }
    else
         printf("Error while decreasing available resources\n");
    return pthread_mutex_unlock(&mtx);
}

// Funcție executată de fiecare thread.
void* my_thread(void* x)
{
    int count = *((int*)x);
    if (count < 0)
        decrease_count(-count);
    else
        increase_count(count);
    return NULL;
}

int main()
{
    if (pthread_mutex_init(&mtx, NULL)) 
    {
        perror(NULL);
        return errno;
    }

    printf("MAXRESOURCES=%d\n", MAXRESOURCES);
    pthread_t* thr = malloc(size * sizeof(pthread_t));

    // Crearea și lansarea threadurilor.
    for (int i = 0; i < size; i++)
        pthread_create(&thr[i], NULL, my_thread, &count_threads[i]);

    // Așteptarea finalizării fiecărui thread.
    for(int i = 0; i < size; i++)
        pthread_join(thr[i], NULL);

    // Distrugerea mutex-ului.
    pthread_mutex_destroy(&mtx);
    return 0;
}
