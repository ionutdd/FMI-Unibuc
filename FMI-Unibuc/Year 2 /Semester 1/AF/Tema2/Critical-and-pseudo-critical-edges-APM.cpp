#include <iostream>
#include <vector>
#include <queue>

using namespace std;

#define inf 1e9

class Solution {
public:

    vector<vector<int>> findCriticalAndPseudoCriticalEdges(int n, vector<vector<int>>& edges) {
        // Construirea grafului neorientat ponderat
        vector<vector<pair<int, int>>> g(n);
        for (auto& e : edges) {
            int u = e[0], v = e[1], w = e[2];
            g[u].emplace_back(v, w);
            g[v].emplace_back(u, w);
        }
        
        // Vectorul de rezultate, cu doi subvectori: pentru muchiile critice si cele pseudo-critice
        vector<vector<int>> ans(2);
        
        // Parcurgerea fiecarei muchii pentru a determina cele critice si pseudo-critice
        for (int i = 0; i < edges.size(); i++) {
            auto& e = edges[i];
            int u = e[0], v = e[1], w = e[2];
            
            // Calculul celei mai scurte distante făra considerarea muchiei curente
            int m = shortestPathWithExclusion(g, u, v);
            
            // Verificarea daca muchia este critică sau pseudo-critica și adaugarea în vectorul corespunzator
            if (w < m) {
                ans[0].push_back(i); // Muchie critica
            }
            else if (w == m) {
                ans[1].push_back(i); // Muchie pseudo-critica
            }
        }
        
        return ans;
    }

    // Functie pentru calculul celei mai scurte distante intre doua noduri, excluzand o anumita muchie
    int shortestPathWithExclusion(vector<vector<pair<int, int>>>& g, int src, int dst) {
        vector<int> dist(g.size(), inf);
        priority_queue<pair<int, int>> pq;
        pq.emplace(dist[src] = 0, src);
        
        // Algoritmul Dijkstra pentru determinarea celei mai scurte distante
        while (!pq.empty()) {
            auto [priority, u] = pq.top(); pq.pop();
            if (-priority > dist[u]) {
                continue;
            }
            for (auto& [v, w] : g[u]) {
                if (u == src && v == dst) {
                    continue;
                }
                if (dist[v] > max(dist[u], w)) {
                    dist[v] = max(dist[u], w);
                    pq.emplace(-dist[v], v);
                }
            }
        }
        
        return dist[dst];
    }
};
