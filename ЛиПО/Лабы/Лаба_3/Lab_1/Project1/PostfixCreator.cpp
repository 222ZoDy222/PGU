#include "Main.h"


//  онечный результат постфиксной записи
vector<vector<Word>> postfixes;


// “ут хран€тьс€ все выражени€
vector<vector<Word>> expressions;
// ассоциативный массив приоритетов
map<string, int> priority =
{ {"+", 0},
	{ "-",0 },
	{ "*",1 },
	{ "/",1 },
	{ "(",2 },
	{ ")",2 },
	{"=",-1 } };




void SavePostfix() {

	ofstream fOut;

	fOut.open("PostfixResult.txt");

	for (int i = 0; i < postfixes.size(); i++)
	{
		string res;
		
		for (int j = 0; j < postfixes[i].size(); j++)
		{
			res += postfixes[i][j].word;
			res += " ";
		}

		res += "\n";

		fOut << res;

		
	}
	fOut.close();

}

void CreatePostfix(std::vector<vector<Word>> resultExpression)
{
	expressions = resultExpression;
	
	for (int i = 0; i < expressions.size(); i++)
	{

		postfixes.push_back(infixToPostfix(expressions[i]));

	}
	SavePostfix();

}

int prec(string c)
{
	if (c == "^")
		return 3;
	else if (c == "/" || c == "*")
		return 2;
	else if (c == "+" || c == "-")
		return 1;
	else
		return -1;
}



vector<Word> infixToPostfix(vector<Word> s)
{

	stack<Word> st; // For stack operations, we are using
					// C++ built in stack
	//string result;

	vector<Word> result;

	for (int i = 0; i < s.size(); i++) {
		Word c = s[i];

		// If the scanned character is
		// an operand, add it to output string.
		if ((c.lecsemType == -1) || (c.lecsemType == -2))
			result.push_back(c);

		// If the scanned character is an
		// С(С, push it to the stack.
		else if (c.lecsemType == 12)
			st.push(c);

		// If the scanned character is an С)Т,
		// pop and to output string from the stack
		// until an С(С is encountered.
		else if (c.lecsemType == 13) {
			while (!st.empty() && st.top().lecsemType != 12) {
				result.push_back(st.top());
				st.pop();
			}
			st.pop();
		}

		// If an operator is scanned
		else {
			while (!st.empty()
				&& prec(s[i].word) <= prec(st.top().word)) {
				result.push_back(st.top());
				st.pop();
			}
			st.push(c);
		}
	}

	// Pop all the remaining elements from the stack
	while (!st.empty()) {
		result.push_back(st.top());
		st.pop();
	}

	return result;
}


std::vector<Word> postfics(std::vector<Word> vlex)
{
	vector<Word> rezult{};
	stack<Word> stack;
	Word oneLex{};
	int lexIdent = 0;
	bool lastMinus = false;

	for (int i = 0; i < vlex.size(); i++)
	{
		lexIdent = vlex[i].lecsemType;

		// собственно алгоритм на основе статьи https://habr.com/ru/post/489744/
		if (lexIdent == -2 || lexIdent == -1)
			rezult.push_back(vlex[i]);
		else
		{
			if (lexIdent == 12)
			{
				stack.push(vlex[i]);
			}
			else if (lexIdent == 13)
			{
				if (!stack.empty())
				{
					oneLex = stack.top();
					while (oneLex.lecsemType != 12)
					{
						oneLex = stack.top();
						stack.pop();

						if (oneLex.lecsemType != 12)
							rezult.push_back(oneLex);
					}
				}
				else
					stack.push(oneLex);

			}
			else if ((lexIdent == 5 || lexIdent == 4) && vlex[i].word != "~")
			{
				if (!stack.empty())
				{

					
					while (1)
					{
						oneLex = stack.top();
						auto lastPrior = priority.find(oneLex.word);
						auto curPrior = priority.find(vlex[i].word);
						if (stack.empty())
						{
							stack.push(vlex[i]);
							break;
						}
						else if (vlex[i].word == "(")
						{
							stack.push(vlex[i]);
							break;
						}
						else if (stack.top().word == "(")
						{
							stack.push(vlex[i]);
							break;
						}
						if (curPrior->second <= lastPrior->second)
						{
							stack.push(vlex[i]);
							break;
						}
						else if (curPrior->second > lastPrior->second)
						{
							
							rezult.push_back(oneLex);
							stack.pop();
							stack.push(vlex[i]);
							break;
						}
						//else if(curPrior->second < lastPrior->second)
						//{
						//	rezult.push_back(oneLex);
						//	stack.pop();
						///	stack.push(vlex[i]);
						//}

					}

				}
				else
					stack.push(vlex[i]);

			}
			else if (lexIdent == 6)
			{
				lastMinus = true;
				continue;
			}

		}
		if (lastMinus)
		{
			//отрицание добавл€етс€ после следующей лексемы, выгл€дит как ~, т.к. была заменена в синтаксическом анализе
			// чтобы различать унарный и бинарный минус
			//rezult.push_back(std::make_pair("~", 4));
			Word newWord = Word();
			newWord.word = "~";
			newWord.lecsemType = 6;
			rezult.push_back(newWord);
			lastMinus = false;
		}

	}

	while (!stack.empty())
	{
		rezult.push_back(stack.top());
		stack.pop();
	}
	return rezult;
}

