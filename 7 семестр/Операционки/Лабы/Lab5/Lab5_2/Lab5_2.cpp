#include <iostream>
#include <windows.h>
#include <fstream> 
#include <string>

using namespace std;

int main() {
	
	HANDLE semaphore = OpenSemaphore(SEMAPHORE_ALL_ACCESS, false, TEXT("MySemaphore"));

	if (semaphore == NULL) {
		cout << "Error opening semaphore\n";
		return 1;
	}
	while (true) {

		WaitForSingleObject(semaphore, INFINITE); // Wait for the semaphore

		string line;
		ifstream ini_file{ "../../test.txt" };
		getline(ini_file, line);

		// Run DOS command
		/*PROCESS_INFORMATION pi = { 0 };
		STARTUPINFO si = { sizeof(PROCESS_INFORMATION), 0, 0, 0, 0 };
		CreateProcess(NULL, (LPWSTR)line.c_str(), NULL, NULL, FALSE, 0, NULL, NULL, &si, &pi);
		GetExitCodeProcess(pi.hProcess, &pi.dwProcessId);
		CloseHandle(pi.hThread);*/
		system(line.c_str());
		//cout << "Result of command: " << line << endl;
		ReleaseSemaphore(semaphore, 1, NULL);// Release the semaphore so that other processes can use it
	}
	
	CloseHandle(semaphore);
	
	return 0;
}