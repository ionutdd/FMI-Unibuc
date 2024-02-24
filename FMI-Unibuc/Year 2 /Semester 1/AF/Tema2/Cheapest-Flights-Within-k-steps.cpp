#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    // Structura pentru a reprezenta un nod in graf
    struct Node {
        int cost;    // Costul total pana la acest nod
        int city;    // Orasul curent
        int stops;   // Numarul de opriri pana la acest nod

        Node(int c, int u, int s) : cost(c), city(u), stops(s) {}

        // Supraincarcarea operatorului > pentru sortare in coada
        bool operator>(const Node& other) const {
            return cost > other.cost;
        }
    };

    int findCheapestPrice(int n, vector<vector<int>>& flights, int src, int dst, int k) {
        // Construirea listei de adiacenta ponderata
        vector<vector<pair<int, int>>> graph(n);

        for (const auto& flight : flights) {
            int u = flight[0];
            int v = flight[1];
            int cost = flight[2];
            graph[u].emplace_back(v, cost);
        }

        // Vector pentru a stoca distantele minime pana la fiecare oras
        vector<int> dist(n, numeric_limits<int>::max());

        // Coada pentru BFS
        queue<pair<int, int>> q;
        q.push({ src, 0 });
        int stops = 0;

        // BFS
        while (stops <= k && !q.empty()) {
            int sz = q.size();
            while (sz--) {
                auto [node, distance] = q.front();
                q.pop();
                for (auto& [neighbour, price] : graph[node]) {
                    if (price + distance < dist[neighbour]) {
                        dist[neighbour] = price + distance;
                        q.push({ neighbour, dist[neighbour] });
                    }
                }
            }
            stops++;
        }

        // Returneaza rezultatul (cel mai ieftin pret) sau -1 daca nu exista o cale valida
        return (dist[dst] == numeric_limits<int>::max()) ? -1 : dist[dst];
    }
};
