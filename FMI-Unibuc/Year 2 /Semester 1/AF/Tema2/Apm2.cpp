#include <fstream>
#include <algorithm>

using namespace std;

ifstream f("apm2.in");
ofstream g("apm2.out");

// Structura pentru reprezentarea muchiilor grafului
pair<int, pair<int, int>> G[100001];

// Perechile de noduri pentru noile muchii
pair<int, int> NewEdge[1001];

int n, m, q, sol[1001], parent[10001];  

// Functie pentru gasirea radacinii unei componente conexe
int Root(int x) {
    if (parent[x] == 0)
        return x;
    parent[x] = Root(parent[x]);
    return parent[x];
}

int main() {
    f >> n >> m >> q;

    // Citirea muchiilor grafului
    for (int i = 1; i <= m; i++)
        f >> G[i].second.first >> G[i].second.second >> G[i].first;

    // Sortarea muchiilor in ordine crescatoare a costurilor
    sort(G + 1, G + 1 + m);

    // Citirea perechilor de noduri pentru noile muchii
    for (int i = 1; i <= q; i++) {
        int x, y;
        f >> x >> y;
        NewEdge[i] = make_pair(x, y);
    }

    // Parcurgerea muchiilor si construirea APM
    for (int i = 1; i <= m; i++) {
        if (G[i].first != G[i - 1].first) {
            for (int j = 1; j <= q; j++)
                if (Root(NewEdge[j].first) != Root(NewEdge[j].second))
                    sol[j] = G[i].first - 1;
        }

        int RootFirst = Root(G[i].second.first), RootSecond = Root(G[i].second.second);
        if (RootFirst != RootSecond)
            parent[RootFirst] = RootSecond;
    }

    for (int i = 1; i <= q; i++)
        g << sol[i] << '\n';

    return 0;
}
