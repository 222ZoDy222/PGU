#include "Main.h";



void Error();
void S();
void Prog();
void V();
void W();
void CompleteSyntaxAnaliz();
void ProgWhile();





std::vector<Word> Words;

std::vector<string> Vars;

Word curWord;
int index;


int recursiveS = 0;

// ���� ������ � ����������
bool errorInSyntax = false;

void Error() {


	errorInSyntax = true;
	cout << "Error on " << curWord.rowNum << "\n";
}

void Error(string str) 
{
	
	errorInSyntax = true;
	cout << "\n" << "Error on " << curWord.rowNum << "\n" << "\t" << str;
}

void SyntaxAnalizator(std::vector<Word> words) 
{
	Words = words;
	curWord = Words[0];
	index = 0;

	S();

}

void Next() {
	if (index >= Words.size()-1) {
		return;
	}
	index++;
	curWord = Words[index];
}

// ���� �� ��� ����� �������������
bool CheckWasVar(string var) 
{
	for (int i = 0; i < Vars.size(); i++)
	{
		if (Vars[i] == var) return true;
	} 
	Vars.push_back(var);
	return false;
}

void S() {

	// ���� Var
	if (curWord.lecsemType == 1) {
		Next();
		// ���� ����������
		if (curWord.lecsemType == -2) {

			CheckWasVar(curWord.word);
			Next();
			// ���� ��������� ������� ","
			while (curWord.lecsemType == 8) {
				Next();
				// ���� ����������
				if (curWord.lecsemType == -2) {
					// ���� ������������� ����������� (��� ��� ��������)
					if (CheckWasVar(curWord.word)) {
						Error("Identifier '" + curWord.word + "' already exist");
					}
				}
				// ���� ";"
				else if (curWord.lecsemType == 2) {
					
					break;
				}
				else if (curWord.lecsemType == 8) {
					Error("The superfluous comma");
					Next();
				}
				else {
					Error("Undefined ';'");
					
				}
				Next();
			}
			// ���� ";"
			if (curWord.lecsemType == 2) {
				
				Next();
				

			}
			else 
			{
				Error("Undefined ';'");
			}
			Prog();
		}
		else {
			
			
				Error("Undefined identifier");
			
			
		}

	}
	else {
		Error("Var is undefined");
		Next();
		recursiveS++;
		S();
	}
	if (recursiveS == 0) {
		CompleteSyntaxAnaliz();
	}
	else {
		recursiveS--;
	}
}


void Prog() 
{
	// ���� ��� �� ��������� ������ ���������
	while (index < Words.size()-1)
	{
		// ���� DO
		if (curWord.lecsemType == 11) {
			Next();
			ProgWhile();
		}
		// ���� ����������
		else if (curWord.lecsemType == -2) {
			if (!CheckWasVar(curWord.word)) 
			{
				Error("Undefined Variable");
			}
			Next();
			// ���� ":"
			if (curWord.lecsemType == 3) {
				Next();
				// ���� "="
				if (curWord.lecsemType == 4) {
					Next();
					V();
					// ���� ";"
					if (curWord.lecsemType == 2) {
						Next();
					}
					else {
						Error("Can't find ';' ");
						//V();
					}
				}
				else {
					Error("Undefined  '=' ");
					V();
					// ���� ";"
					if (curWord.lecsemType == 2) {
						Next();
					}
					else {
						Error("Can't find ';' ");
						//V();
					}
				}

			}
			else {
				Error();
			}
		}
		else {
			Next();
			Error();
		}
	}

	

}

void V() 
{
	// ���� "-"
	if (curWord.word == "-") {
		Next();
	}
	W();

}

void W() 
{
	// ���� "("
	if (curWord.lecsemType == 12) {
		Next();
		V();
		// ���� ")"
		if (curWord.lecsemType == 13) {
			Next();
		}

	}
	else if (curWord.lecsemType == 13) {
		return;
	}
	else if (curWord.lecsemType == -1 || curWord.lecsemType == -2) 
	{
		if (curWord.lecsemType == -2 && !CheckWasVar(curWord.word))
		{
			Error("Undefined Variable");
		}
		Next();
	}
	else {
		Next();
		Error();
	}
	// ���� + - * /
	if (curWord.lecsemType == 5) {
		Next();
		W();
		
	}
	// ���� ;
	else if(curWord.lecsemType == 2)
	{
		
		
	}
	else if (curWord.lecsemType == 13) {

	}
	else if (index == Words.size() - 1) {

	}
	else {
		
		byte testError = 0;
		
		// ���� ��� ��������� ������
		if (index == Words.size() - 1) {
			Error("Unknown construction " + curWord.word);
			return;
		}
		Error("Undefined identifier " + curWord.word);

		while (curWord.lecsemType != 2) {
			Next();
			testError++;
			if (testError == 255) break;
			if (index == Words.size() - 1) break;
		}
		
		
	}

}

void ProgWhile() 
{
	bool haveWhile = false;
	
	// ���� ��� �� ��������� ������ ���������
	while (index < Words.size() - 1) {
		// ���� ����������
		if (curWord.lecsemType == -2) {
			if (!CheckWasVar(curWord.word))
			{
				Error("Undefined Variable");
			}
			Next();
			// ���� ":"
			if (curWord.lecsemType == 3) {
				Next();
				// ���� "="
				if (curWord.lecsemType == 4) {
					Next();
					V();
					// ���� ";"
					if (curWord.lecsemType == 2) {
						Next();
					}
					else {
						Error("Can't find ';' ");
						//V();
					}
				}
				else {
					Error("Undefined  '=' ");
					V();
					// ���� ";"
					if (curWord.lecsemType == 2) {
						Next();
					}
					else {
						Error("Can't find ';' ");
						//V();
					}
				}

			}
			else {
				Error();
			}
		}
		// ���� WHILE
		else if (curWord.lecsemType == 14) {
			haveWhile = true;
			Next();
			V();
		}
		else {
			Next();
			Error("Undefined Constuct while");
		}
	}
	
	if (!haveWhile) {
		Error("Undefine While");
	}

} 


void CompleteSyntaxAnaliz() {

	cout << "\n" << "Complete Syntax Analiz";

	if (errorInSyntax) {
		cout << "\n" << "Should fix the Errors";
	}
	else {
		cout << "\n" << "Cool code Bro!";
	}


}