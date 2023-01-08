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
			//out << "LIT 0\n"; //в сетек помещается 0, чтобы сравнить с рещультатом выражения
			//string label = std::to_string(GenLable());
			//string endLabel = std::to_string(GenLable());
			//out << "JEQ " + label + "\n"; // если равен нулю, то есть false
			//getline(file, str);
			//getline(file, str);// пропуск THEN
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
			//	out << "JMP " + endLabel + "\n"; //если встретился else, то перед ним нужно выполнить безусловный переход
			//	out << label + ":\n"; // по этой метке выплолняется вход в блок else
			//	getline(file, str); //пропуск else
			//	while (str != "ENDIF")
			//	{
			//		TranslitExpression(str);
			//		getline(file, str);
			//	}
			//	out << endLabel + ":\n"; //По этой метке выход из условия
			//}
			//else if (str == "ENDIF") // при отсутствии else используется одна метка
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
/// Возвращает переменную, в которую выполняется присваивание.
/// эта переменная нужна для сравнения в блоке if.
/// </summary>
/// <param name="str">очередная строка файла посмфиксной записи</param>
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
	out << "LIT 0\n"; //в сетек помещается 0, чтобы сравнить с рещультатом выражения
	string label = std::to_string(GenLable());
	string endLabel = std::to_string(GenLable());
	out << "JEQ " + label + "\n"; // если равен нулю, то есть false
	getline(file, str);
	getline(file, str);// пропуск THEN

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
		out << "JMP " + endLabel + "\n"; //если встретился else, то перед ним нужно выполнить безусловный переход
		out << label + ":\n"; // по этой метке выплолняется вход в блок else
		getline(file, str); //пропуск else
		while (str != "ENDIF")
		{
			TranslitExpression(str, out);
			getline(file, str);
		}
		out << endLabel + ":\n"; //По этой метке выход из условия
	}
	else if (str == "ENDIF") // при отсутствии else используется одна метка
	{
		out << label + ":\n";
	}
}
