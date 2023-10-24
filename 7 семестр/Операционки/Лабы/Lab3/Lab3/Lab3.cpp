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
LPWSTR windowName;

bool Click = false;

LRESULT CALLBACK mouseProc(int nCode, WPARAM wParam, LPARAM lParam)
{
    //printf("mouseProc");
    MOUSEHOOKSTRUCT* pMouseStruct = (MOUSEHOOKSTRUCT*)lParam;
    UINT HitTestCode;
    HitTestCode = ((MOUSEHOOKSTRUCT*)lParam)->wHitTestCode;
    //std::cout << HitTestCode;

    if (pMouseStruct != NULL) 
    {

        
        POINT p;

        GetCursorPos(&p);
        HWND window = WindowFromPoint(p);

        RECT rect;
        if (GetWindowRect(window, &rect))
        {
            int width = rect.right - rect.left;
            int height = rect.bottom - rect.top;

            if (p.y >= rect.top && p.y <= rect.top + 30) {
                
                if (wParam == WM_LBUTTONDOWN) {
                    printf("Click\n");
                }
            }
            
            
            
            

            
        }


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
    hMouseHook = SetWindowsHookEx(WH_MOUSE_LL, mouseProc, hInstance, NULL);
    //hMouseHook = SetWindowsHookEx(WH_CALLWNDPROC, CallWndProc, hInstance, NULL);
    //hMouseHook = SetWindowsHookEx(WH_MOUSE, CallWndProc, hInstance, tid); //WORKS
    //hMouseHook = SetWindowsHookEx(WH_MOUSE, CallWndProc, hInstance, tid); // The local callback version

    //hMouseHook = SetWindowsHookEx(WH_MOUSE_LL, mouseProc, hInstance, 0);

    /*MSG message;
    while (GetMessage(&message, NULL, 0, 0)) {
        TranslateMessage(&message);
        DispatchMessage(&message);
    }

    UnhookWindowsHookEx(hMouseHook);*/
    return 0;
}

/* Variable to store the HANDLE to the hook. Don't declare it anywhere else then globally
or you will get problems since every function uses this variable. */
HHOOK _hook;

// the dll instance
HINSTANCE _dllInstance;


int main() {


   
    //while (true) {
    //    POINT p;

    //    GetCursorPos(&p);
    //    HWND window = WindowFromPoint(p);

    //    RECT rect;
    //    if (GetWindowRect(window, &rect))
    //    {
    //        int width = rect.right - rect.left;
    //        int height = rect.bottom - rect.top;

    //        if (p.y >= rect.top && p.y <= rect.top + 30) {
    //            printf("Header");
    //        }

    //        if (Click) {
    //            printf("Click");
    //        }

    //        //std::cout << rect.top + "\t";
    //        //std::cout << pMouseStruct->pt.y + "\n";
    //        //printf("Mouse position X = %d  Mouse Position Y = %d\n", pMouseStruct->pt.x, pMouseStruct->pt.y);
    //        //printf("Windows position X = %d  Window Position Y = %d\n", rect.top, rect.left);
    //        /*system("cls");
    //        printf("Mouse position X = %d  Mouse Position Y = %d\n", p.x, p.y);
    //        printf("Windows Top = %d Windows bottom = %d Windows left = %d Windows right = %d \n", rect.top, rect.bottom, rect.left, rect.right);
    //        Sleep(100);*/
    //    }


    //}

    
    MyMouseLogger();
   

    
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