#include <iostream>
#include <vector>
#include <fstream>


using namespace std;

int main() {
    setlocale(LC_ALL, "ru");
   
    fstream file; // ������� ������ ������ ifstream
    file.open("D:\\������\\����\\!������������\\Lab_1\\files\\prog.txt"); // ��������� ����
    vector<string> v;
    
    
    if (!file)
    {
        cout << "���� �� ������\n\n";
        return -1;
    }
    else
    {
        char ch;                //������, ����������� �� �����
        int pos = 0;            //������� ���������� ������� � ��������� ������
        int number = 0;         //����� ������ �������
        while (file.get(ch)) {

            cout << ch;
        }
        file.close();

        
    }
}