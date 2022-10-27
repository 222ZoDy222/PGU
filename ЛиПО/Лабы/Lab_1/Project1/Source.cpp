#include <iostream>
#include <vector>
#include <fstream>
#include "Lecsems.h"
#include <string>

using namespace std;

//fstream file; // создаем объект класса ifstream
    // Пример:
    // D:\\универ\\ЛиПО\\!Лабораторные\\Lab_1\\files\\prog.txt"
string filePath = "D:\\Универ\\PGU\\ЛиПО\\Лабы\\Lab_1\\files\\prog.txt";
string lecsemsPath = "D:\\Универ\\PGU\\ЛиПО\\Лабы\\Lab_1\\files\\lecsems.txt";
//file.open(filePath); // открываем файл

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

lecsem* CreateArrayOfLecsems();

string Remove_r(string str);

string GetWord(char* buf);

std::vector<Word> GetWords(char* buf, int length);

void PrintLecsems(std::vector<Word>& words);
//bool shouldReadNextSymbol(char* buf);

bool IsAlphabet(char s);
bool IsNumber(char s);

bool IsIdentificatedLecsem(string word);

////////////////////////////////////////////
////////////////////////////////////////////
////////////////////////////////////////////

lecsem lecsems[100];

lecsem Lecs[100];
int lecsLength = 0;



int main() {
    setlocale(LC_ALL, "ru");
   
    
    

    ///////////////////////////////////////////
    // Заполнение массива лексем
    ///////////////////////////////////////////


    lecsem* lecsems = CreateArrayOfLecsems();
    
    int lecsemLength = 0;
    
    for (int i = 0; i < sizeof(*lecsems); i++)
    {
        if (lecsems[0].type != 0) {
            lecsems++;
            lecsemLength++;

        }
        else {
            break;
        }
    }

    lecsem* Lecs = new lecsem[lecsemLength];
    lecsems -= lecsemLength;
    lecsLength = lecsemLength;
    for (int i = 0; i < lecsemLength; i++)
    {
        Lecs[i] = lecsems[0];
        lecsems++;
    }


    ///////////////////////////////////////////
    // ------------------------------------- //
    ///////////////////////////////////////////

    
    


    std::ifstream is(filePath, std::ifstream::ate | std::ifstream::binary);
    if (!is)
    {
        cout << "can't find file \n\n";
        return -1;
    }
    else
    {
        
        
        is.seekg(0, is.end);
        int length = is.tellg();
        is.seekg(0, is.beg);

        char* buffer = new char[length];

        std::cout << "Reading " << length << " characters... ";
        // read data as a block:
        is.read(buffer, length);
        is.close();
        if (is)
            std::cout << "all characters read successfully.";
        else
        {
            std::cout << "error: only " << is.gcount() << " could be read";
            return 0;
        }
        

        SyntaxCheck(buffer, length);
        
    }
}



bool SyntaxCheck(char * buf, int length) 
{
    char ch;                //символ, считываемый из файла
    int pos = 0;            //позиция последнего символа в собранной строке
    int number = 0;         //номер строки вектора

    std::vector<Word> words = GetWords(buf, length);

    PrintLecsems(words);

    

   
    return true;
}

void PrintLecsems(std::vector<Word>& words) {

    for (int i = 0; i < words.size(); i++)
    {
        if (IsIdentificatedLecsem(words[i].word)) {
            cout << words[i].word << " is identificated" << "\t" << " row number - " << words[i].rowNum;
        }
        else {
            cout << words[i].word << " is undeficated" << "\t" << " row number - " << words[i].rowNum;
        }
        cout << "\n";
        cout << "-----------------------------------------------";
        cout << "\n";
    }
}

bool IsIdentificatedLecsem(string word) {

    for (int i = 0; i < lecsLength; i++)
    {
        if (word == lecsems[i].name) return true;
    }
    return false;

}

std::vector<Word> GetWords(char * buf, int length) {

    std::vector<Word> words;

    string currentWord = "";
    char lastS = '\0';
    int rowNum = 0;

    for (int i = 0; i < length; i++)
    {
        if (currentWord == "\n") rowNum++;
        // Если этот символ символ алфавита
        if (IsAlphabet(buf[i])) {
            // и последний считанный символ тоже символ алфавита
            if (IsAlphabet(lastS)) {
                currentWord += buf[i];
            } // но последний считанный символ это не символ алфавита
            else {
                if (currentWord != "" && currentWord != "\r" && currentWord != "\n" && currentWord != " ") words.push_back(Word(currentWord, rowNum));
                    
                    
                
                currentWord = "";
                currentWord += buf[i];
                lastS = buf[i];
            }
        } // Если этот символ это число
        else if (IsNumber(buf[i])) {
            // и последний символ тоже число
            if (IsNumber(lastS)) {
                currentWord += buf[i];
                lastS = buf[i];
            }
            else {
                if (currentWord != "" && currentWord != "\r" && currentWord != "\n" && currentWord != " ") words.push_back(Word(currentWord, rowNum));
                currentWord = "";
                currentWord += buf[i];
                lastS = buf[i];
            }
        } // Если этот символ это не число и не буква
        else 
        {
            if (currentWord != "" && currentWord != "\r" && currentWord != "\n" && currentWord != " ") words.push_back(Word(currentWord, rowNum));
            currentWord = "";
            currentWord += buf[i];
            lastS = buf[i];
        }

    }
    return words;
    
}
string alphabet = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM";
string numbers_ = "1234567890";
/// Если check - false
/// то возвращает true при разделительном символе не равным \r \n
/// 
/// Если check - true
/// то возвращает true при любом разделительном символе 
/// и false если это не разделительный символ
bool IsAlphabet(char s) {
    
    for (int i = 0; i < alphabet.length(); i++)
    {
        if (s == alphabet[i]) return true;
    }
    return false;
}

bool IsNumber(char s) {
    for (int i = 0; i < numbers_.length(); i++)
    {
        if (s == numbers_[i]) return true;
    }
    return false;
}

string GetWord(char* buf) {
    char* word = new char[100];
    int i = 0;
    while (buf[i] != '\r' && buf[i] != '\n' && buf[i] != ' ') {
        word[i] = buf[i];
        buf++;
        i++;
        /*if (shouldReadNextSymbol(buf)) {
            continue;
        }
        else break;*/
    }
    buf++;
    if (i == 0) return "";
    string resWord = "";
    for (int j = 0; j < i; j++)
    {
        resWord += word[j];
    }
    
    
    return resWord;

}



string Remove_r(string str) {

    string res;

    for (int i = 0; i < str.size(); i++)
    {
        if (i == str.size() - 1) {
            res += str[i];
            continue;
        }else
        if (str[i] == 'r' && str[i - 1] == '\\') {
            continue;
        }
        else if (str[i] == '\\' && str[i + 1] == 'r') {
            continue;
        }
        res += str[i];
    }

    return res;

}

lecsem * CreateArrayOfLecsems() {

    std::ifstream isLecsem(lecsemsPath, std::ifstream::ate | std::ifstream::binary);

    if (!isLecsem)
    {
        cout << "can't find file \n\n";
        return NULL;
    }
    else
    {


        isLecsem.seekg(0, isLecsem.end);
        int length = isLecsem.tellg();
        isLecsem.seekg(0, isLecsem.beg);
        
        char* buffer = new char[length];

        //std::cout << "Reading " << length << " characters... ";
        // read data as a block:
        /*isLecsem.read(buffer, length);
        isLecsem.close();*/
        std::string line;
        int index = 0;
        if (isLecsem.is_open())
        {
            while (getline(isLecsem, line))
            {
                //std::cout << line << std::endl;
                auto pos = line.find(" ");
                if (pos != string::npos)
                {
                    string s1 = line.substr(0, pos);
                    string s2 = line.substr(pos + 1);
                    if (!s2.empty() && s2[s2.size() - 1] == '\r')
                        s2.erase(s2.size() - 1);
                    //auto pos_r = line.find("/r");
                    lecsems[index].name = s2;
                    lecsems[index].type = std::stoi(s1);
                    index++;
                    //cout << s1 << endl << s2 << endl;
                }
            }
        }
        isLecsem.close();     // закрываем файл

        //lecs = lecsems;

       


        return lecsems;

    }
}