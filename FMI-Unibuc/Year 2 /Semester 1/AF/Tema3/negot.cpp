#include <fstream>
#include <vector>

using namespace std;

ifstream f("negot.in");
ofstream g("negot.out");

int n, m, k, ti, x, solutie;

int st[30001], dr[40001], viz[30001];
vector<int> G[30001];

bool match(int nod)
{
    // Verificare daca nodul a fost deja vizitat in cadrul acestei iteratii
    if (viz[nod])
        return false;

    // Marcare nod ca vizitat
    viz[nod] = 1;

    // Iterare prin vecinii nodului
    for (auto& x : G[nod])
        // Verificare daca nodul corespunzator vecinului nu este cuplat
        if (!dr[x])
        {
            // Cuplarea nodului curent cu vecinul
            st[nod] = x;
            dr[x] = nod;
            return true;
        }

    // Iterare prin vecinii nodului
    for (auto& x : G[nod])
        // Verificare daca se poate face o cuplare recursiva cu vecinul
        if (match(dr[x]))
        {
            // Cuplarea nodului curent cu vecinul
            st[nod] = x;
            dr[x] = nod;
            return true;
        }

    // Nodul curent nu poate fi cuplat
    return false;
}

int main()
{
  
    f >> n >> m >> k;

    // Construirea grafului bipartit
    for (int i = 1; i <= n; i++)
    {
        f >> ti;
        for (int j = 1; j <= ti; j++)
        {
            f >> x;
            for (int l = 1; l <= k; l++)
                G[(i - 1) * k + l].push_back(x);
        }
    }

    // Variabila pentru a verifica daca s-au realizat cuplari in iteratia curenta
    bool ok = true;

    // Algoritmul de cuplare
    while (ok)
    {
        ok = false;

        // Initializare vector de vizitare pentru fiecare iteratie
        for (int i = 1; i <= n * k; i++)
            viz[i] = 0;

        // Incercare de realizare a cuplarilor pentru fiecare nod neocupat
        for (int i = 1; i <= n * k; i++)
            if (!st[i])
                ok |= match(i);
    }

    // Calculul numarului de cuplari realizate
    for (int i = 1; i <= n * k; i++)
        if (st[i] > 0)
            solutie++;

    g << solutie;

    return 0;
}
