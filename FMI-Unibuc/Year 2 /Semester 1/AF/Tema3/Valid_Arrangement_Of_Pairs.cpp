#include <iostream>
#include <unordered_map>
#include <vector>
#include <stack>

using namespace std;

class Solution {
public:
    vector<vector<int>> validArrangement(vector<vector<int>>& pairs) 
    {
        int m = pairs.size();
        // Drum Eulerian 
        unordered_map<int, stack<int>> adj;
        unordered_map<int, int> in;
        unordered_map<int, int> out;

        // Rezervare spatiu pentru evitarea realocarilor
        adj.reserve(m);
        in.reserve(m);
        out.reserve(m);

        // Construirea grafului
        for (int i = 0; i < m; i++) 
        {
            int u = pairs[i][0], v = pairs[i][1];
            in[v]++;
            out[u]++;
            adj[u].push(v);
        }

        int start = -1;
        // Determinare nod de inceput pentru Drumul Eulerian 
        for (auto& p : adj) 
        {
            int i = p.first;
            if (out[i] - in[i] == 1)
                start = i;
        }

        if (start == -1) 
            start = adj.begin()->first;
        

        vector<vector<int>> ans;
        // Apelarea functiei pentru construirea Drumului Eulerian 
        euler(adj, ans, start);

        // Inversarea rezultatului pentru a obtine ordinea corecta
        reverse(ans.begin(), ans.end());

        return ans;
    }

    // Functie recursiva pentru construirea Drumului Eulerian 
    void euler(unordered_map<int, stack<int>>& adj, vector<vector<int>>& ans, int curr) 
    {
        auto& stk = adj[curr];
        while (!stk.empty()) 
        {
            int nei = stk.top();
            stk.pop();
            euler(adj, ans, nei);
            ans.push_back({ curr, nei });
        }
    }
};
