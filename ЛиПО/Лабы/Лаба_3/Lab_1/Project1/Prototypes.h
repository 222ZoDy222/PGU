#pragma once



lecsem* CreateArrayOfLecsems();


/*
                  _        _
                 | |      | |
  _ __  _ __ ___ | |_ ___ | |_ _   _ _ __   ___  ___
 | '_ \| '__/ _ \| __/ _ \| __| | | | '_ \ / _ \/ __|
 | |_) | | | (_) | || (_) | |_| |_| | |_) |  __/\__ \
 | .__/|_|  \___/ \__\___/ \__|\__, | .__/ \___||___/
 | |                            __/ | |
 |_|                           |___/|_|


*/


//bool IsCutSymbol(char s, bool check);

bool SyntaxCheck(char* buf, int length);

std::vector<Word> GetWords(char* buf, int length);

void PrintLecsems(std::vector<Word>& words);
//bool shouldReadNextSymbol(char* buf);

bool IsAlphabet(char s);
bool IsNumber(char s);

bool IsIdentificatedLecsem(string word);

void CreateLecsems();
void SetTypes(std::vector<Word>& words);

void SyntaxAnalizator(std::vector<Word> words);
////////////////////////////////////////////
////////////////////////////////////////////
////////////////////////////////////////////
