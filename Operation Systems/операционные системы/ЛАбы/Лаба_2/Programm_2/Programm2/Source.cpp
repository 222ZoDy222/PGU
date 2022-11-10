#include <iostream>
#include <thread>
#include <string>
#include <Windows.h>
#include <locale>
#include <conio.h>
#include <vector>

using namespace std;

void wait(void* param);
void SetStdinEcho(bool enable);
int main(char argc, char* argv[])
{

	setlocale(LC_ALL, "RUS");
	
	SetStdinEcho(true);

	string pass = "qwerty";
	string userPass;

	if (argc == 0) return 0;
	char c;
	string time = argv[1];
	//string time = "10";
	int Time = 1000 * stoi(time);
	std::vector<char> password;
std:cout << "¬ведите пароль : ";
	_beginthread(wait, 0, (void*)Time);
	SetStdinEcho(false);
	std::cin >> userPass;
	cout << "\n";
	////c = _getch()
	//while ((c = _getch()) != '\r')
	//{
	//	userPass += c;
	//	cout << "\b";
	//	//putc(0, stdout);
	//	//std:cout << "*";
	//}
	

	if (userPass == pass) {
		return 1;
	}
	else return 0;



}
void SetStdinEcho(bool enable)
{
#ifdef WIN32
	HANDLE hStdin = GetStdHandle(STD_INPUT_HANDLE);
	DWORD mode;
	GetConsoleMode(hStdin, &mode);

	if (!enable)
		mode &= ~ENABLE_ECHO_INPUT;
	else
		mode |= ENABLE_ECHO_INPUT;

	SetConsoleMode(hStdin, mode);

#else
	struct termios tty;
	tcgetattr(STDIN_FILENO, &tty);
	if (!enable)
		tty.c_lflag &= ~ECHO;
	else
		tty.c_lflag |= ECHO;

	(void)tcsetattr(STDIN_FILENO, TCSANOW, &tty);
#endif
}
void wait(void* param) 
{
	int time = (int)param;
	Sleep(time);
	exit(-1);
}