#include <iostream>
#include <vector>
#include <fstream>


using namespace std;

int main() {
    setlocale(LC_ALL, "ru");
   
    fstream file; // создаем объект класса ifstream
    file.open("D:\\универ\\ЛиПО\\!Лабораторные\\Lab_1\\files\\prog.txt"); // открываем файл
    vector<string> v;
    
    
    if (!file)
    {
        cout << "Файл не открыт\n\n";
        return -1;
    }
    else
    {
        char ch;                //символ, считываемый из файла
        int pos = 0;            //позиция последнего символа в собранной строке
        int number = 0;         //номер строки вектора
        while (file.get(ch)) {

            cout << ch;
        }
        file.close();

        
    }
}