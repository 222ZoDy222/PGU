#include <iostream>
#include <string>
#include <windows.h> 
#include <process.h>
#include "synchapi.h"
#include <iostream>
#include <fstream> 
#include <mutex>

int main()
{
    HANDLE hSemaphore = CreateSemaphore(NULL, 1, 2, TEXT("MySemaphore"));
    std::string command;
    WaitForSingleObject(hSemaphore, INFINITE);
    while (true) {
        

        

        std::cout << "Enter DOS command: ";
        std::cin >> command;

        std::ofstream outfile("../../test.txt");
        outfile << command << std::endl;
        outfile.close();

        ReleaseSemaphore(hSemaphore, 1, NULL);

        WaitForSingleObject(hSemaphore, INFINITE);
        //system(command.c_str());
        //std::cout << "\n\n\n";
        
        
        
    }

    CloseHandle(hSemaphore);
    return 0;
}


//std::string command;
//	while (true) {
//		std::cout << "Enter DOS command: ";
//		std::cin >> command;
//		system(command.c_str());
//		std::cout << "\n\n\n";
//	}
//	return 0;