#include "Main.h";



void Error();
void S();
void Prog();
void V();
void W();







std::vector<Word> Words;
Word curWord;
int index;




// ���� ������ � ����������
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

	// ���� Var
	if (curWord.lecsemType == 1) {
		Next();
		// ���� ����������
		if (curWord.lecsemType == -2) {
			Next();
			// ���� ��������� ������� ","
			while (curWord.lecsemType == 8) {
				Next();
				// ���� ����������
				if (curWord.lecsemType == -2) {

				}
				// ���� ";"
				else if (curWord.lecsemType == 2) {
					break;
				}
				else {
					Error();
					
				}
				Next();
			}
			// ���� ";"
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
	// ���� ��� �� ��������� ������ ���������
	while (index < Words.size()-1)
	{
		// ���� DO
		if (curWord.lecsemType == 11) {

		}
		// ���� ����������
		else if (curWord.lecsemType == -2) {
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
	// ���� "-"
	if (curWord.lecsemType == 6) {
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
	else if (curWord.lecsemType == -1 || curWord.lecsemType == -2) 
	{
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

}

void ProgWhile() {

}