#include <iostream>
#include <vector>

using namespace std;

const int N = 200100;

int color[N]; 
vector<int> adj[N]; //lista de adiac

//e bipartit? si asignam culori
void bipartit(int s, int col) {
    color[s] = col; // assignam culoarea nodului curent

    // iteram prin toate nodurile adiacente nodului nostru
    for (auto e : adj[s]) {
        if (color[e] == -1) // daca nu e colorat
            bipartit(e, 1 - col); // apelam recursiv cu culoarea inversa
        else {
            if (color[e] == color[s]) { // daca au cumva asignate aceeasi culoare clar nu e bipartit
                cout << "NO" << endl;
                exit(0); 
            }
        }
    }
}

int main() {
    int n, m;
    cin >> n >> m; 

    vector<pair<int, int>> vec; 


    for (int i = 0; i < m; i++) {
        int u, v;
        cin >> u >> v;
        adj[u].push_back(v);
        adj[v].push_back(u);
        vec.push_back(make_pair(u, v)); 
    }

    fill(color, color + N, -1); 

    bipartit(1, 0); 

    cout << "YES" << endl; // Graf bipartit

    for (int i = 0; i < m; i++)
        cout << (color[vec[i].first] < color[vec[i].second]); // 0 sau 1 bazat pe culoarea dintre vecini

    return 0;
}
