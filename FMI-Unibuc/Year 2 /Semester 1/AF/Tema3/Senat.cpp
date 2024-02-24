#include <fstream>
#include <cstring>
#include <vector>

#define N_MAX 101

using namespace std;

ifstream f("senat.in");
ofstream g("senat.out");

int n, m, urmNod, nr, viz[N_MAX], st[N_MAX], dr[N_MAX];
vector<int> G[N_MAX];
char s[100001];

bool cupleaza(int nod)
{
    // Verificare daca nodul a fost deja vizitat in aceasta iteratie
    if (viz[nod])
        return false;

    // Marcare nod ca vizitat
    viz[nod] = 1;

    // Iterare prin vecinii nodului
    for (auto elem : G[nod])
        // Verificare daca nodul corespunzator vecinului nu este cuplat
        if (!dr[elem] || cupleaza(dr[elem]))
        {
            // Cuplarea nodului curent cu vecinul
            dr[elem] = nod;
            st[nod] = elem;
            return true;
        }

    // Nodul curent nu poate fi cuplat
    return false;
}

void cuplaj()
{
    // Variabila pentru a verifica daca s-au realizat cuplari in iteratia curenta
    bool ok = true;

    // Algoritmul lui Hopcroft-Karp pentru determinarea cuplajului maxim
    while (ok)
    {
        // Initializare vector de vizitare pentru fiecare iteratie
        for (int i = 1; i <= m; i++)
            viz[i] = 0;

        ok = false;

        // Incercare de realizare a cuplarilor pentru fiecare nod neocupat
        for (int i = 1; i <= m; i++)
            if (!st[i] && cupleaza(i))
                ok = true;
    }
}

int main()
{
    
    f >> n >> m;
    f.get(); 

    // Construirea grafului bipartit
    for (int i = 1; i <= m; i++)
    {
        f.getline(s, 100001);
        int lungime = strlen(s);

        for (int j = 0; j < lungime; j++)
        {
            urmNod = 0;

            // Extrage urmatorul nod din linie
            while (j < lungime && isdigit(s[j]))
            {
                urmNod = urmNod * 10 + s[j] - '0';
                j++;
            }

            // Adauga nodul in lista de vecini a nodului curent
            if (urmNod != 0)
                G[i].push_back(urmNod);
        }
    }

    // Realizeaza cuplajul maxim
    cuplaj();

    // Numara nodurile cuplate in stanga
    for (int i = 1; i <= m; i++)
        if (st[i])
            nr++;

    // Daca numarul de noduri cuplate in stanga nu este egal cu m, nu exista cuplaj perfect
    if (nr != m)
    {
        g << 0;
        return 0;
    }

    // Afiseaza cuplajul perfect altfel
    for (int i = 1; i <= m; i++)
        g << st[i] << '\n';

    return 0;
}
