#include <iostream>

class Solution {
public:
    int shortestBridge(vector<vector<int>>& grid) {
        int n = grid.size();
        int m = grid[0].size();

        // Gasim prima insula si o vizitam cu DFS
        bool foundIsland = false;
        for (int i = 0; i < n && !foundIsland; i++)
            for (int j = 0; j < m && !foundIsland; j++)
                if (grid[i][j] == 1)
                {
                    dfs(grid, i, j);
                    foundIsland = true;
                }

        // BFS sa extindem de la prima la a doua insula
        queue<pair<int, int>> q;
        vector<vector<int>> directions = { {0, 1}, {0, -1}, {1, 0}, {-1, 0} };
        vector<vector<bool>> visited(n, vector<bool>(m, false));

        // Adaugam celulele primei insule la vizitat
        for (int i = 0; i < n; i++)
            for (int j = 0; j < m; j++)
                if (grid[i][j] == 2) {
                    q.push({ i, j });
                    visited[i][j] = true;
                }


        int distance = 0;

        while (!q.empty())
        {
            int size = q.size();
            for (int i = 0; i < size; i++)
            {
                int x = q.front().first;
                int y = q.front().second;
                q.pop();

                for (const vector<int>& dir : directions)
                {
                    int newX = x + dir[0];
                    int newY = y + dir[1];

                    if (newX >= 0 && newX < n && newY >= 0 && newY < m && !visited[newX][newY])
                    {
                        if (grid[newX][newY] == 1)
                            return distance;

                        q.push({ newX, newY });
                        visited[newX][newY] = true;
                    }
                }
            }

            distance++;
        }

        return -1; //nu trebuie sa ajungem aici
    }


    void dfs(vector<vector<int>>& grid, int x, int y)
    {
        int n = grid.size();
        int m = grid[0].size();

        if (x < 0 || x >= n || y < 0 || y >= m || grid[x][y] != 1) {
            return;
        }

        grid[x][y] = 2; // Marchez ca vizitat
        dfs(grid, x + 1, y);
        dfs(grid, x - 1, y);
        dfs(grid, x, y + 1);
        dfs(grid, x, y - 1);
    }
};