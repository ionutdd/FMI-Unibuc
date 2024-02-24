#include <iostream>    
#include <vector>      

using namespace std;   

vector<vector<int>> graph; 

// DFS pentru calculul distantelor
void dfs(int current_node, int parent, vector<int>& distances) {
    if (parent != -1)
        distances[current_node] = distances[parent] + 1; // Daca nodul nu este radacina, seteaza distanta ca distanta de la parinte + 1

    for (int neighbor : graph[current_node]) {
        if (neighbor != parent) {
            dfs(neighbor, current_node, distances); // Viziteaza recursiv toti vecinii nodului curent
        }
    }
}

int main() {
    int test_cases;
    cin >> test_cases; // Citeste numarul de test caseuri

    while (test_cases--) {
        int num_nodes, num_visited_nodes;
        cin >> num_nodes >> num_visited_nodes; // Citeste numarul total de noduri si numarul de noduri marcate

        graph.assign(num_nodes, vector<int>(0)); 

        vector<int> visited_nodes(num_visited_nodes);

        for (int& node : visited_nodes) {
            cin >> node;   // Citeste nodurile marcate
            --node;         // 0 index
        }

        for (int i = 1; i < num_nodes; i++) {
            int u, v;
            cin >> u >> v;  // Muchiile grafului
            --u, --v;       // 0 index
            graph[u].push_back(v);  
            graph[v].push_back(u);  
        }

        if (num_visited_nodes == 1) {
            cout << 0 << endl; // Cdt pt distanta 0 !!!
            continue;
        }

        vector<int> distances_from_start(num_nodes);
        dfs(visited_nodes[0], -1, distances_from_start); // Calculeaza distantele de la primul nod vizitat la celelalte noduri

        int max_distance_node = visited_nodes[0];
        for (int node : visited_nodes) {
            if (distances_from_start[node] > distances_from_start[max_distance_node]) {
                max_distance_node = node; // Nodul cu distanta maxima care e si marcat fata de primul nod vizitat
            }
        }

        vector<int> distances_from_max_node(num_nodes);
        dfs(max_distance_node, -1, distances_from_max_node); // Calculeaza distantele de la nodul cu distanta maxima

        max_distance_node = visited_nodes[0];
        for (int node : visited_nodes) {
            if (distances_from_max_node[node] > distances_from_max_node[max_distance_node]) {
                max_distance_node = node; // Nodul cu distanta maxima de la nodul cu distanta maxima
            }
        }

        cout << (distances_from_max_node[max_distance_node] + 1) / 2 << endl; // Afiseaza distanta minima maxima (rezultatul final)
    }

    return 0; // Returneaza 0 pentru a indica succesul executiei programului
}
