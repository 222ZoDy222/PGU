#include <windows.h>
#include <stdio.h>
#include <fstream> 
#include <iostream>
#include <string>

using namespace std;
#define MAX_SEM_COUNT 10

HANDLE ghSemaphore;

DWORD WINAPI ThreadProc(LPVOID);

int main(void)
{
    HANDLE aThread;
    DWORD ThreadID;
    int i;

    // Create a semaphore with initial and max counts of MAX_SEM_COUNT

    ghSemaphore = CreateSemaphore(
        NULL,           // default security attributes
        MAX_SEM_COUNT,  // initial count
        MAX_SEM_COUNT,  // maximum count
        NULL);          // unnamed semaphore

    if (ghSemaphore == NULL)
    {
        printf("CreateSemaphore error: %d\n", GetLastError());
        return 1;
    }

    // Create copy thread

    aThread = CreateThread(
        NULL,       // default security attributes
        0,          // default stack size
        (LPTHREAD_START_ROUTINE)ThreadProc,
        NULL,       // no thread function arguments
        0,          // default creation flags
        &ThreadID); // receive thread identifier

    if (aThread == NULL)
    {
        printf("CreateThread error: %d\n", GetLastError());
        return 1;
    }

    // Wait for all threads to terminate

    WaitForMultipleObjects(1, &aThread, TRUE, INFINITE);

    cout << "Copy Finished \n";


    // Close thread and semaphore handles

    CloseHandle(aThread);

    CloseHandle(ghSemaphore);

    return 0;
}

int CopyMyFile() 
{

    string line;
    //For writing text file
    //Creating ofstream & ifstream class object
    ifstream ini_file{ "CopyFrom.txt" };
    ofstream out_file{ "CopyTo.txt" };

    if (ini_file && out_file) {

        while (getline(ini_file, line)) {
            out_file << line << "\n";
        }

        
    }
    else {
        //Something went wrong
        printf("Cannot read File");
    }

    //Closing file
    ini_file.close();
    out_file.close();

    return 0;
}

DWORD WINAPI ThreadProc(LPVOID lpParam)
{

    // lpParam not used in this example
    UNREFERENCED_PARAMETER(lpParam);

    DWORD dwWaitResult;
    BOOL bContinue = TRUE;

    CopyMyFile();

    while (bContinue)
    {
        // Try to enter the semaphore gate.

        dwWaitResult = WaitForSingleObject(
            ghSemaphore,   // handle to semaphore
            0L);           // zero-second time-out interval

        switch (dwWaitResult)
        {
            // The semaphore object was signaled.
        case WAIT_OBJECT_0:
            // TODO: Perform task
            printf("Thread %d: work succeeded\n", GetCurrentThreadId());
            bContinue = FALSE;

            // Simulate thread spending time on task
            Sleep(5);

            // Release the semaphore when task is finished

            if (!ReleaseSemaphore(
                ghSemaphore,  // handle to semaphore
                1,            // increase count by one
                NULL))       // not interested in previous count
            {
                printf("ReleaseSemaphore error: %d\n", GetLastError());
            }
            break;

            // The semaphore was nonsignaled, so a time-out occurred.
        case WAIT_TIMEOUT:
            printf("Thread %d: wait timed out\n", GetCurrentThreadId());
            break;
        }
    }
    return TRUE;
}


