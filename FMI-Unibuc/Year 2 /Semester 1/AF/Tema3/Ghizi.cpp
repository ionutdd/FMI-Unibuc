#include <fstream>
#include <vector>
#include <queue>
#include <cstring>
#include <algorithm>

using namespace std;

ifstream f("ghizi.in");
ofstream g("ghizi.out");

const int N_MAX = 101;

queue<int> q;
vector<int> G[N_MAX][N_MAX], solutie;
int n, m, k, maxi, flux[N_MAX][N_MAX], capacitate[N_MAX][N_MAX], previous[N_MAX];

void Flux()
{
    // Initializarea vectorului pentru parintii nodurilor in BFS
    memset(previous, -1, sizeof(previous));

    // BFS pentru gasirea drumurilor crescatoare in reteaua residuala
    for (q.push(0); q.size(); q.pop())
    {
        int prim = q.front();

        for (int i = 0; i < 101; i++)
            if (capacitate[prim][i] > flux[prim][i] && -1 == previous[i])
            {
                q.push(i);
                previous[i] = prim;
            }
    }

    // Daca exista un drum crescator, se actualizeaza fluxul
    if (previous[100] != -1)
    {
        maxi++;

        for (int i = 100; i != 0; i = previous[i])
        {
            flux[previous[i]][i]++;
            flux[i][previous[i]]--;
        }
    }
}

int main()
{
    // Citirea numarului de noduri si numarului de grupuri de ghizi
    f >> n >> k;

    // Citirea relatiilor ghizilor
    for (int i = 1; i <= n; i++)
    {
        int x, y;
        f >> x >> y;
        capacitate[x][y]++;
        G[x][y].push_back(i);
    }

    // Apelul algoritmului pentru flux maxim de k ori
    for (int i = 1; i <= k; i++)
        Flux();

    // Construirea solutiei prin selectarea ghizilor din retea
    for (int i = 0; i < 101; i++)
        for (int j = 0; j < 101; j++)
            for (int k = 1; k <= flux[i][j]; k++)
                solutie.push_back(G[i][j][k - 1]);

    // Sortarea si afisarea solutiei
    sort(solutie.begin(), solutie.end());
    g << solutie.size() << '\n';

    for (int i = 0; i < solutie.size(); i++)
        g << solutie[i] << ' ';

    return 0;
}
