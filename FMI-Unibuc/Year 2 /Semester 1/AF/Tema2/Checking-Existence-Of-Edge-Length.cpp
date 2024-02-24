#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    // Functie de comparare pentru sortarea listei de muchii si interogari
    static bool cmp(vector<int>& a, vector<int>& b) {
        return a[2] < b[2];
    }

    // Functie pentru gasirea parintelui unui nod intr-un set
    int find_parent(int node, vector<int>& parent) {
        if (node == parent[node])
            return node;
        return parent[node] = find_parent(parent[node], parent);
    }

    void unionn(int u, int v, vector<int>& parent, vector<int>& rank) {
        int ulp_u = find_parent(u, parent), ulp_v = find_parent(v, parent);

        if (rank[ulp_u] > rank[ulp_v])
            parent[ulp_v] = ulp_u;
        else if (rank[ulp_u] < rank[ulp_v])
            parent[ulp_u] = ulp_v;
        else {
            parent[ulp_v] = ulp_u;
            rank[ulp_u]++;
        }
    }

    vector<bool> distanceLimitedPathsExist(int n, vector<vector<int>>& edgeList, vector<vector<int>>& queries) {
        int m = queries.size(), p = 0;

        // Adaugare un al patrulea element pentru fiecare interogare, reprezentand indexul interogarii
        for (int i = 0; i < m; i++)
            queries[i].push_back(i);

        // Sortare listei de muchii si a interogarilor in functie de al treilea element al fiecarui vector
        sort(edgeList.begin(), edgeList.end(), cmp);
        sort(queries.begin(), queries.end(), cmp);

        // Initializare vector de raspunsuri, vectori de parinti si ranguri
        vector<bool> ans(m);
        vector<int> parent(n), rank(n);
        for (int i = 0; i < n; i++)
            parent[i] = i;

        // Iterare prin interogari si realizarea union si verificare
        for (auto q : queries) {
            while (p < edgeList.size() && edgeList[p][2] < q[2]) {
                unionn(edgeList[p][0], edgeList[p][1], parent, rank), p++;
            }
            ans[q[3]] = find_parent(q[0], parent) == find_parent(q[1], parent);
        }
        return ans;
    }
};
