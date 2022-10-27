#pragma once
#include <iostream>
using namespace std;

struct lecsem {
	string name;
	int type;
};



class Word {
public:
    string word;
    int rowNum;


    Word(string w, int n) {
        this->word = w;
        this->rowNum = n;
    }

    string GetWord() {
        return word;
    }

};






