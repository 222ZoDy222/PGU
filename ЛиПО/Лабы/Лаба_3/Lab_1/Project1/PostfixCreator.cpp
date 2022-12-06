#include "Main.h";

// Конечный результат постфиксной записи
std::vector<vector<Word>> postfix;
int lastPostfix = -1;

// Тут храняться все выражения
std::vector<vector<Word>> expression;

void CreatePostfix(std::vector<vector<Word>> resultExpression)
{
	expression = resultExpression;
	
	for (int i = 0; i < expression.size(); i++)
	{

		Postfix(expression[i]);

	}


}

void CreatePostfix() 
{

	lastPostfix++;
	std::vector<Word> newVector;
	postfix.push_back(newVector);

}

/// <summary>
/// 
/// </summary>
/// <param name="words"> Выражение </param>
void Postfix(std::vector<Word> words) 
{

	std::vector<Word> newPostfix;
	postfix.push_back(newPostfix);
	

	stack <Word> steck;

	for (int i = 0; i < words.size(); i++)
	{
		Word curWord = words[i];
			





	}

}



