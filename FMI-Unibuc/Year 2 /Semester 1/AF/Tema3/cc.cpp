#include <fstream>
#include <cstring>
#include <queue>
#include <vector>

using namespace std;

#define INF 0x3f3f3f3f

ifstream f("cc.in");
ofstream g("cc.out");

const int MAX_N = 301;

int calculator[MAX_N][MAX_N], n, parinte[MAX_N], dist[MAX_N], cost[MAX_N][MAX_N], solutie;
vector<pair<int, int> > G[MAX_N];

bool dijkstra()
{
    int nod;
    queue<int> Q;

    // Initializarea vectorilor pentru algoritmul lui Dijkstra
    memset(parinte, 0, sizeof(parinte));
    memset(dist, INF, sizeof(dist));

    // Adaugarea nodului de start in coada
    Q.push(0);
    dist[0] = 0;

    // Algoritmul lui Dijkstra
    while (!Q.empty())
    {
        nod = Q.front();
        Q.pop();

        for (auto vec : G[nod])
            if (calculator[nod][vec.first] && dist[vec.first] > dist[nod] + vec.second)
            {
                dist[vec.first] = dist[nod] + vec.second;
                Q.push(vec.first);
                parinte[vec.first] = nod;
            }
    }

    // Verificarea daca s-a atins destinatia
    if (dist[2 * n + 1] == INF)
        return false;

    // Reconstructia solutiei si actualizarea grafului
    for (int i = 2 * n + 1; i != 0; i = parinte[i])
    {
        calculator[parinte[i]][i]--;
        calculator[i][parinte[i]]++;
        solutie += cost[parinte[i]][i];
    }

    return true;
}

int main()
{
    f >> n;

    // Construirea grafului 
    for (int i = 1; i <= n; i++)
        for (int j = 1; j <= n; j++)
        {
            int x;
            f >> x;

            G[i].push_back(make_pair(j + n, x));
            G[j + n].push_back(make_pair(i, -x));

            calculator[i][j + n] = 1;
            cost[i][j + n] = x;
            cost[j + n][i] = -x;
        }

    // Adaugarea nodurilor sursa si destinatie
    for (int i = 1; i <= n; i++)
    {
        G[0].push_back(make_pair(i, 0));
        calculator[0][i] = 1;
    }

    for (int i = n + 1; i <= 2 * n; i++)
    {
        G[i].push_back(make_pair(2 * n + 1, 0));
        calculator[i][2 * n + 1] = 1;
    }

    // Apelul algoritmului de flux maxim bazat pe Dijkstra
    while (dijkstra());

    // Afisarea rezultatului
    g << solutie;

    return 0;
}
