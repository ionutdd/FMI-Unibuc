#include <fstream>
#include <queue>

using namespace std;

ifstream input("padure.in");
ofstream output("padure.out");
const int maxn = 1001;

int dx[4] = { 1, 0, -1, 0 }; 
int dy[4] = { 0, -1, 0, 1 }; 
int start_x, start_y, end_x, end_y, rows, cols; 
vector<vector<int>> forest(maxn, vector<int>(maxn, 0)); 
vector<vector<int>> shortestDistance(maxn, vector<int>(maxn, 2147483647));

deque<pair<int, int>> Q; // Queue pt BFS

bool isValid(int x, int y) { //sa nu dam overflow din matrice
    return x >= 1 && y >= 1 && x <= rows && y <= cols;
}

void BFS() {
    Q.push_back(make_pair(start_x, start_y));
    shortestDistance[start_x][start_y] = 0;

    while (!Q.empty()) {
        int x = Q.front().first;
        int y = Q.front().second;
        Q.pop_front();

        for (int dir = 0; dir < 4; dir++) {
            int new_x = x + dx[dir];
            int new_y = y + dy[dir];

            if (isValid(new_x, new_y) && forest[new_x][new_y] != forest[x][y]) {
                if (shortestDistance[new_x][new_y] > shortestDistance[x][y] + 1) {
                    shortestDistance[new_x][new_y] = shortestDistance[x][y] + 1;
                    if (new_x != end_x || new_y != end_y)
                        Q.push_back(make_pair(new_x, new_y));
                }
            }
            else {
                if (isValid(new_x, new_y) && shortestDistance[new_x][new_y] > shortestDistance[x][y]) {
                    shortestDistance[new_x][new_y] = shortestDistance[x][y];
                    if (new_x != end_x || new_y != end_y)
                        Q.push_front(make_pair(new_x, new_y));
                }
            }
        }
    }
}

int main() {

    input >> rows >> cols >> start_x >> start_y >> end_x >> end_y;

    for (int i = 1; i <= rows; i++) {
        for (int j = 1; j <= cols; j++) {
            input >> forest[i][j];
            shortestDistance[i][j] = 2147483647;
        }
    }

    BFS();
    output << shortestDistance[end_x][end_y];

    return 0;
}
