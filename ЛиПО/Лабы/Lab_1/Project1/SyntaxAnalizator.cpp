#include "Main.h";



void Error();
void S();
void Prog();
void V();
void W();







std::vector<Word> Words;
Word curWord;
int index;




// Если ошибка в синтаксисе
bool errorInSyntax = false;

void Error() {


	errorInSyntax = true;
	cout << "Error on " << curWord.rowNum << "\n";
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


void S() {

	// Если Var
	if (curWord.lecsemType == 1) {
		Next();
		// Если переменная
		if (curWord.lecsemType == -2) {
			Next();
			// Пока следующая лексема ","
			while (curWord.lecsemType == 8) {
				Next();
				// Если переменная
				if (curWord.lecsemType == -2) {

				}
				// Если ";"
				else if (curWord.lecsemType == 2) {
					break;
				}
				else {
					Error();
					
				}
				Next();
			}
			// Если ";"
			if (curWord.lecsemType == 2) {
				
				Next();
				Prog();

			}
			else {
				Error();
			}

		}

	}
	else {
		Error();
	}

}


void Prog() 
{
	// пока это не последний символ программы
	while (index < Words.size()-1)
	{
		// Если DO
		if (curWord.lecsemType == 11) {

		}
		// Если переменная
		else if (curWord.lecsemType == -2) {
			Next();
			// Если ":"
			if (curWord.lecsemType == 3) {
				Next();
				// Если "="
				if (curWord.lecsemType == 4) {
					Next();
					V();
					// Если ";"
					if (curWord.lecsemType == 2) {
						Next();
					}
					else {
						Error();
						V();
					}
				}
				else {
					Error();
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
	if (curWord.lecsemType == 6) {
		Next();
	}
	W();

}

void W() 
{
	// Если "("
	if (curWord.lecsemType == 12) {
		Next();
		V();
		// Если ")"
		if (curWord.lecsemType == 13) {
			Next();
		}

	} 
	else if (curWord.lecsemType == -1 || curWord.lecsemType == -2) 
	{
		Next();
	}
	else {
		Next();
		Error();
	}
	// Если + - * /
	if (curWord.lecsemType == 5) {
		Next();
		W();
		
	}

}

void ProgWhile() {

}