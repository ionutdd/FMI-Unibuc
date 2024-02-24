#include <iostream>

class Solution {
public:
    vector<int> eventualSafeNodes(vector<vector<int>>& graph) {
        int n = graph.size();

        vector<int> adjRev[n];

        vector<int> indegree;
        indegree.resize(n + 1);
        for (int i = 0; i < n; i++)
            indegree[i] = 0;


        for (int i = 0; i < n; i++)
        {
            for (auto item : graph[i])
            {
                adjRev[item].push_back(i);
                indegree[i]++;
            }
        }

        queue<int> q;
        vector<int> safeNodes;


        for (int i = 0; i < n; i++)
        {
            if (indegree[i] == 0)
            {
                q.push(i);
            }
        }

        while (!q.empty())
        {

            int node = q.front();
            q.pop();

            safeNodes.push_back(node);

            for (auto neighbour : adjRev[node])
            {
                indegree[neighbour]--;
                if (indegree[neighbour] == 0)
                    q.push(neighbour);
            }
        }

        sort(safeNodes.begin(), safeNodes.end());

        return safeNodes;
    }
};