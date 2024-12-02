#include <iostream>
#include <vector>
#include <algorithm>
#include <cmath>
#include <string>
#include <sstream>

using namespace std;

int calculateDistance (vector<int> list1, vector<int> list2) {
    int totalDistance = 0;

    for (size_t i = 0; i < list1.size(); ++i) {
        totalDistance += abs(list1[i] - list2[i]);
    }

    return totalDistance;
}

int main() {

    vector<int> list1, list2;
    string line;
    int number;
    int distance;

    cout << "Enter numbers for left list, seperate it by spaces plzzzz ";
    getline(cin, line);
    istringstream stream1(line);
    while (stream1 >> number) {
        list1.push_back(number);
    }

    cout << "Enter numbers for right list, seperate it by spaces plzzzz ";
    getline(cin, line);
    istringstream stream2(line);
    while (stream2 >> number) {
        list2.push_back(number);
    }

    cout << "List 1: ";
    for (int num : list1) {
        cout << num << " ";
    }
    cout << endl;

    cout << "List 2: ";
    for (int num : list2) {
        cout << num << " ";
    }
    cout << endl;

    sort(list1.begin(), list1.end());
    sort(list2.begin(), list2.end());

    cout <<calculateDistance(list1, list2) << endl;
}