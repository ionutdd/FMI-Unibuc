#include <fstream>
#include <vector>
#include <algorithm>

using namespace std;

int n, m, a, CostTot, CostInit, t;

// Structura pentru reprezentarea unei muchii
struct edge
{
    int x, y, cost;
};

// Vectori pentru stocarea tuturor muchiilor si a solutiei
vector<edge> v, sol;

// Vector pentru stocarea parintilor fiecarui nod in cadrul unei componente conexe
vector<int> parent;

// Functie de comparare a doua muchii in functie de cost
bool cmp(edge st, edge dr)
{
    return st.cost < dr.cost;
}

// Functie pentru gasirea radacinii unei componente conexe
int unionn(int nod)
{
    int r, aux = nod;
    while (aux != parent[aux]) aux = parent[aux];
    while (nod != parent[nod])
    {
        r = nod;
        parent[nod] = aux;
        nod = parent[r];
    }
    return nod;
}

// Functie pentru construirea APM
void apm()
{
    // Initializarea vectorului de parinti
    parent.resize(n + 2);
    for (int i = 1; i <= n; i++)
        parent[i] = i;

    // Sortarea muchiilor in ordine crescatoare a costurilor
    sort(v.begin(), v.end(), cmp);

    // Parcurgerea fiecarei muchii si construirea APM
    for (auto edge : v)
    {
        // Verificarea daca arborele este complet
        if (sol.size() == n - 1)
            return;

        // Gasirea radacinilor celor doua componente conexe
        int rootX = unionn(edge.x);
        int rootY = unionn(edge.y);

        // Verificarea pentru a evita ciclurile in arbore
        if (rootX == rootY)
            continue;

        // Unirea celor doua componente conexe
        parent[rootX] = rootY;

        // Adaugarea muchiei la solutie si actualizarea costului total
        sol.push_back(edge);
        CostTot += edge.cost;
    }
}

ifstream f("rusuoaica.in");
ofstream g("rusuoaica.out");

int main()
{
    f >> n >> m >> a;
    for (int i = 1; i <= m; i++)
    {
        edge aux;
        f >> aux.x >> aux.y >> aux.cost;
        CostInit += aux.cost;

        // Adaugarea muchiei in vectorul de muchii daca costul este mai mic sau egal cu a
        if (aux.cost <= a)
            v.push_back(aux);
    }

    apm();

    // Calculul costului final conform formulei date
    int d = sol.size();
    int CostFin = 2 * CostTot - CostInit;

    g << CostFin + a * (n - 1 - d);
    return 0;
}
