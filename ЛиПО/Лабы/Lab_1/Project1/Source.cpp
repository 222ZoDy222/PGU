#include <iostream>
#include <vector>
#include <fstream>


using namespace std;


bool SyntaxCheck(char* buf, int length);

int main() {
    setlocale(LC_ALL, "ru");
   
    //fstream file; // ������� ������ ������ ifstream
    // ������:
    // D:\\������\\����\\!������������\\Lab_1\\files\\prog.txt"
    string filePath = "D:\\������\\PGU\\����\\����\\Lab_1\\files\\prog.txt";
    //file.open(filePath); // ��������� ����
    std::ifstream is(filePath, std::ifstream::ate | std::ifstream::binary);
    vector<string> v;
    
    
    if (!is)
    {
        cout << "���� �� ������\n\n";
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
    char ch;                //������, ����������� �� �����
    int pos = 0;            //������� ���������� ������� � ��������� ������
    int number = 0;         //����� ������ �������
    for (int i = 0; i < length; i++)
    {
        cout << buf[i];
    }
    return true;
}