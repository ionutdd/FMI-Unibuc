/*
Fiecare thread primește o structură pos care conține poziția sa în matricea rezultat.
În cadrul funcției multiply, fiecare thread calculează valoarea elementului corespunzător matricei rezultat folosind matricele de intrare matrix1 și matrix2.
Alocarea structurilor de poziții este făcută cu calloc pentru a evita problemele legate de utilizarea memoriei neinițializate.
Fiecare thread este creat pentru a calcula un singur element al matricei rezultat, și apoi așteaptă finalizarea celorlalte threaduri înainte de a afișa rezultatele.
După ce toate threadurile au terminat, matricea rezultata este afișată.
*/


#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <pthread.h>

#define rows 3
#define cols 3

int matrix1[rows][cols] = 
{
        {1,2,3},
        {4,5,6},
        {7,8,9}
};

int matrix2[rows][cols] = 
{
        {1,1,1},
        {2,2,2},
        {3,3,3}
};

int result_matrix[rows][cols];

// Structura pentru a reprezenta poziția unui camp în matrice.
struct pos
{
    int i, j;
};

// Funcția executată în cadrul fiecărui thread pentru a efectua înmulțirea.
void* multiply(void* position)
{
    struct pos* index = position;
    int i = index->i;
    int j = index->j;

    free(position); // Eliberarea memoriei alocate pentru structura de poziție.

    result_matrix[j][i] = 0;

    // Efectuarea înmulțirii pentru elementul de la poziția (i, j).
    for(int k = 0; k < cols; k++)
        result_matrix[j][i] += matrix1[j][k] * matrix2[k][i];

    return NULL;
}

int main()
{
    pthread_t threads[rows * cols];
    int thread_id = 0;

    // Crearea threadurilor pentru fiecare element al matricei rezultatnte.
    for (int i = 0; i < rows; i++)
        for (int j = 0; j < cols; j++)
        {
            struct pos* index = calloc(1, sizeof(struct pos));
            index->i = i;
            index->j = j;

            // Crearea threadului și trimiterea poziției ca argument.
            if(pthread_create(&threads[thread_id++], NULL, multiply, index))
            {
                perror(NULL);
                return errno;
            }
        }

    // Așteptarea finalizării fiecărui thread.
    for (int i = 0; i < thread_id; i++)
    {
        if(pthread_join(threads[i], NULL))
        {
            perror(NULL);
            return errno;
        }
        printf("Thread %d finished\n", i);
    }
     
    // Afișarea matricei rezultate.
    for (int i = 0; i < rows; i++)
    {
        for (int j = 0; j < cols; j++)
            printf("%d ", result_matrix[i][j]);

        printf("\n");
    }

    return 0;
}
