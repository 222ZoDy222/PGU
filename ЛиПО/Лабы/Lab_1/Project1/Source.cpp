#include <iostream>
#include <vector>
#include <fstream>


using namespace std;


bool SyntaxCheck(char* buf);

int main() {
    setlocale(LC_ALL, "ru");
   
    fstream file; // ������� ������ ������ ifstream
    // ������:
    // D:\\������\\����\\!������������\\Lab_1\\files\\prog.txt"
    string filePath = "D:\\������\\PGU\\����\\����\\Lab_1\\files\\prog.txt";
    file.open(filePath); // ��������� ����
    vector<string> v;
    
    
    if (!file)
    {
        cout << "���� �� ������\n\n";
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
    char ch;                //������, ����������� �� �����
    int pos = 0;            //������� ���������� ������� � ��������� ������
    int number = 0;         //����� ������ �������
    for (int i = 0; i < sizeof(buf); i++)
    {
        cout << buf[i];
    }
    return true;
}