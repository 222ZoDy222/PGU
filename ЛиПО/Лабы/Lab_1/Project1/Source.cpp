#include <iostream>
#include <vector>
#include <fstream>


using namespace std;


bool SyntaxCheck(char* buf);

int main() {
    setlocale(LC_ALL, "ru");
   
    fstream file; // создаем объект класса ifstream
    // Пример:
    // D:\\универ\\ЛиПО\\!Лабораторные\\Lab_1\\files\\prog.txt"
    string filePath = "D:\\Универ\\PGU\\ЛиПО\\Лабы\\Lab_1\\files\\prog.txt";
    file.open(filePath); // открываем файл
    vector<string> v;
    
    
    if (!file)
    {
        cout << "Файл не открыт\n\n";
        return -1;
    }
    else
    {
        int length = file.tellg();
        char* buffer = new char[length];
        file.read(buffer, length);
        file.close();
        bool result = SyntaxCheck(buffer);
        
    }
}



bool SyntaxCheck(char * buf) 
{
    char ch;                //символ, считываемый из файла
    int pos = 0;            //позиция последнего символа в собранной строке
    int number = 0;         //номер строки вектора
    for (int i = 0; i < sizeof(buf); i++)
    {
        cout << buf[i];
    }
    return true;
}