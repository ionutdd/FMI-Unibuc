#include <fstream>
#include <vector>
#include <set>

using namespace std;

#define dim 100001
#define inf 1e18

ifstream f("trilant.in");
ofstream g("trilant.out");

int n, m, a, b, c, x, y, cost, k, t1[dim], t2[dim], t3[dim], sol[dim];
long long mini, d1[dim], d2[dim], d3[dim];

vector<pair<int, int>> G[dim];

// Multime pentru stocarea nodurilor cu distantele minime
set<pair<long long, int>> s;

void dijkstra(int p, long long d[], int t[]) {
    for (int i = 1; i <= n; i++)
        d[i] = inf;
    d[p] = 0;
    s.clear();
    s.insert({ 0,p });
    while (!s.empty()) {
        int nod = s.begin()->second;
        s.erase(s.begin());
        for (const auto& edge : G[nod]) {
            int vec = edge.first;
            int cost = edge.second;
            if (d[nod] + cost < d[vec]) {
                s.erase({ d[vec], vec });
                d[vec] = d[nod] + cost;
                s.insert({ d[vec], vec });
                t[vec] = nod;
            }
        }
    }
}

// Functie pentru construirea unui drum de la nodul curent la nodul sursa
void path(int x, int t[]) {
    int count = 0;
    while (x != 0) {
        sol[++count] = x;
        x = t[x];
    }
    g << count << " ";
    for (int i = 1; i <= count; i++)
        g << sol[i] << " ";
    g << '\n';
}

int main() {
    f >> n >> m >> a >> b >> c;

    // Construirea grafului
    while (m--) 
    {
        f >> x >> y >> cost;
        G[x].push_back({ y,cost });
        G[y].push_back({ x,cost });
    }

    // Aplicarea algoritmului Dijkstra pentru cele trei noduri
    dijkstra(a, d1, t1);
    dijkstra(b, d2, t2);
    dijkstra(c, d3, t3);

    // Initializarea valorii minime si a nodului k corespunzator acesteia
    mini = inf;
    for (int i = 1; i <= n; i++)
        if (d1[i] + d2[i] + d3[i] < mini) 
        {
            mini = d1[i] + d2[i] + d3[i];
            k = i;
        }

    g << mini << '\n';

    // Scrierea drumului pentru fiecare nod
    path(k, t1);
    path(k, t2);
    path(k, t3);

    return 0;
}
