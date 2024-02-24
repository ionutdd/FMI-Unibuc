//Alg lui Prim in O(N^2)

#include <fstream>
#include <cmath>
#include <iomanip>

using namespace std;

#define infinity 1e18

// Structura pentru a reprezenta o localitate cu coordonatele x si y
struct localitate 
{
    double x, y;
};

localitate a[3001];

// Functie pentru calculul distantei euclidiene dintre doua localitati
double dist(localitate a, localitate b)
{
    return sqrt((a.x - b.x) * (a.x - b.x) + (a.y - b.y) * (a.y - b.y));
}

// Vector pentru stocarea distantelor minime pana la fiecare localitate
double d[3001];

// Vector pentru marcarea localitatilor vizitate
bool vis[3001];

ifstream f("cablaj.in");
ofstream g("cablaj.out");

int main()
{

    int n;
    f >> n;

    // Citirea coordonatelor fiecarei localitati si initializarea vectorului de distante cu infinit
    for (int i = 0; i < n; i++)
    {
        f >> a[i].x >> a[i].y;
        d[i] = infinity;
    }

    // Setarea distantei minime pana la prima localitate ca fiind 0
    d[0] = 0;

    double sol = 0;

    // Parcurgerea fiecarei localitati pentru a calcula costul minim al cablajului
    for (int i = 0; i < n; i++)
    {
        // Initializarea minimului cu infinit si pozitia cu -1
        double minim = infinity;
        int pos = -1;

        // Gasirea localitatii nevizitate cu distanta minima
        for (int j = 0; j < n; j++)
        {
            if (!vis[j] && d[j] < minim)
            {
                minim = d[j];
                pos = j;
            }
        }

        // Adaugarea costului minim la solutie
        sol += minim;

        // Marcarea localitatii ca vizitata
        vis[pos] = 1;

        // Actualizarea distantei minime pana la fiecare localitate nevizitata
        for (int j = 0; j < n; j++)
        {
            if (!vis[j] && d[j] > dist(a[pos], a[j]))
                d[j] = dist(a[pos], a[j]);
        }
    }

    g << fixed << setprecision(4) << sol;
}



