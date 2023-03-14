#pragma once
#include "Main.h"
#include <map>
void CreatePostfix(std::vector<vector<Word>> resultExpression);
std::vector<Word> postfics(std::vector<Word> vlex);
using std::map;
vector<Word> infixToPostfix(vector<Word> s);