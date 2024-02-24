//ducem o muchie in graf de la i la j ce retine pi+1 + pi+2 ... pj
//si = p1 + p2 +... + pi
//o muchie i j = sj - si
//introducem un nod nou 0
//luam APM-ul corespunzator noului graf si facem suma din muchiile acestuia
//putem face inclusiv kruskal pe acest graf si aia e 

#include <fstream>

#define inf 1e9

using namespace std;

ifstream f("oracol.in");
ofstream g("oracol.out");

int G[1001][1001];
int dist[1001];
bool vis[1001];

int main()
{
    int n, x;
    f >> n;

    // Construirea grafului ponderat
    for (int i = 1; i <= n; i++)
    {
        for (int j = 1; j <= n - i + 1; j++)
        {
            f >> x;
            if (j == 1)
            {
                G[i - 1][i] = x;
                G[i][i - 1] = x;
            }
            else
            {
                G[i - 1][i - 1 + j] = x;
                G[i - 1 + j][i - 1] = x;
            }
        }
        dist[i - 1] = inf;
    }
    
    // Initializarea distantei pentru nodul nou adaugat
    dist[n] = inf;
    // Initializarea distantei pentru nodul de start (nodul 0)
    dist[0] = 0;

    int sol = 0;
    // Construirea APM
    for (int i = 0; i <= n; i++)
    {
        int minim = inf;
        int pos = 0;
        // Cautarea nodului nevizitat cu cea mai mica distanta
        for (int j = 0; j <= n; j++)
        {
            if (!vis[j] && dist[j] < minim)
            {
                minim = dist[j];
                pos = j;
            }
        }

        // Adaugarea costului minim la solutie
        sol += minim;
        // Marcarea nodului ca vizitat
        vis[pos] = 1;
        // Actualizarea distantelor
        for (int j = 0; j <= n; j++)
        {
            if (!vis[j] && dist[j] > G[pos][j])
                dist[j] = G[pos][j];
        }
    }

    g << sol;

    return 0;
}