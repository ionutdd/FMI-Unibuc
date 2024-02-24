//https://leetcode.com/problems/course-schedule-ii/submissions/

#include <iostream>

class Solution {
public:
    vector<int> findOrder(int numCourses, vector<vector<int>>& prerequisites) {
        int n = numCourses;
        int m = prerequisites.size();
        int nmax = 2000;
        vector <int> g[nmax + 1];
        int d[2001] = { 0 };

        int i = 0;
        while (m--)
        {
            int x = prerequisites[i][0];
            int y = prerequisites[i][1];
            g[y].push_back(x);
            d[x]++;
            i++;
        }

        queue <int> q;
        vector <int> topsort;

        for (int i = 0; i < n; i++)
        {
            if (d[i] == 0)
                q.push(i);
        }
        int counter = 0;
        while (!q.empty())
        {
            int x = q.front();
            q.pop();
            topsort.push_back(x);
            for (auto next : g[x])
            {
                d[next]--;
                if (d[next] == 0)
                {
                    counter++;
                    q.push(next);
                }
            }
        }
        if (m == 0)
        {
            vector<int> ans;
            for (int i = 0; i < n; i++)
                ans.push_back(i);
            return ans;
        }
        if (topsort.size() != n)
            return vector<int>();
        return topsort;
    }
};


