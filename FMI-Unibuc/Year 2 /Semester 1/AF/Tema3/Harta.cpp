// greedy in O(n^2 * log n)
// sortam la fiecare pas nodurile descrescator in functie de gradul ramas
// iar apoi cuplam cate 2 noduri daca au gradele > 0


#include <fstream>
#include <vector>
#include <algorithm>

using namespace std;

ifstream f("harta.in");
ofstream g("harta.out");

int n;
vector<pair<int, int>> grad;

bool cmp(int a, int b)
{
    return grad[a] > grad[b];
}

int main()
{
    f >> n;

    // Initializarea vectorului de grade pentru fiecare nod
    grad.resize(n);

    // Citirea gradelor pentru fiecare nod
    for (int i = 0; i < n; i++)
        f >> grad[i].first >> grad[i].second;

    // Calculul numarului total de muchii necesare
    int m = 0;
    for (int i = 0; i < n; i++)
        m += grad[i].first;

    // Afisarea numarului total de muchii
    g << m << '\n';

    // Initializarea unui vector pentru a sorta nodurile
    vector<int> vecSortat(n);
    for (int i = 0; i < n; i++)
        vecSortat[i] = i;

    // Greedy pentru construirea cuplajului maxim
    for (int i = 0; i < n; i++)
    {
        // Sortarea nodurilor descrescator in functie de gradul ramas
        sort(vecSortat.begin(), vecSortat.end(), cmp);
        for (int j = 0; j < n; j++)
        {
            // Cuplarea a doua noduri daca au gradele > 0
            if (i != vecSortat[j] && grad[vecSortat[j]].first > 0 && grad[i].second > 0)
            {
                grad[vecSortat[j]].first--;
                grad[i].second--;
                g << vecSortat[j] + 1 << ' ' << i + 1 << '\n';
            }
        }
    }

    return 0;
}
