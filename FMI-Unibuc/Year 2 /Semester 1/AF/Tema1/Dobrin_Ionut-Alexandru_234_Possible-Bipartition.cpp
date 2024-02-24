#include <iostream>

class Solution {
public:
    bool possibleBipartition(int n, vector<vector<int>>& dislikes) {
        if (dislikes.size() == 0)
            return true;
        vector<int> colorArr;
        colorArr.resize(n + 1);
        for (int i = 1; i <= n; i++)
            colorArr[i] = -1;

        colorArr[1] = 1;

        queue<int> q;
        q.push(1);

        while (!q.empty())
        {
            int u = q.front();
            q.pop();
            for (int i = 0; i < dislikes.size(); i++)
            {
                if (dislikes[i][0] == u)
                {
                    if (colorArr[dislikes[i][1]] == -1)
                    {
                        colorArr[dislikes[i][1]] = 1 - colorArr[u];
                        q.push(dislikes[i][1]);
                    }
                    else
                        if (colorArr[dislikes[i][1]] == colorArr[dislikes[i][0]])
                            return false;
                }

                if (dislikes[i][1] == u)
                {
                    if (colorArr[dislikes[i][0]] == -1)
                    {
                        colorArr[dislikes[i][0]] = 1 - colorArr[u];
                        q.push(dislikes[i][0]);
                    }
                    else
                        if (colorArr[dislikes[i][1]] == colorArr[dislikes[i][0]])
                            return false;
                }
            }
            if (q.empty())
                for (int i = 2; i <= n; i++)
                    if (colorArr[i] == -1)
                    {
                        q.push(i);
                        colorArr[i] = 1;
                        break;
                    }
        }

        return true;
    }
};
