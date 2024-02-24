/*
Semaforul (sem_t semaphor) este folosit pentru a realiza sincronizarea la barieră.
Mutex-ul (pthread_mutex_t mtx) este folosit pentru a proteja variabila statică visited.
Funcția barrier_point este responsabilă pentru realizarea punctului de barieră și asigurarea sincronizării între thread-uri.
Fiecare thread atinge barierea și așteaptă până când toate celelalte thread-uri ajung la barieră.
Variabila barrier_limit reprezintă numărul de thread-uri necesare pentru a depăși bariera.
Fiecare thread afișează un mesaj când ajunge la barieră și când o depășește.
Se folosește alocare dinamică pentru a transmite argumentele la fiecare thread și pentru a evita condițiile de curse în variabila statică visited.
La final, se distruge semaforul și mutex-ul și se eliberează memoria alocată pentru thread-uri.
*/


#include <stdio.h>
#include <pthread.h>
#include <errno.h>
#include <stdlib.h>
#include <semaphore.h>

sem_t semaphor;          // Semafor pentru a sincroniza intrările și ieșirile de la barieră.
pthread_mutex_t mtx;      // Mutex pentru a proteja variabila statică 'visited'.
int barrier_limit = 4;    // Numărul de thread-uri necesare pentru a depăși bariera.
int nr_threads = 7;       // Numărul total de thread-uri.
 
// Funcție pentru a realiza punctul de barieră.
void barrier_point()
{
    static int visited = 0;  // Variabilă statică pentru a număra câte thread-uri au ajuns la barieră.

    pthread_mutex_lock(&mtx);

    if (++visited == barrier_limit) 
    {
        pthread_mutex_unlock(&mtx);
        sem_post(&semaphor);  // Incrementăm semaforul pentru a elibera toate thread-urile care așteaptă.
        return;
    }

    pthread_mutex_unlock(&mtx);
    sem_wait(&semaphor);  // Așteptăm ca toate celelalte thread-uri să ajungă la barieră.
    sem_post(&semaphor);  // Incrementăm semaforul pentru a elibera un alt thread care așteaptă.
}

// Funcție executată de fiecare thread.
void *tfun(void *v)
{
    int *tid = (int*)v;

    printf("%d reached the barrier\n", *tid);
    barrier_point();
    printf("%d passed the barrier\n", *tid);
    
    free(tid);

    return NULL;
}

int main()
{
    printf("NTHRS = %d\n", barrier_limit);

    sem_init(&semaphor, 0, 0);       // Inițializăm semaforul cu valoarea 0.
    pthread_mutex_init(&mtx, NULL);  // Inițializăm mutex-ul.
    pthread_t* threads = malloc(sizeof(pthread_t) * nr_threads);

    for (int i = 0; i < nr_threads; i++) 
    {
        int* arg = malloc(sizeof(int));
        *arg = i;
        pthread_create(threads + i, NULL, tfun, arg);
    }

    for (int i = 0; i < nr_threads; i++)
        pthread_join(threads[i], NULL);

    sem_destroy(&semaphor);     // Distruge semaforul.
    pthread_mutex_destroy(&mtx);  // Distruge mutex-ul.
    free(threads);

    return 0;
}
