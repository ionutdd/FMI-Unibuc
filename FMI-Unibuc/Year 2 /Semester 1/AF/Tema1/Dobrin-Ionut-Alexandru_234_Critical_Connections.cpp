#include <iostream>

class Solution {
    vector<vector<int>> res;
    vector<int> low;
    vector<int> vis;
    vector<int> niv;
    vector<int> G[200001];
public:

    vector<vector<int>> criticalConnections(int n, vector<vector<int>>& connections) {
        int m;
        low.resize(n + 1, 0);
        vis.resize(n + 1, 0);
        niv.resize(n + 1, 0);
        m = connections.size();
        for (int i = 1; i <= m; i++)
        {
            int x, y;
            //cin >> x >> y;
            x = connections[i - 1][0];
            y = connections[i - 1][1];
            G[x + 1].push_back(y + 1);
            G[y + 1].push_back(x + 1);
        }
        DFS(1, 0);
        return res;
    }
    void DFS(int x, int p)
    {
        niv[x] = niv[p] + 1;
        vis[x] = 1;
        low[x] = niv[x];
        for (auto next : G[x])
        {
            if (next == p)
                continue;
            if (vis[next])
                low[x] = min(low[x], niv[next]);
            else
            {
                DFS(next, x);
                low[x] = min(low[x], low[next]);
                //cout << low[next] << ' ' << niv[x] << '\n';
                if (low[next] > niv[x])
                {
                    vector<int> a;
                    a.push_back(x - 1);
                    a.push_back(next - 1);
                    res.push_back(a);
                }
            }
        }
    }
};
