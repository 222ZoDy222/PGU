//#include <iostream>
//
//#include <iostream>
//#include<fstream>
//#include<string>
//#include<vector>
//#include<locale.h>
//#include<algorithm>
//#include<stack>
//#include<map>
//
//using std::map;
//using std::find;
//using std::ifstream;
//using std::string;
//using std::cin;
//using std::cout;
//using std::vector;
//using std::pair;
//using std::to_string;
//using std::stack;
//
//#define COMMA 10
//#define VAR 0
//#define IDENT 1
//#define CONST 2
//#define OPERATOR 4
//#define DOT 5
//#define COLON 6
//#define MINUS 8
//#define EQUALLY 7
//#define BRACKETLEFT 8
//#define BRACKETRIGHT 9
//#define IF 15
//#define THEN 18
//#define ELSE 16
//#define ENDIF 17
//#define NEWLINE 20
//
//
//// ассоциативный массив приоритетов
//map<string, int> priority =
//{ {"+", 0},
//	{ "-",0 },
//	{ "*",1 },
//	{ "/",1 },
//	{ "(",2 },
//	{ ")",2 },
//	{"=",-1 } };
//
//
//vector <pair<string, int>> postfics(vector <pair<string, int>> vlex)
//{
//	vector <pair<string, int>> rezult{};
//	stack<pair<string, int>> stack;
//	pair<string, int> oneLex{};
//	int lexIdent = 0;
//	bool lastMinus = false;
//
//	for (int i = 0; i < vlex.size(); i++)
//	{
//		lexIdent = vlex[i].second;
//
//		// собственно алгоритм на основе статьи https://habr.com/ru/post/489744/
//		if (lexIdent == IDENT || lexIdent == CONST)
//			rezult.push_back(vlex[i]);
//		else
//		{
//			if (lexIdent == BRACKETLEFT)
//			{
//				stack.push(vlex[i]);
//			}
//			else if (lexIdent == BRACKETRIGHT)
//			{
//				if (!stack.empty())
//				{
//					oneLex = stack.top();
//					while (oneLex.second != BRACKETLEFT)
//					{
//						oneLex = stack.top();
//						stack.pop();
//
//						if (oneLex.second != BRACKETLEFT)
//							rezult.push_back(oneLex);
//					}
//				}
//				else
//					stack.push(oneLex);
//
//			}
//			else if ((lexIdent == OPERATOR || lexIdent == EQUALLY) && vlex[i].first != "~")
//			{
//				if (!stack.empty())
//				{
//
//					//auto lastPrior = find(priority.begin(), priority.end(),
//					//	oneLex);
//
//					//auto curPrior = find(priority.begin(), priority.end(),
//					//	vlex[i]);
//
//					while (1)
//					{
//						oneLex = stack.top();
//						auto lastPrior = priority.find(oneLex.first);
//						auto curPrior = priority.find(vlex[i].first);
//						if (stack.empty())
//						{
//							stack.push(vlex[i]);
//							break;
//						}
//						else if (vlex[i].first == "(")
//						{
//							stack.push(vlex[i]);
//							break;
//						}
//						else if (stack.top().first == "(")
//						{
//							stack.push(vlex[i]);
//							break;
//						}
//						if (curPrior->second > lastPrior->second)
//						{
//							stack.push(vlex[i]);
//							break;
//						}
//						else if (curPrior->second <= lastPrior->second)
//						{
//							rezult.push_back(oneLex);
//							stack.pop();
//							stack.push(vlex[i]);
//							break;
//						}
//						//else if(curPrior->second < lastPrior->second)
//						//{
//						//	rezult.push_back(oneLex);
//						//	stack.pop();
//						///	stack.push(vlex[i]);
//						//}
//
//					}
//
//				}
//				else
//					stack.push(vlex[i]);
//
//			}
//			else if ("~" == vlex[i].first)
//			{
//				lastMinus = true;
//				continue;
//			}
//
//		}
//		if (lastMinus)
//		{
//			//отрицание добавляется после следующей лексемы, выглядит как ~, т.к. была заменена в синтаксическом анализе
//			// чтобы различать унарный и бинарный минус
//			rezult.push_back(std::make_pair("~", OPERATOR));
//			lastMinus = false;
//		}
//
//	}
//
//	while (!stack.empty())
//	{
//		rezult.push_back(stack.top());
//		stack.pop();
//	}
//	return rezult;
//}