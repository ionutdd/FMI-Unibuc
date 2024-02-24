#include <fstream>
#include <vector>

using namespace std;
#define nmax 250
#define out -1

// Declararea vectorilor si matricilor utilizate
vector<int> parent(nmax + nmax * nmax + nmax);
vector<vector<int>> graf(nmax * nmax, vector<int>(2));
vector<int> sol(nmax * nmax);
vector<int> lengh(nmax + nmax * nmax + nmax);

ifstream f("bile.in");
ofstream g("bile.out");

// Functia pentru gasirea parintelui unui set
int find(int i) {
    if (parent[i] == i)
        return i;
    return parent[i] = find(parent[i]);
}

// Union Find
void unionn(int i, int j) {
    int parenti = find(i);
    int parentj = find(j);

    if (parenti != parentj) {
        lengh[parentj] += lengh[parenti];
        lengh[parenti] = 0;
        parent[parenti] = parentj;
    }
}

int main() {
    int n, max = 0, poz;
    f >> n;

    // Citirea perechilor de coordonate din fisierul de intrare
    for (int i = 0; i < n * n; i++)
        f >> graf[i][0] >> graf[i][1];

    // Initializarea parintilor si a lungimilor
    for (int i = 0; i < n; i++)
        parent[i] = parent[n - 1 + n * n + n - i] = out;

    // Parcurgerea grafului invers pentru construirea solutiei
    for (int i = n * n - 1; i > 0; i--) {
        sol[i] = max;
        poz = n - 1 + (graf[i][0] - 1) * n + graf[i][1];
        lengh[poz] = 1;
        parent[poz] = poz;

        // Union cu vecinii daca exista
        if (parent[poz - n] > 0)
            unionn(poz - n, poz);
        if (parent[poz + n] > 0)
            unionn(poz + n, poz);
        if (parent[poz + 1] > 0 && graf[i][1] < n)
            unionn(poz + 1, poz);
        if (parent[poz - 1] > 0 && graf[i][1] > 1)
            unionn(poz - 1, poz);

        // Actualizarea lungimii maxime
        if (lengh[poz] > max)
            max = lengh[poz];
    }

    // Salvarea solutiei complete
    sol[0] = n * n - 1;

    for (int i = 0; i < n * n; i++)
        g << sol[i] << "\n";

    return 0;
}
