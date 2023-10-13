#pragma comment( lib, "user32.lib" )
#include <strsafe.h>
#include <windows.h>
#include <stdio.h>
#include <iostream>

HHOOK hMouseHook;

UINT a1;


bool busy = false;





#pragma comment( lib, "user32.lib") 
#pragma comment( lib, "gdi32.lib")

#define NUMHOOKS 7 

// Global variables 

typedef struct _MYHOOKDATA
{
    int nType;
    HOOKPROC hkprc;
    HHOOK hhook;
} MYHOOKDATA;

MYHOOKDATA myhookdata[NUMHOOKS];

HWND gh_hwndMain;

/****************************************************************
 Подключаемая процедура WH_CALLWNDPROC

 ****************************************************************/

 // The callback function
LRESULT CALLBACK CallWndProc(int nCode, WPARAM wParam, LPARAM lParam) {
    if (nCode == HC_ACTION)
    {
        if (wParam > 0)
        {
            std::cout << "sent by the current thread wParam=" << wParam;
        }
        CWPSTRUCT* s = (CWPSTRUCT*)lParam;

        //have no
        //std::cout << " Index=" << nwinhooksdll++ << " s->message=" << s->message << " s->hwnd=" << s->hwnd << " s->wParam=" << s->wParam << " s->lParam=" << s->lParam << "\n";
        //MessageBox(NULL,L"CallWndProc",L"CALLBACK",0);

        //works
        //myfile << " Index=" << nwinhooksdll++ << " s->message=" << s->message << " s->hwnd=" << s->hwnd << " s->wParam=" << s->wParam << " s->lParam=" << s->lParam << "\n";
    }

    //This is a must
    return CallNextHookEx(hMouseHook, nCode, wParam, lParam);
}

LRESULT CALLBACK mouseProc(int nCode, WPARAM wParam, LPARAM lParam)
{
    MOUSEHOOKSTRUCT* pMouseStruct = (MOUSEHOOKSTRUCT*)lParam;
    UINT HitTestCode;
    HitTestCode = ((MOUSEHOOKSTRUCT*)lParam)->wHitTestCode;
    std::cout << HitTestCode;

    if (pMouseStruct != NULL) 
    {
        
        a1 = pMouseStruct->wHitTestCode;
        //std::cout << ("dwExtraInfo" + (pMouseStruct->dwExtraInfo));
        
        //std::cout << ("pt.y" + pMouseStruct->hwnd);
        if (pMouseStruct->wHitTestCode == HTCAPTION) 
        {
            printf("header");
            //isHeader = true;
        }
        else {
            //isHeader = false;
        }
        if (wParam == WM_LBUTTONDOWN)
        {
            printf("clicked");
            //lastClickRight = true;
        }
        else {
            //lastClickRight = false;
        }

        //printf("wp = %8x,x = %d, y = %d, flag = %8x,einfo = %d\n", wParam, input.mi.dx, input.mi.dy, input.mi.dwFlags, input.mi.dwExtraInfo);
        printf("Mouse position X = %d  Mouse Position Y = %d\n", pMouseStruct->pt.x, pMouseStruct->pt.y);
        std::cout << pMouseStruct->wHitTestCode;
        
    }
    return CallNextHookEx(hMouseHook, nCode, wParam, lParam);
}



DWORD WINAPI MyMouseLogger()
{
    HINSTANCE hInstance = GetModuleHandle(NULL);

    HWND hwnd = FindWindow(NULL, UNIQUE_NAME);

    DWORD pid = NULL; // If we dont know -> NULL
    DWORD tid = GetWindowThreadProcessId(hwnd, &pid);
    // here I put WH_MOUSE instead of WH_MOUSE_LL
    //hMouseHook = SetWindowsHookEx(WH_MOUSE, mouseProc, hInstance, NULL);
    //hMouseHook = SetWindowsHookEx(WH_CALLWNDPROC, CallWndProc, hInstance, NULL);
    //hMouseHook = SetWindowsHookEx(WH_MOUSE, CallWndProc, hInstance, tid); //WORKS
    hMouseHook = SetWindowsHookEx(WH_MOUSE, CallWndProc, hInstance, tid); // The local callback version

    MSG message;
    while (GetMessage(&message, NULL, 0, 0)) {
        TranslateMessage(&message);
        DispatchMessage(&message);
    }

    UnhookWindowsHookEx(hMouseHook);
    return 0;
}

/* Variable to store the HANDLE to the hook. Don't declare it anywhere else then globally
or you will get problems since every function uses this variable. */
HHOOK _hook;

// the dll instance
HINSTANCE _dllInstance;

// This functions installs a hook to a window with given title
int InstallHook(const wchar_t* title) {

    /* 1. Get window handle of given title */
    std::wcout << "INFO: Getting window handle for \"" << title << "\"...\n";
    HWND hwnd = FindWindow(NULL, UNIQUE_NAME);

    if (hwnd == NULL) {
        std::cout << "ERROR: Could not find target window.\n";
        return -1;
    }

    /* 2. Get ThreadID (TID) of the window handle */
    std::wcout << "INFO: Getting TheadID (TID) of \"" << title << "\"...\n";
    DWORD pid = NULL; // If we dont know -> NULL
    DWORD tid = GetWindowThreadProcessId(hwnd, &pid);
    if (tid == NULL) {
        std::cout << "ERROR: Could not find target window.\n";
        return -2;
    }

    /* 3. Load in the DLL */
    std::wcout << "INFO: Loading the DLL\n";
    _dllInstance = LoadLibrary(TEXT("winhooks_dll.dll"));
    if (_dllInstance == NULL) {
        std::cout << "ERROR: Could not load DLL...\n";
        return -3;
    }

    /* 3.5 Get Callback function from dll*/
    //_dllCallback = (HOOKPROC)GetProcAddress(_dllInstance, "_wmProcCallback@12");
    //if (_dllCallback == NULL) {
    //  std::cout << "ERROR: Could not get Callback function from dll instance\n";
    //  return -4;
    //}

    /* 4. Install the hook and set the handle */
    std::wcout << "INFO: Setting the hook...\n";
    _hook = SetWindowsHookEx(WH_MOUSE, CallWndProc, _dllInstance, tid); // The local callback version
    //_hook = SetWindowsHookEx(WH_CALLWNDPROCRET, _dllCallback, _dllInstance, tid); // The dll callback function
    if (_dllInstance == NULL) {
        std::cout << "ERROR: Could not set hook handle\n";
        return -5;
    }

    return 0;
}

int main() {

    const wchar_t* title = L"Untitled - Notepad";
    MyMouseLogger();
   /* if (InstallHook(title) != 0) {
        std::wcout << "ERROR: Could not install hook on " << title << " last error -> " << GetLastError() << "\n";
        system("pause");
        return 1;
    }*/

    std::wcout << "SUCCESS: Hook is successfully installed on " << title << "\n";
    std::wcout << "Running message loop..." << std::endl;

    MSG msg;
    while (GetMessage(&msg, NULL, 0, 0)) {
        TranslateMessage(&msg);
        DispatchMessage(&msg);
    }
}


//int main(int argc, char** argv)
//{
//    HANDLE hThread;
//    DWORD dwThread;
//
//    hThread = CreateThread(NULL, NULL, (LPTHREAD_START_ROUTINE)MyMouseLogger, (LPVOID)argv[0], NULL, &dwThread);
//    if (hThread)
//    {
//        int lasta1 = 1000;
//        while (true)
//        {
//            if (busy) continue;
//            busy = true;
//            if (lasta1 != a1) {
//                lasta1 = a1;
//                std::cout << a1;
//            }
//            
//            /*if (isHeader && lastClickRight)
//            {
//
//                printf("clicked");
//               
//            }*/
//            busy = false;
//        }
//        return WaitForSingleObject(hThread, INFINITE);
//    }
//    else
//        return 1;
//
//}