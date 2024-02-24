#include <iostream>
#include <vector>

using namespace std;

class Solution {
public:
    string shortestSuperstring(vector<string>& A) 
    {
        int n = A.size();

        // Matricea pentru stocarea concatenarilor posibile
        vector<vector<string>> CONF(1 << n, vector<string>(n));

        // Matricea pentru stocarea lungimii intersectiilor dintre siruri
        vector<vector<int>> intersectie(n, vector<int>(n, 0));

        // Calculul intersectiilor dintre siruri
        for (int i = 0; i < n; i++)
            for (int j = 0; j < n; j++)
                if (i != j)
                {
                    for (int k = min(A[i].size(), A[j].size()); k > 0; k--)
                        if (A[i].substr(A[i].size() - k) == A[j].substr(0, k))
                        {
                            intersectie[i][j] = k;
                            break;
                        }
                }

        // Initializarea cazului de baza pentru fiecare sir
        for (int i = 0; i < n; ++i)
            CONF[1 << i][i] += A[i];

        // Calculul concatenarilor posibile
        for (int mask = 1; mask < (1 << n); mask++)
        {
            for (int j = 0; j < n; j++)
                if ((mask & (1 << j)) > 0)
                {
                    for (int i = 0; i < n; i++)
                        if (i != j && (mask & (1 << i)) > 0)
                        {
                            // Actualizarea concatenarilor optime
                            string tmp = CONF[mask ^ (1 << j)][i] + A[j].substr(intersectie[i][j]);
                            if (CONF[mask][j].empty() || tmp.size() < CONF[mask][j].size())
                                CONF[mask][j] = tmp;
                        }
                }
        }

        // Determinarea celei mai scurte supersecvente finale
        int utlim = (1 << n) - 1;
        string sol = CONF[utlim][0];
        for (int i = 1; i < n; i++)
            if (CONF[utlim][i].size() < sol.size())
                sol = CONF[utlim][i];

        return sol;
    }
};
