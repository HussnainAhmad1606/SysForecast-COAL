#include <windows.h>
#include <stdio.h>
#include <psapi.h>
#include <tlhelp32.h>
#pragma comment(lib, "psapi.lib")

void displayProcessInfo(DWORD processId, const char* processName) {
    HANDLE hProcess = OpenProcess(PROCESS_QUERY_INFORMATION | PROCESS_VM_READ, FALSE, processId);

    if (hProcess != NULL) {
        PROCESS_MEMORY_COUNTERS pmc;
        if (GetProcessMemoryInfo(hProcess, &pmc, sizeof(pmc))) {
            printf("| %-30lu | %-30s | %-30lu KB |\n", processId, processName, pmc.WorkingSetSize / 1024);
        }
        else {
            perror("GetProcessMemoryInfo");
        }

        CloseHandle(hProcess);
    }
    else {
        //perror("OpenProcess");
    }
}

int showProcesses() {
    HANDLE hSnapshot;
    PROCESSENTRY32 pe32;

    // Take a snapshot of all processes in the system.
    hSnapshot = CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);

    if (hSnapshot == INVALID_HANDLE_VALUE) {
        perror("CreateToolhelp32Snapshot");
        return 1;
    }

    // Set the size of the structure before using it.
    pe32.dwSize = sizeof(PROCESSENTRY32);

    // Display information about each process.
    printf("| %-30s | %-30s | %-30s |\n", "PID", "Process Name", "Memory Usage (KB)");
    printf("| %-30s | %-30s | %-30s |\n", "------------------------------", "------------------------------", "------------------------------");

    do {
        displayProcessInfo(pe32.th32ProcessID, pe32.szExeFile);
    } while (Process32Next(hSnapshot, &pe32));
    printf("---------------------------------------------------------------------\n");

    // Clean up the snapshot object.
    CloseHandle(hSnapshot);
    return 0;
}

int main() {
    showProcesses();
    return 0;
}
