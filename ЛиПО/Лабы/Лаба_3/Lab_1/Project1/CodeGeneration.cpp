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
void translitDoWhile(ifstream& file, ofstream& out);
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
		// ≈сли в коде DO
		if ("do " == str || "DO " == str)
		{
			
			translitDoWhile(file, out);
			
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
/// ¬озвращает переменную, в которую выполн€етс€ присваивание.
/// эта переменна€ нужна дл€ сравнени€ в блоке if.
/// </summary>
/// <param name="str">очередна€ строка файла посмфиксной записи</param>
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

static int FuncCounter = 1;

void translitDoWhile(ifstream& file, ofstream& out)
{
	string str{};
	getline(file, str);
	string firstLex = TranslitExpression(str, out);
	out << "JMP s" + to_string(++FuncCounter) + "\n";
	out << "s" + to_string(FuncCounter) + ":" + "\n";

	int localFuncCounter = FuncCounter;

	getline(file, str);
	while (str != "while " && str != "WHILE ")
	{
		if (str == "DO " || str == "do ")
		{
			translitDoWhile(file, out);
		}
		else
		{
			TranslitExpression(str, out);
		}
		getline(file, str);
	}

	if (str == "while " || str == "WHILE ")
	{
		getline(file, str);
		TranslitExpression(str, out);

		out << "LIT 1\n"; //в сетек помещаетс€ 0, чтобы сравнить с рещультатом выражени€
		out << "JEQ s" + to_string(localFuncCounter) + "\n"; // если равен нулю, то есть false

	}
	
	getline(file, str);
	

	
	
}
