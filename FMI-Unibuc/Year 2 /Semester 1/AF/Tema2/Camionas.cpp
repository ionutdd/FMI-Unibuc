//cu Dykstra vom implementa noi, dam cost 0 la muchiile care au greutate mai mare, 1 cost mai mic, si ramane shortest path de la nodul 1 la n
//se poate si cu un BFS de 0,1 (costuri la muchii)

#include <fstream>
#include <vector>
#include <set>
using namespace std;

#define infinity 1e9

vector<pair<int, int>> G[50001];
int d[50001];
bool vis[50001];

ifstream f("camionas.in");
ofstream g("camionas.out");

int main()
{
	int n, m, k;
	f >> n >> m >> k;
	while (m--)
	{
		int x, y, c;
		f >> x >> y >> c;
		if (c < k)
			c = 1;
		else
			c = 0;
		G[x].push_back({ y, c });
		G[y].push_back({ x, c });
	}

	for (int i = 1; i <= n; i++)
		d[i] = infinity;

	set<pair<int, int>>s;
	d[1] = 0;
	s.insert({ d[1], 1 });
	while (!s.empty())
	{
		auto it = s.begin();
		s.erase(it);
		int node = (*it).second;
		if (vis[node])
			continue;
		vis[node] = 1;
		for (auto next : G[node])
		{
			if (!vis[next.first] && d[next.first] > d[node] + next.second)
			{
				d[next.first] = d[node] + next.second;
				s.insert({ d[next.first], next.first });
			}
		}

	}
	g << d[n];
}


