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



#pragma region Postfix

// Тут храняться все выражения
std::vector<vector<Word>> expression;

void CreateNewExpression(Word word) 
{

	std::vector<Word> newVector;
	newVector.push_back(word);

	expression.push_back(newVector);

}

void AddVarExpression(Word word) 
{
	int firstSize = expression.size() - 1;
	int secondSize = expression[firstSize].size()-1;
	// Если последнее слово == ;
	if (expression[firstSize][secondSize].lecsemType == 2) {
		CreateNewExpression(word);
	}
	else {
		expression[expression.size() - 1].push_back(word);
	}
	
}




#pragma endregion



Word curWord;
int index;


int recursiveS = 0;

// Если ошибка в синтаксисе
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

	// Начало синт анализатора
	S();

	// Если нет ошибки в синтаксическом анализаторе
	if (!errorInSyntax) {

		cout << "\nNice!";




	}

}

void Next() {
	if (index >= Words.size()-1) {
		return;
	}
	index++;
	curWord = Words[index];
}

// Есть ли уже такой идентификатор
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

	// Если Var
	if (curWord.lecsemType == 1) {
		Next();
		// Если переменная
		if (curWord.lecsemType == -2) {

			CheckWasVar(curWord.word);
			Next();
			// Пока следующая лексема ","
			while (curWord.lecsemType == 8) {
				Next();
				// Если переменная
				if (curWord.lecsemType == -2) {
					// Этот идентификатор повторяется (уже был объявлен)
					if (CheckWasVar(curWord.word)) {
						Error("Identifier '" + curWord.word + "' already exist");
					}
				}
				// Если ";"
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
			// Если ";"
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
	// пока это не последний символ программы
	while (index < Words.size()-1)
	{
		// Если DO
		if (curWord.lecsemType == 11) {
			Next();
			ProgWhile();
		}
		// Если переменная
		else if (curWord.lecsemType == -2) {
			if (!CheckWasVar(curWord.word)) 
			{
				Error("Undefined Variable");
			}
			CreateNewExpression(curWord);
			Next();
			// Если ":"
			if (curWord.lecsemType == 3) {
				AddVarExpression(curWord);
				Next();
				// Если "="
				if (curWord.lecsemType == 4) {
					AddVarExpression(curWord);
					Next();
					V();
					// Если ";"
					if (curWord.lecsemType == 2) {
						AddVarExpression(curWord);
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
					// Если ";"
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
	// Если "-"
	if (curWord.word == "-") {
		curWord.lecsemType = 6;
		AddVarExpression(curWord);
		Next();
	}
	W();

}

void W() 
{
	// Если "("
	if (curWord.lecsemType == 12) {
		AddVarExpression(curWord);
		Next();
		V();
		// Если ")"
		if (curWord.lecsemType == 13) {
			AddVarExpression(curWord);
			Next();
		}

	}
	// Если ")"
	else if (curWord.lecsemType == 13) {
		AddVarExpression(curWord);
		return;
	}
	else if (curWord.lecsemType == -1 || curWord.lecsemType == -2) 
	{
		AddVarExpression(curWord);
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
	// Если + - * /
	if (curWord.lecsemType == 5) {
		AddVarExpression(curWord);
		Next();
		W();
		
	}
	// Если ;
	else if(curWord.lecsemType == 2)
	{
		
		
	}
	else if (curWord.lecsemType == 13) {
		AddVarExpression(curWord);
	}
	else if (index == Words.size() - 1) {

	}
	else {
		
		byte testError = 0;
		
		// Если это последний символ
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
	
	// пока это не последний символ программы
	while (index < Words.size() - 1) {
		// Если переменная
		if (curWord.lecsemType == -2) {
			if (!CheckWasVar(curWord.word))
			{
				Error("Undefined Variable");
			}
			CreateNewExpression(curWord);
			Next();
			// Если ":"
			if (curWord.lecsemType == 3) {
				AddVarExpression(curWord);
				Next();
				// Если "="
				if (curWord.lecsemType == 4) {
					AddVarExpression(curWord);
					Next();
					V();
					// Если ";"
					if (curWord.lecsemType == 2) {
						AddVarExpression(curWord);
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
					// Если ";"
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
		// Если WHILE
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