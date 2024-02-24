#include <fstream>
#include <vector>

using namespace std;

ifstream f("paznici.in");
ofstream g("paznici.out");

vector<int> neighb[27];

bool solSt[27], solDr[27];
int st[27], dr[27];
bool ok[27];

bool cupleaza(int nod)
{
    // Verificare daca nodul a fost deja vizitat in aceasta iteratie
    if (ok[nod])
        return false;

    // Marcare nod ca vizitat
    ok[nod] = true;

    // Iterare prin vecinii nodului
    for (int elem : neighb[nod])
        // Verificare daca nodul corespunzator vecinului nu este cuplat
        if (!st[elem] or cupleaza(st[elem]))
        {
            // Cuplarea nodului curent cu vecinul
            dr[nod] = elem;
            st[elem] = nod;
            return true;
        }

    // Nodul curent nu poate fi cuplat
    return false;
}

void DFS(int nod)
{
    // Marcare nod ca vizitat
    ok[nod] = true;

    // Initializare pentru solutia dreapta
    solSt[nod] = false;

    // Iterare prin vecinii nodului
    for (int x : neighb[nod])
        // Verificare daca nodul corespunzator vecinului nu a fost vizitat
        if (!ok[st[x]])
        {
            // Marcare nod drept solutie in partea stanga
            solDr[x] = true;

            // Apel recursiv pentru DFS pe nodul cuplat
            DFS(st[x]);
        }
}

int main()
{
    int n, m;
    char x;
    f >> n >> m;

    // Initializare graful bipartit
    for (int i = 1; i <= n; i++)
        for (int j = 1; j <= m; j++)
        {
            f >> x;
            if (x == '1')
                neighb[i].push_back(j);
        }

    bool out;
    int cuplaj = 0;

    // Algoritmul lui Hopcroft-Karp pentru determinarea cuplajului maxim
    do
    {
        for (int i = 1; i <= n; i++)
            ok[i] = false;

        out = false;

        // Incercare de realizare a cuplarilor pentru fiecare nod necuplat
        for (int i = 1; i <= n; i++)
            if (!dr[i] && cupleaza(i))
            {
                cuplaj++;
                out = true;
            }
    } while (out);

    // Initializare pentru parcurgerea DFS
    for (int i = 1; i <= n; i++)
        if (dr[i])
        {
            solSt[i] = true;
            ok[i] = false;
        }

    // Apel pentru parcurgerea DFS
    for (int i = 1; i <= n; i++)
        if (!dr[i])
            DFS(i);

    for (int i = 1; i <= n; i++)
        if (solSt[i])
            g << (char)(i - 1 + 'A');

    for (int i = 1; i <= m; i++)
        if (solDr[i])
            g << (char)(i - 1 + 'a');

    return 0;
}
