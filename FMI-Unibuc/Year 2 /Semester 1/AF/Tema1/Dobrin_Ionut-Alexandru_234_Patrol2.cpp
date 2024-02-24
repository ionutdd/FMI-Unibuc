#include <fstream> 
#include <vector>  
#include <queue>   
#include <algorithm> 

using namespace std; 

ifstream input("patrol2.in"); 
ofstream output("patrol2.out"); 

vector<int> graph[10001]; 
vector<vector<int>> patrolTime(10001, vector<int>(421, 0)); 
int cycleLength; //Lung ciclului

const int INF = 2147483647; 

void bfs(int node, int time) {
    queue<pair<int, int>> q; // Coada pt parcurgerea in latime
    q.push(make_pair(node, time)); // Ad nodul de start si timpul in coada
    patrolTime[node][time] = 1; // Seteaza timpul petrecut la nodul de start la 1

    while (!q.empty()) { 
        int currentNode = q.front().first; // Extrage nodul curent din coada
        int currentTime = q.front().second; // Extrage timpul curent din coada
        int nextTime = (currentTime + 1) % cycleLength; // Calculeaza urmatorul timp in functie de lungimea ciclului

        for (int i = 0; i < graph[currentNode].size(); i++) { // Parcurge vecinii nodului curent
            int nextNode = graph[currentNode][i]; // Extrage urmatorul nod
            if (patrolTime[nextNode][nextTime] == 0) { // Daca timpul la urmatorul nod nu este setat
                patrolTime[nextNode][nextTime] = patrolTime[currentNode][currentTime] + 1; // Seteaza timpul la urmatorul nod
                q.push(make_pair(nextNode, nextTime)); // Adauga urmatorul nod in coada
            }
        }

        if (patrolTime[currentNode][nextTime] == 0) { // Daca timpul la nodul curent pentru urmatorul timp nu este setat
            patrolTime[currentNode][nextTime] = patrolTime[currentNode][currentTime] + 1; // Seteaza timpul la nodul curent pentru urmatorul timp
            q.push(make_pair(currentNode, nextTime)); // Adauga nodul curent in coada
        }

        q.pop(); // Scoate nodul curent din coada
    }
}

int main() {
    int manholes, tunnels, patrols, minMinutes = INF; 
    cycleLength = 420; // Seteaza lung ciclului la 420 (cmmmc de 1-->7)
    input >> manholes >> tunnels >> patrols; 

    for (int i = 1; i <= tunnels; i++) { 
        int u, v;
        input >> u >> v; 
        graph[u].push_back(v); 
        graph[v].push_back(u); 
    }

    for (int i = 1; i <= patrols; i++) { 
        int patrolLength;
        input >> patrolLength; 
        vector<int> patrolManholes; 

        for (int j = 0; j < patrolLength; j++) { 
            int manhole;
            input >> manhole;
            patrolManholes.push_back(manhole); // Adauga canalizarea la lista de canalizari din patrula respectiva
        }

        for (int j = 0; j < 420; j++) { // Parcurge fiecare timp din patrula
            patrolTime[patrolManholes[j % patrolLength]][j] = -1; // Seteaza timpul la manhole-urile din patrula la -1
        }
    }

    bfs(0, 0); 

    for (int i = 0; i < cycleLength; i++) { // Parcurge fiecare timp din ciclu
        if (patrolTime[manholes - 1][i] != 0 && patrolTime[manholes - 1][i] != -1) { // Daca timpul la ultimul manhole nu este 0 si nu este -1
            if (patrolTime[manholes - 1][i] < minMinutes) { // Daca timpul este mai mic decat timpul minim anterior
                minMinutes = patrolTime[manholes - 1][i]; // Actualizeaza timpul minim
            }
        }
    }

    if (minMinutes == INF) { // Fara solutie
        output << -1; 
    }
    else {
        output << minMinutes - 1; 
    }

    return 0; 
}
