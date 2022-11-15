//#include <iostream>
//#include <vector>
//#include <fstream>
//#include "Lecsems.h"
//#include <string>
#include "Main.h";

using namespace std;

//fstream file; // создаем объект класса ifstream
    // Пример:
    // D:\\универ\\ЛиПО\\!Лабораторные\\Lab_1\\files\\prog.txt"
string filePath = "D:\\Универ\\PGU\\ЛиПО\\Лабы\\Lab_1\\files\\prog.txt";

//file.open(filePath); // открываем файл



int main() {
    setlocale(LC_ALL, "ru");
   
    
    

    CreateLecsems();
    


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

    SetTypes(words);

    //PrintLecsems(words);

    SyntaxAnalizator(words);

   
    return true;
}

void PrintLecsems(std::vector<Word>& words) {

    for (int i = 0; i < words.size(); i++)
    {
        if (IsIdentificatedLecsem(words[i].word)) {
            cout << words[i].word << " is identificated" << "\t" << " row number - " << words[i].rowNum << "\t" << " word type - " << words[i].lecsemType;
        }
        else {
            cout << words[i].word << " is undeficated" << "\t" << " row number - " << words[i].rowNum;
        }
        cout << "\n";
        cout << "-----------------------------------------------";
        cout << "\n";
    }
}



