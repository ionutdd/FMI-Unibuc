#include <iostream>

class Solution {
public:
    vector<int> parent;

    bool equationsPossible(vector<string>& equations) {
        parent.resize(26);
        iota(parent.begin(), parent.end(), 0); // Initializam fiecare variabila drept fiind parintele lui

        // Union pt "==" 
        for (const string& equation : equations)
            if (equation[1] == '=')
            {
                int x = equation[0] - 'a';
                int y = equation[3] - 'a';
                int parentX = find(x);
                int parentY = find(y);

                if (parentX != parentY)
                    parent[parentX] = parentY; // Union 

            }


        for (const string& equation : equations)
            if (equation[1] == '!')
            {
                int x = equation[0] - 'a';
                int y = equation[3] - 'a';
                int parentX = find(x);
                int parentY = find(y);

                if (parentX == parentY)
                    return false;

            }

        return true;
    }

    int find(int x)
    {
        if (x != parent[x])
            parent[x] = find(parent[x]);

        return parent[x];
    }
};