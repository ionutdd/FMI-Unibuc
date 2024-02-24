#include <iostream>
#include <vector>
#include <queue>

using namespace std;

class Solution {
public:
    int shortestPathLength(vector<vector<int>>& graph) 
    {
        int n = graph.size();
        int CONF = (1 << n) - 1;
        queue<pair<int, pair<int, int>>> q;

        // Matrice pentru a marca nodurile vizitate
        vector<vector<bool>> visited(CONF + 1, vector<bool>(n, false));

        // Initializare coada cu nodurile initiale
        for (int node = 0; node < n; node++)
        {
            int origCONF = (1 << node);
            q.push({ node, {origCONF, 1} });
            visited[origCONF][node] = true;
        }

        while (!q.empty())
        {
            auto curr = q.front();
            q.pop();

            int currNode = curr.first;
            int currCONF = curr.second.first;
            int currLength = curr.second.second;

            // Verificare daca s-au atins toate nodurile
            if (currCONF == CONF)
                return currLength - 1;

            // Iterare prin vecinii nodului curent
            for (int i = 0; i < graph[currNode].size(); i++)
            {
                int neighbor = graph[currNode][i];
                int newCONF = currCONF | (1 << neighbor);

                // Verificare daca vecinul a fost deja vizitat
                if (visited[newCONF][neighbor])
                    continue;

                // Adaugare vecin in coada pentru a-l verifica ulterior
                q.push({ neighbor, {newCONF, currLength + 1} });
                visited[newCONF][neighbor] = true;
            }
        }

        // Nu s-a gasit drum
        return -1;
    }
};
