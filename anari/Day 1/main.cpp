#include <iostream>
#include <vector>
#include <algorithm>
#include <cmath>
#include <string>
#include <sstream>
#include <cstdlib>
#include <fstream>  
using namespace std;

int calculateDistance (vector<int> list1, vector<int> list2) {
    int totalDistance = 0;

    for (size_t i = 0; i < list1.size(); ++i) {
        totalDistance += abs(list1[i] - list2[i]);
    }

    return totalDistance;
}

int calculateSimilarity(vector<int> list1, vector<int> list2) {
    int similarityScore = 0;
    for (int num : list1) {
        int numCount = std::count(list2.begin(), list2.end(), num);
        similarityScore += num * numCount;
    }
    return similarityScore;
}

int main() {
    vector<int> list1, list2;
    string line;
    int number;
    int distance;

    ifstream inputFile("input.txt");
    while (getline(inputFile, line)) {
        istringstream stream(line);
        int num1, num2;
        if (stream >> num1 >> num2) {
            list1.push_back(num1);
            list2.push_back(num2);
        }
    }

    inputFile.close();



    sort(list1.begin(), list1.end());
    sort(list2.begin(), list2.end());

    cout <<calculateDistance(list1, list2) << endl;
    cout <<calculateSimilarity(list1, list2) << endl;
}