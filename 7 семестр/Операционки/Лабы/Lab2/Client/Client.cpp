#include <windows.h>
#include <stdio.h>
#include <iostream>
#include <Psapi.h>
#include <WinBase.h>
#include <string>




LPCTSTR SlotName = TEXT("\\\\.\\mailslot\\sample_mailslot");

HANDLE hFile;

BOOL WriteSlot(HANDLE hSlot, LPCTSTR lpszMessage)
{
    BOOL fResult;
    DWORD cbWritten;

    fResult = WriteFile(hSlot,
        lpszMessage,
        (DWORD)(lstrlen(lpszMessage) + 1) * sizeof(TCHAR),
        &cbWritten,
        (LPOVERLAPPED)NULL);

    if (!fResult)
    {
        printf("WriteFile failed with %d.\n", GetLastError());
        return FALSE;
    }

    printf("Slot written to successfully.\n");

    return TRUE;
}


BOOL WriteProcessInfo() 
{

    PROCESS_MEMORY_COUNTERS memCounter;
    BOOL result = GetProcessMemoryInfo(GetCurrentProcess(),
        &memCounter,
        sizeof(memCounter));

    //std::wstring testString = 
    std::wstring string = (std::to_wstring(memCounter.PagefileUsage));
    wchar_t* textShit = (wchar_t*)string.c_str();
    
    return WriteSlot(hFile, textShit);
}



int main()
{
    

    hFile = CreateFile(SlotName,
        GENERIC_WRITE,
        FILE_SHARE_READ,
        (LPSECURITY_ATTRIBUTES)NULL,
        OPEN_EXISTING,
        FILE_ATTRIBUTE_NORMAL,
        (HANDLE)NULL);

    if (hFile == INVALID_HANDLE_VALUE)
    {
        printf("CreateFile failed with %d.\n", GetLastError());
        return FALSE;
    }

    while (true) {

        char key;

        std::cin >> key;

        if (key == 'w') 
        {
            WriteProcessInfo();
        }

        if (key == 'e') {
            break;
        }



    }

    
    
    CloseHandle(hFile);

    return TRUE;
}