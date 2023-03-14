#include <iostream>
#include <string>

using namespace std;

int main(int argc, char* argv[])
{
	string input = "";
	input += argv[1];

	cout << input;

	if (input == "P" || input == "p" || input == "py" || input == "Py" || input == "python" || input == "Python")
	{
		// Python
		return 1;
	}
	else if (input == "c" || input == "C")
	{
		// Calculator
		return 2;
	}
	else if (input == "g" || input == "G" || input == "git")
	{
		// gitHub
		return 3;
	}
	else if (input == "0") {
		return 5;
	}
	return 0;

}