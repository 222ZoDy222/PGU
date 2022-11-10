#include <iostream>
#include <string>

using namespace std;

int main(int argc, char* argv[])
{
    string input = "";
	input += argv[1];
	
	cout << input;

	if (input == "Vs" || input == "vS" || input == "VS" || input == "vs" || input == "v" || input == "V")
	{
		// visual studio
		return 1;
	}
	else if(input == "S" || input == "s")
	{
		// sublime
		return 2;
	}
	else if (input == "U" || input == "Unity" || input == "u")
	{
		return 3;
	}
	else if (input == "P" || input == "p")
	{
		return 4;
	}
	else if (input == "0") {
		return 5;
	}
	return 0;
    
}