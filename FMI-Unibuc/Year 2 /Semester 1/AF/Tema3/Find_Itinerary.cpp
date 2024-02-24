#include <iostream>
#include <unordered_map>
#include <vector>
#include <set>

using namespace std;

class Solution {
public:
    vector<string> findItinerary(vector<vector<string>>& tickets) {
        // Graful este reprezentat printr-un unordered_map cu cheia fiind aeroportul de plecare
        // si valorile fiind un multiset de aeroporturi de destinatie
        unordered_map<string, multiset<string>> graph;

        // Construirea grafului pe baza biletelor primite ca input
        for (auto ticket : tickets) {
            graph[ticket[0]].insert(ticket[1]);
        }

        // Vectorul care va contine itinerariul
        vector<string> path;

        // Apelul functiei recursive pentru construirea itinerariului
        builtItn("JFK", graph, path);

        // Returnarea itinerariului inversat
        return vector<string>(path.rbegin(), path.rend());
    }

    // Functie recursiva pentru construirea itinerariului
    void builtItn(string src, unordered_map<string, multiset<string>>& graph, vector<string>& path) {
        // Cat timp exista aeroporturi de destinatie pentru aeroportul de plecare dat
        while (graph[src].size()) {
            // Selectarea urmatorului aeroport de destinatie
            string next = *graph[src].begin();

            // Eliminarea aeroportului selectat din multiset
            graph[src].erase(graph[src].begin());

            // Apelul recursiv pentru a construi itinerariul
            builtItn(next, graph, path);
        }

        // Adaugarea aeroportului de plecare la itinerariu
        path.push_back(src);
    }
};
