#include<iostream>
#include<fstream>
#include<string>
#include<vector>
#include<locale.h>
#include<algorithm>
#include<regex>
#include<map>



using std::regex;
using std::find;
using std::ifstream;
using std::ofstream;
using std::string;
using std::cin;
using std::vector;
using std::pair;
using std::to_string;
using std::map;
void translitIf(ifstream& file, ofstream& out);
char GenLable();
string GetCommand(string lex);
bool GenCode(ifstream& file, ofstream& out);
string TranslitExpression(string str, ofstream& out);

void StartCodeGeneretaion()
{
	ifstream file("PostfixResult.txt");
	ofstream out("code.txt");
	GenCode(file, out);
	file.close();
	out.close();
	
}
bool GenCode(ifstream& file, ofstream& out)
{
	string str{};
	if (!file.is_open())
	{
		out << "file not open\n";
		return false;
	}

	ofstream code("..\\code.txt");
	if (!code.is_open())
	{
		out << "code file not open\n";
		return false;
	}
	while (getline(file, str))
	{
		if ("IF" == str)
		{
			//getline(file, str);
			//string firstLex = TranslitExpression(str);
			//out << "LOAD " + firstLex + "\n";
			//out << "LIT 0\n"; //� ����� ���������� 0, ����� �������� � ����������� ���������
			//string label = std::to_string(GenLable());
			//string endLabel = std::to_string(GenLable());
			//out << "JEQ " + label + "\n"; // ���� ����� ����, �� ���� false
			//getline(file, str);
			//getline(file, str);// ������� THEN
			translitIf(file, out);
			//while (str != "ELSE" && str != "ENDIF")
			//{
			//	 //done
			//	if (str == "IF")
			//	{
			//		translitIf(file);
			//	}
			//	else
			//	{
			//		TranslitExpression(str);
			//	}
			//	getline(file, str);
			//}
			//if (str == "ELSE")
			//{
			//	out << "JMP " + endLabel + "\n"; //���� ���������� else, �� ����� ��� ����� ��������� ����������� �������
			//	out << label + ":\n"; // �� ���� ����� ������������ ���� � ���� else
			//	getline(file, str); //������� else
			//	while (str != "ENDIF")
			//	{
			//		TranslitExpression(str);
			//		getline(file, str);
			//	}
			//	out << endLabel + ":\n"; //�� ���� ����� ����� �� �������
			//}
			//else if (str == "ENDIF") // ��� ���������� else ������������ ���� �����
			//{
			//	out << label + ":\n";
			//}
		}
		else
		{
			TranslitExpression(str, out);
		}
	}
	code.close();
	return true;
}


/// <summary>
/// ���������� ����������, � ������� ����������� ������������.
/// ��� ���������� ����� ��� ��������� � ����� if.
/// </summary>
/// <param name="str">��������� ������ ����� ����������� ������</param>
/// <returns></returns>
string TranslitExpression(string str, ofstream& out)
{
	int i = 0;
	string oneLex{};
	string firstLex{};
	while (str[i] != ' ' && i < str.size())
	{
		oneLex.push_back(str[i]);
		i++;
	}
	firstLex = oneLex;
	oneLex.clear();
	i++;

	while (i != str.size())
	{

		while (str[i] != ' ' && i < str.size())
		{
			oneLex.push_back(str[i]);
			i++;
		}
		i++;

		if (oneLex == "=")
		{
			out << "STO " + firstLex << "\n";
		}
		else
		{
			out << GetCommand(oneLex) << "\n";
		}
		oneLex.clear();
	}
	out << "\n";
	return firstLex;
}

map<string, string> operand_command
{
	{"+","ADD"},
	{"-","SUB"},
	{"*","MUL"},
	{"/","DIV"},
	{"~","NOT"},
};

string GetCommand(string lex)
{
	regex Ident("^[a-zA-Z]+[\\w+]*");
	regex Operand("\\d+");
	string command{};
	if (regex_match(lex, Ident))
	{
		command = ("LOAD " + lex);
	}
	else if (regex_match(lex, Operand))
	{
		command = ("LIT " + lex);
	}
	//else if ("=" == lex)
	//{
	//	command = ("LIT " + lex);
	//}
	else
	{
		auto comm = operand_command.find(lex);
		command = (comm->second);
	}
	return command;
}

char GenLable()
{
	static char index = 0;
	index++;
	return index;
}


void translitIf(ifstream& file, ofstream& out)
{
	string str{};
	getline(file, str);
	string firstLex = TranslitExpression(str, out);
	out << "LOAD " + firstLex + "\n";
	out << "LIT 0\n"; //� ����� ���������� 0, ����� �������� � ����������� ���������
	string label = std::to_string(GenLable());
	string endLabel = std::to_string(GenLable());
	out << "JEQ " + label + "\n"; // ���� ����� ����, �� ���� false
	getline(file, str);
	getline(file, str);// ������� THEN

	while (str != "ELSE" && str != "ENDIF")
	{
		if (str == "IF")
		{
			translitIf(file, out);
		}
		else
		{
			TranslitExpression(str, out);
		}
		getline(file, str);
	}
	if (str == "ELSE")
	{
		out << "JMP " + endLabel + "\n"; //���� ���������� else, �� ����� ��� ����� ��������� ����������� �������
		out << label + ":\n"; // �� ���� ����� ������������ ���� � ���� else
		getline(file, str); //������� else
		while (str != "ENDIF")
		{
			TranslitExpression(str, out);
			getline(file, str);
		}
		out << endLabel + ":\n"; //�� ���� ����� ����� �� �������
	}
	else if (str == "ENDIF") // ��� ���������� else ������������ ���� �����
	{
		out << label + ":\n";
	}
}
