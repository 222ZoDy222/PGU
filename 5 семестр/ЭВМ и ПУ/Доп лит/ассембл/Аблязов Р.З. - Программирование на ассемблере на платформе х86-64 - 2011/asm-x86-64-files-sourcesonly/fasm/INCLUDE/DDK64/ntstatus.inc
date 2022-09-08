;
; The success status codes 0 - 63 are reserved for wait completion status.
; FacilityCodes 0x5 - 0xF have been allocated by various drivers.
;
STATUS_SUCCESS				= 0x00000000 ; ntsubauth

;
;  Values are 32 bit values layed out as follows:
;
;   3 3 2 2 2 2 2 2 2 2 2 2 1 1 1 1 1 1 1 1 1 1
;   1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0 9 8 7 6 5 4 3 2 1 0
;  +---+-+-+-----------------------+-------------------------------+
;  |Sev|C|R|     Facility          |               Code            |
;  +---+-+-+-----------------------+-------------------------------+
;
;  where
;
;      Sev - is the severity code
;
;          00 - Success
;          01 - Informational
;          10 - Warning
;          11 - Error
;
;      C - is the Customer code flag
;
;      R - is a reserved bit
;
;      Facility - is the facility code
;
;      Code - is the facility's status code
;
;
; Define the facility codes
;
FACILITY_USB_ERROR_CODE 	 = 0x10
FACILITY_TERMINAL_SERVER	 = 0xA
FACILITY_SXS_ERROR_CODE 	 = 0x15
FACILITY_RPC_STUBS		 = 0x3
FACILITY_RPC_RUNTIME		 = 0x2
FACILITY_IO_ERROR_CODE		 = 0x4
FACILITY_HID_ERROR_CODE 	 = 0x11
FACILITY_FIREWIRE_ERROR_CODE	 = 0x12
FACILITY_DEBUGGER		 = 0x1
FACILITY_CLUSTER_ERROR_CODE	 = 0x13
FACILITY_ACPI_ERROR_CODE	 = 0x14


;
; Define the severity codes
;
STATUS_SEVERITY_WARNING 	 = 0x2
STATUS_SEVERITY_SUCCESS 	 = 0x0
STATUS_SEVERITY_INFORMATIONAL	 = 0x1
STATUS_SEVERITY_ERROR		 = 0x3


;
; MessageId: STATUS_WAIT_0
;
; MessageText:
;
;  STATUS_WAIT_0
;
STATUS_WAIT_0			 = 0x00000000	 ; winnt

;
; MessageId: STATUS_WAIT_1
;
; MessageText:
;
;  STATUS_WAIT_1
;
STATUS_WAIT_1			 = 0x00000001

;
; MessageId: STATUS_WAIT_2
;
; MessageText:
;
;  STATUS_WAIT_2
;
STATUS_WAIT_2			 = 0x00000002

;
; MessageId: STATUS_WAIT_3
;
; MessageText:
;
;  STATUS_WAIT_3
;
STATUS_WAIT_3			 = 0x00000003

;
; MessageId: STATUS_WAIT_63
;
; MessageText:
;
;  STATUS_WAIT_63
;
STATUS_WAIT_63			 = 0x0000003F


;
; The success status codes 128 - 191 are reserved for wait completion
; status with an abandoned mutant object.
;
STATUS_ABANDONED			= 0x00000080

;
; MessageId: STATUS_ABANDONED_WAIT_0
;
; MessageText:
;
;  STATUS_ABANDONED_WAIT_0
;
STATUS_ABANDONED_WAIT_0 	 = 0x00000080	 ; winnt

;
; MessageId: STATUS_ABANDONED_WAIT_63
;
; MessageText:
;
;  STATUS_ABANDONED_WAIT_63
;
STATUS_ABANDONED_WAIT_63	 = 0x000000BF


;
; The success status codes 256, 257, 258, and 258 are reserved for
; User APC, Kernel APC, Alerted, and Timeout.
;
;
; MessageId: STATUS_USER_APC
;
; MessageText:
;
;  STATUS_USER_APC
;
STATUS_USER_APC 		 = 0x000000C0	 ; winnt

;
; MessageId: STATUS_KERNEL_APC
;
; MessageText:
;
;  STATUS_KERNEL_APC
;
STATUS_KERNEL_APC		 = 0x00000100

;
; MessageId: STATUS_ALERTED
;
; MessageText:
;
;  STATUS_ALERTED
;
STATUS_ALERTED			 = 0x00000101

;
; MessageId: STATUS_TIMEOUT
;
; MessageText:
;
;  STATUS_TIMEOUT
;
STATUS_TIMEOUT			 = 0x00000102	 ; winnt

;
; MessageId: STATUS_PENDING
;
; MessageText:
;
;  The operation that was requested is pending completion.
;
STATUS_PENDING			 = 0x00000103	 ; winnt

;
; MessageId: STATUS_REPARSE
;
; MessageText:
;
;  A reparse should be performed by the Object Manager since the name of the file resulted in a symbolic link.
;
STATUS_REPARSE			 = 0x00000104

;
; MessageId: STATUS_MORE_ENTRIES
;
; MessageText:
;
;  Returned by enumeration APIs to indicate more information is available to successive calls.
;
STATUS_MORE_ENTRIES		 = 0x00000105

;
; MessageId: STATUS_NOT_ALL_ASSIGNED
;
; MessageText:
;
;  Indicates not all privileges referenced are assigned to the caller.
;  This allows, for example, all privileges to be disabled without having to know exactly which privileges are assigned.
;
STATUS_NOT_ALL_ASSIGNED 	 = 0x00000106

;
; MessageId: STATUS_SOME_NOT_MAPPED
;
; MessageText:
;
;  Some of the information to be translated has not been translated.
;
STATUS_SOME_NOT_MAPPED		 = 0x00000107

;
; MessageId: STATUS_OPLOCK_BREAK_IN_PROGRESS
;
; MessageText:
;
;  An open/create operation completed while an oplock break is underway.
;
STATUS_OPLOCK_BREAK_IN_PROGRESS  = 0x00000108

;
; MessageId: STATUS_VOLUME_MOUNTED
;
; MessageText:
;
;  A new volume has been mounted by a file system.
;
STATUS_VOLUME_MOUNTED		 = 0x00000109

;
; MessageId: STATUS_RXACT_COMMITTED
;
; MessageText:
;
;  This success level status indicates that the transaction state already exists for the registry sub-tree, but that a transaction commit was previously aborted.
;  The commit has now been completed.
;
STATUS_RXACT_COMMITTED		 = 0x0000010A

;
; MessageId: STATUS_NOTIFY_CLEANUP
;
; MessageText:
;
;  This indicates that a notify change request has been completed due to closing the handle which made the notify change request.
;
STATUS_NOTIFY_CLEANUP		 = 0x0000010B

;
; MessageId: STATUS_NOTIFY_ENUM_DIR
;
; MessageText:
;
;  This indicates that a notify change request is being completed and that the information is not being returned in the caller's buffer.
;  The caller now needs to enumerate the files to find the changes.
;
STATUS_NOTIFY_ENUM_DIR		 = 0x0000010C

;
; MessageId: STATUS_NO_QUOTAS_FOR_ACCOUNT
;
; MessageText:
;
;  {No Quotas}
;  No system quota limits are specifically set for this account.
;
STATUS_NO_QUOTAS_FOR_ACCOUNT	 = 0x0000010D

;
; MessageId: STATUS_PRIMARY_TRANSPORT_CONNECT_FAILED
;
; MessageText:
;
;  {Connect Failure on Primary Transport}
;  An attempt was made to connect to the remote server %hs on the primary transport, but the connection failed.
;  The computer WAS able to connect on a secondary transport.
;
STATUS_PRIMARY_TRANSPORT_CONNECT_FAILED = 0x0000010E

;
; MessageId: STATUS_PAGE_FAULT_TRANSITION
;
; MessageText:
;
;  Page fault was a transition fault.
;
STATUS_PAGE_FAULT_TRANSITION	 = 0x00000110

;
; MessageId: STATUS_PAGE_FAULT_DEMAND_ZERO
;
; MessageText:
;
;  Page fault was a demand zero fault.
;
STATUS_PAGE_FAULT_DEMAND_ZERO	 = 0x00000111

;
; MessageId: STATUS_PAGE_FAULT_COPY_ON_WRITE
;
; MessageText:
;
;  Page fault was a demand zero fault.
;
STATUS_PAGE_FAULT_COPY_ON_WRITE  = 0x00000112

;
; MessageId: STATUS_PAGE_FAULT_GUARD_PAGE
;
; MessageText:
;
;  Page fault was a demand zero fault.
;
STATUS_PAGE_FAULT_GUARD_PAGE	 = 0x00000113

;
; MessageId: STATUS_PAGE_FAULT_PAGING_FILE
;
; MessageText:
;
;  Page fault was satisfied by reading from a secondary storage device.
;
STATUS_PAGE_FAULT_PAGING_FILE	 = 0x00000114

;
; MessageId: STATUS_CACHE_PAGE_LOCKED
;
; MessageText:
;
;  Cached page was locked during operation.
;
STATUS_CACHE_PAGE_LOCKED	 = 0x00000115

;
; MessageId: STATUS_CRASH_DUMP
;
; MessageText:
;
;  Crash dump exists in paging file.
;
STATUS_CRASH_DUMP		 = 0x00000116

;
; MessageId: STATUS_BUFFER_ALL_ZEROS
;
; MessageText:
;
;  Specified buffer contains all zeros.
;
STATUS_BUFFER_ALL_ZEROS 	 = 0x00000117

;
; MessageId: STATUS_REPARSE_OBJECT
;
; MessageText:
;
;  A reparse should be performed by the Object Manager since the name of the file resulted in a symbolic link.
;
STATUS_REPARSE_OBJECT		 = 0x00000118

;
; MessageId: STATUS_RESOURCE_REQUIREMENTS_CHANGED
;
; MessageText:
;
;  The device has succeeded a query-stop and its resource requirements have changed.
;
STATUS_RESOURCE_REQUIREMENTS_CHANGED = 0x00000119

;
; MessageId: STATUS_TRANSLATION_COMPLETE
;
; MessageText:
;
;  The translator has translated these resources into the global space and no further translations should be performed.
;
STATUS_TRANSLATION_COMPLETE	 = 0x00000120

;
; MessageId: STATUS_DS_MEMBERSHIP_EVALUATED_LOCALLY
;
; MessageText:
;
;  The directory service evaluated group memberships locally, as it was unable to contact a global catalog server.
;
STATUS_DS_MEMBERSHIP_EVALUATED_LOCALLY = 0x00000121

;
; MessageId: STATUS_NOTHING_TO_TERMINATE
;
; MessageText:
;
;  A process being terminated has no threads to terminate.
;
STATUS_NOTHING_TO_TERMINATE	 = 0x00000122

;
; MessageId: STATUS_PROCESS_NOT_IN_JOB
;
; MessageText:
;
;  The specified process is not part of a job.
;
STATUS_PROCESS_NOT_IN_JOB	 = 0x00000123

;
; MessageId: STATUS_PROCESS_IN_JOB
;
; MessageText:
;
;  The specified process is part of a job.
;
STATUS_PROCESS_IN_JOB		 = 0x00000124

;
; MessageId: DBG_EXCEPTION_HANDLED
;
; MessageText:
;
;  Debugger handled exception
;
DBG_EXCEPTION_HANDLED		 = 0x00010001	 ; winnt

;
; MessageId: DBG_CONTINUE
;
; MessageText:
;
;  Debugger continued
;
DBG_CONTINUE			 = 0x00010002	 ; winnt



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;/
;
; Standard Information values
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;/

;
; MessageId: STATUS_OBJECT_NAME_EXISTS
;
; MessageText:
;
;  {Object Exists}
;  An attempt was made to create an object and the object name already existed.
;
STATUS_OBJECT_NAME_EXISTS	 = 0x40000000

;
; MessageId: STATUS_THREAD_WAS_SUSPENDED
;
; MessageText:
;
;  {Thread Suspended}
;  A thread termination occurred while the thread was suspended. The thread was resumed, and termination proceeded.
;
STATUS_THREAD_WAS_SUSPENDED	 = 0x40000001

;
; MessageId: STATUS_WORKING_SET_LIMIT_RANGE
;
; MessageText:
;
;  {Working Set Range Error}
;  An attempt was made to set the working set minimum or maximum to values which are outside of the allowable range.
;
STATUS_WORKING_SET_LIMIT_RANGE	 = 0x40000002

;
; MessageId: STATUS_IMAGE_NOT_AT_BASE
;
; MessageText:
;
;  {Image Relocated}
;  An image file could not be mapped at the address specified in the image file. Local fixups must be performed on this image.
;
STATUS_IMAGE_NOT_AT_BASE	 = 0x40000003

;
; MessageId: STATUS_RXACT_STATE_CREATED
;
; MessageText:
;
;  This informational level status indicates that a specified registry sub-tree transaction state did not yet exist and had to be created.
;
STATUS_RXACT_STATE_CREATED	 = 0x40000004

;
; MessageId: STATUS_SEGMENT_NOTIFICATION
;
; MessageText:
;
;  {Segment Load}
;  A virtual DOS machine (VDM) is loading, unloading, or moving an MS-DOS or Win16 program segment image.
;  An exception is raised so a debugger can load, unload or track symbols and breakpoints within these 16-bit segments.
;
STATUS_SEGMENT_NOTIFICATION	 = 0x40000005	 ; winnt

;
; MessageId: STATUS_LOCAL_USER_SESSION_KEY
;
; MessageText:
;
;  {Local Session Key}
;  A user session key was requested for a local RPC connection. The session key returned is a constant value and not unique to this connection.
;
STATUS_LOCAL_USER_SESSION_KEY	 = 0x40000006

;
; MessageId: STATUS_BAD_CURRENT_DIRECTORY
;
; MessageText:
;
;  {Invalid Current Directory}
;  The process cannot switch to the startup current directory %hs.
;  Select OK to set current directory to %hs, or select CANCEL to exit.
;
STATUS_BAD_CURRENT_DIRECTORY	 = 0x40000007

;
; MessageId: STATUS_SERIAL_MORE_WRITES
;
; MessageText:
;
;  {Serial IOCTL Complete}
;  A serial I/O operation was completed by another write to a serial port.
;  (The IOCTL_SERIAL_XOFF_COUNTER reached zero.)
;
STATUS_SERIAL_MORE_WRITES	 = 0x40000008

;
; MessageId: STATUS_REGISTRY_RECOVERED
;
; MessageText:
;
;  {Registry Recovery}
;  One of the files containing the system's Registry data had to be recovered by use of a log or alternate copy.
;  The recovery was successful.
;
STATUS_REGISTRY_RECOVERED	 = 0x40000009

;
; MessageId: STATUS_FT_READ_RECOVERY_FROM_BACKUP
;
; MessageText:
;
;  {Redundant Read}
;  To satisfy a read request, the NT fault-tolerant file system successfully read the requested data from a redundant copy.
;  This was done because the file system encountered a failure on a member of the fault-tolerant volume, but was unable to reassign the failing area of the device.
;
STATUS_FT_READ_RECOVERY_FROM_BACKUP = 0x4000000A

;
; MessageId: STATUS_FT_WRITE_RECOVERY
;
; MessageText:
;
;  {Redundant Write}
;  To satisfy a write request, the NT fault-tolerant file system successfully wrote a redundant copy of the information.
;  This was done because the file system encountered a failure on a member of the fault-tolerant volume, but was not able to reassign the failing area of the device.
;
STATUS_FT_WRITE_RECOVERY	 = 0x4000000B

;
; MessageId: STATUS_SERIAL_COUNTER_TIMEOUT
;
; MessageText:
;
;  {Serial IOCTL Timeout}
;  A serial I/O operation completed because the time-out period expired.
;  (The IOCTL_SERIAL_XOFF_COUNTER had not reached zero.)
;
STATUS_SERIAL_COUNTER_TIMEOUT	 = 0x4000000C

;
; MessageId: STATUS_NULL_LM_PASSWORD
;
; MessageText:
;
;  {Password Too Complex}
;  The Windows password is too complex to be converted to a LAN Manager password.
;  The LAN Manager password returned is a NULL string.
;
STATUS_NULL_LM_PASSWORD 	 = 0x4000000D

;
; MessageId: STATUS_IMAGE_MACHINE_TYPE_MISMATCH
;
; MessageText:
;
;  {Machine Type Mismatch}
;  The image file %hs is valid, but is for a machine type other than the current machine. Select OK to continue, or CANCEL to fail the DLL load.
;
STATUS_IMAGE_MACHINE_TYPE_MISMATCH = 0x4000000E

;
; MessageId: STATUS_RECEIVE_PARTIAL
;
; MessageText:
;
;  {Partial Data Received}
;  The network transport returned partial data to its client. The remaining data will be sent later.
;
STATUS_RECEIVE_PARTIAL		 = 0x4000000F

;
; MessageId: STATUS_RECEIVE_EXPEDITED
;
; MessageText:
;
;  {Expedited Data Received}
;  The network transport returned data to its client that was marked as expedited by the remote system.
;
STATUS_RECEIVE_EXPEDITED	 = 0x40000010

;
; MessageId: STATUS_RECEIVE_PARTIAL_EXPEDITED
;
; MessageText:
;
;  {Partial Expedited Data Received}
;  The network transport returned partial data to its client and this data was marked as expedited by the remote system. The remaining data will be sent later.
;
STATUS_RECEIVE_PARTIAL_EXPEDITED = 0x40000011

;
; MessageId: STATUS_EVENT_DONE
;
; MessageText:
;
;  {TDI Event Done}
;  The TDI indication has completed successfully.
;
STATUS_EVENT_DONE		 = 0x40000012

;
; MessageId: STATUS_EVENT_PENDING
;
; MessageText:
;
;  {TDI Event Pending}
;  The TDI indication has entered the pending state.
;
STATUS_EVENT_PENDING		 = 0x40000013

;
; MessageId: STATUS_CHECKING_FILE_SYSTEM
;
; MessageText:
;
;  Checking file system on %wZ
;
STATUS_CHECKING_FILE_SYSTEM	 = 0x40000014

;
; MessageId: STATUS_FATAL_APP_EXIT
;
; MessageText:
;
;  {Fatal Application Exit}
;  %hs
;
STATUS_FATAL_APP_EXIT		 = 0x40000015

;
; MessageId: STATUS_PREDEFINED_HANDLE
;
; MessageText:
;
;  The specified registry key is referenced by a predefined handle.
;
STATUS_PREDEFINED_HANDLE	 = 0x40000016

;
; MessageId: STATUS_WAS_UNLOCKED
;
; MessageText:
;
;  {Page Unlocked}
;  The page protection of a locked page was changed to 'No Access' and the page was unlocked from memory and from the process.
;
STATUS_WAS_UNLOCKED		 = 0x40000017

;
; MessageId: STATUS_SERVICE_NOTIFICATION
;
; MessageText:
;
;  %hs
;
STATUS_SERVICE_NOTIFICATION	 = 0x40000018

;
; MessageId: STATUS_WAS_LOCKED
;
; MessageText:
;
;  {Page Locked}
;  One of the pages to lock was already locked.
;
STATUS_WAS_LOCKED		 = 0x40000019

;
; MessageId: STATUS_LOG_HARD_ERROR
;
; MessageText:
;
;  Application popup: %1 : %2
;
STATUS_LOG_HARD_ERROR		 = 0x4000001A

;
; MessageId: STATUS_ALREADY_WIN32
;
; MessageText:
;
;  STATUS_ALREADY_WIN32
;
STATUS_ALREADY_WIN32		 = 0x4000001B

;
; MessageId: STATUS_WX86_UNSIMULATE
;
; MessageText:
;
;  Exception status code used by Win32 x86 emulation subsystem.
;
STATUS_WX86_UNSIMULATE		 = 0x4000001C

;
; MessageId: STATUS_WX86_CONTINUE
;
; MessageText:
;
;  Exception status code used by Win32 x86 emulation subsystem.
;
STATUS_WX86_CONTINUE		 = 0x4000001D

;
; MessageId: STATUS_WX86_SINGLE_STEP
;
; MessageText:
;
;  Exception status code used by Win32 x86 emulation subsystem.
;
STATUS_WX86_SINGLE_STEP 	 = 0x4000001E

;
; MessageId: STATUS_WX86_BREAKPOINT
;
; MessageText:
;
;  Exception status code used by Win32 x86 emulation subsystem.
;
STATUS_WX86_BREAKPOINT		 = 0x4000001F

;
; MessageId: STATUS_WX86_EXCEPTION_CONTINUE
;
; MessageText:
;
;  Exception status code used by Win32 x86 emulation subsystem.
;
STATUS_WX86_EXCEPTION_CONTINUE	 = 0x40000020

;
; MessageId: STATUS_WX86_EXCEPTION_LASTCHANCE
;
; MessageText:
;
;  Exception status code used by Win32 x86 emulation subsystem.
;
STATUS_WX86_EXCEPTION_LASTCHANCE = 0x40000021

;
; MessageId: STATUS_WX86_EXCEPTION_CHAIN
;
; MessageText:
;
;  Exception status code used by Win32 x86 emulation subsystem.
;
STATUS_WX86_EXCEPTION_CHAIN	 = 0x40000022

;
; MessageId: STATUS_IMAGE_MACHINE_TYPE_MISMATCH_EXE
;
; MessageText:
;
;  {Machine Type Mismatch}
;  The image file %hs is valid, but is for a machine type other than the current machine.
;
STATUS_IMAGE_MACHINE_TYPE_MISMATCH_EXE = 0x40000023

;
; MessageId: STATUS_NO_YIELD_PERFORMED
;
; MessageText:
;
;  A yield execution was performed and no thread was available to run.
;
STATUS_NO_YIELD_PERFORMED	 = 0x40000024

;
; MessageId: STATUS_TIMER_RESUME_IGNORED
;
; MessageText:
;
;  The resumable flag to a timer API was ignored.
;
STATUS_TIMER_RESUME_IGNORED	 = 0x40000025

;
; MessageId: STATUS_ARBITRATION_UNHANDLED
;
; MessageText:
;
;  The arbiter has deferred arbitration of these resources to its parent
;
STATUS_ARBITRATION_UNHANDLED	 = 0x40000026

;
; MessageId: STATUS_CARDBUS_NOT_SUPPORTED
;
; MessageText:
;
;  The device "%hs" has detected a CardBus card in its slot, but the firmware on this system is not configured to allow the CardBus controller to be run in CardBus mode.
;  The operating system will currently accept only 16-bit (R2) pc-cards on this controller.
;
STATUS_CARDBUS_NOT_SUPPORTED	 = 0x40000027

;
; MessageId: STATUS_WX86_CREATEWX86TIB
;
; MessageText:
;
;  Exception status code used by Win32 x86 emulation subsystem.
;
STATUS_WX86_CREATEWX86TIB	 = 0x40000028

;
; MessageId: STATUS_MP_PROCESSOR_MISMATCH
;
; MessageText:
;
;  The CPUs in this multiprocessor system are not all the same revision level.  To use all processors the operating system restricts itself to the features of the least capable processor in the system.  Should problems occur with this system, contact
;  the CPU manufacturer to see if this mix of processors is supported.
;
STATUS_MP_PROCESSOR_MISMATCH	 = 0x40000029

;
; MessageId: STATUS_HIBERNATED
;
; MessageText:
;
;  The system was put into hibernation.
;
STATUS_HIBERNATED		 = 0x4000002A	 

;
; MessageId: STATUS_RESUME_HIBERNATION
;
; MessageText:
;
;  The system was resumed from hibernation.
;
STATUS_RESUME_HIBERNATION	 = 0x4000002B	 

;
; MessageId: DBG_REPLY_LATER
;
; MessageText:
;
;  Debugger will reply later.
;
DBG_REPLY_LATER 		 = 0x40010001

;
; MessageId: DBG_UNABLE_TO_PROVIDE_HANDLE
;
; MessageText:
;
;  Debugger can not provide handle.
;
DBG_UNABLE_TO_PROVIDE_HANDLE	 = 0x40010002

;
; MessageId: DBG_TERMINATE_THREAD
;
; MessageText:
;
;  Debugger terminated thread.
;
DBG_TERMINATE_THREAD		 = 0x40010003	 ; winnt

;
; MessageId: DBG_TERMINATE_PROCESS
;
; MessageText:
;
;  Debugger terminated process.
;
DBG_TERMINATE_PROCESS		 = 0x40010004	 ; winnt

;
; MessageId: DBG_CONTROL_C
;
; MessageText:
;
;  Debugger got control C.
;
DBG_CONTROL_C			 = 0x40010005	 ; winnt

;
; MessageId: DBG_PRINTEXCEPTION_C
;
; MessageText:
;
;  Debugger printerd exception on control C.
;
DBG_PRINTEXCEPTION_C		 = 0x40010006

;
; MessageId: DBG_RIPEXCEPTION
;
; MessageText:
;
;  Debugger recevice RIP exception.
;
DBG_RIPEXCEPTION		 = 0x40010007

;
; MessageId: DBG_CONTROL_BREAK
;
; MessageText:
;
;  Debugger received control break.
;
DBG_CONTROL_BREAK		 = 0x40010008	 ; winnt



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;/
;
; Standard Warning values
;
;
; Note:  Do NOT use the value = 0x80000000L, as this is a non-portable value
;        for the NT_SUCCESS macro. Warning values start with a code of 1.
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;/

;
; MessageId: STATUS_GUARD_PAGE_VIOLATION
;
; MessageText:
;
;  {EXCEPTION}
;  Guard Page Exception
;  A page of memory that marks the end of a data structure, such as a stack or an array, has been accessed.
;
STATUS_GUARD_PAGE_VIOLATION	 = 0x80000001	 ; winnt

;
; MessageId: STATUS_DATATYPE_MISALIGNMENT
;
; MessageText:
;
;  {EXCEPTION}
;  Alignment Fault
;  A datatype misalignment was detected in a load or store instruction.
;
STATUS_DATATYPE_MISALIGNMENT	 = 0x80000002	 ; winnt

;
; MessageId: STATUS_BREAKPOINT
;
; MessageText:
;
;  {EXCEPTION}
;  Breakpoint
;  A breakpoint has been reached.
;
STATUS_BREAKPOINT		 = 0x80000003	 ; winnt

;
; MessageId: STATUS_SINGLE_STEP
;
; MessageText:
;
;  {EXCEPTION}
;  Single Step
;  A single step or trace operation has just been completed.
;
STATUS_SINGLE_STEP		 = 0x80000004	 ; winnt

;
; MessageId: STATUS_BUFFER_OVERFLOW
;
; MessageText:
;
;  {Buffer Overflow}
;  The data was too large to fit into the specified buffer.
;
STATUS_BUFFER_OVERFLOW		 = 0x80000005

;
; MessageId: STATUS_NO_MORE_FILES
;
; MessageText:
;
;  {No More Files}
;  No more files were found which match the file specification.
;
STATUS_NO_MORE_FILES		 = 0x80000006

;
; MessageId: STATUS_WAKE_SYSTEM_DEBUGGER
;
; MessageText:
;
;  {Kernel Debugger Awakened}
;  the system debugger was awakened by an interrupt.
;
STATUS_WAKE_SYSTEM_DEBUGGER	 = 0x80000007

;
; MessageId: STATUS_HANDLES_CLOSED
;
; MessageText:
;
;  {Handles Closed}
;  Handles to objects have been automatically closed as a result of the requested operation.
;
STATUS_HANDLES_CLOSED		 = 0x8000000A

;
; MessageId: STATUS_NO_INHERITANCE
;
; MessageText:
;
;  {Non-Inheritable ACL}
;  An access control list (AC contains no components that can be inherited.
;
STATUS_NO_INHERITANCE		 = 0x8000000B

;
; MessageId: STATUS_GUID_SUBSTITUTION_MADE
;
; MessageText:
;
;  {GUID Substitution}
;  During the translation of a global identifier (GUID) to a Windows security ID (SID), no administratively-defined GUID prefix was found.
;  A substitute prefix was used, which will not compromise system security.
;  However, this may provide a more restrictive access than intended.
;
STATUS_GUID_SUBSTITUTION_MADE	 = 0x8000000C

;
; MessageId: STATUS_PARTIAL_COPY
;
; MessageText:
;
;  {Partial Copy}
;  Due to protection conflicts not all the requested bytes could be copied.
;
STATUS_PARTIAL_COPY		 = 0x8000000D

;
; MessageId: STATUS_DEVICE_PAPER_EMPTY
;
; MessageText:
;
;  {Out of Paper}
;  The printer is out of paper.
;
STATUS_DEVICE_PAPER_EMPTY	 = 0x8000000E

;
; MessageId: STATUS_DEVICE_POWERED_OFF
;
; MessageText:
;
;  {Device Power Is Off}
;  The printer power has been turned off.
;
STATUS_DEVICE_POWERED_OFF	 = 0x8000000F

;
; MessageId: STATUS_DEVICE_OFF_LINE
;
; MessageText:
;
;  {Device Offline}
;  The printer has been taken offline.
;
STATUS_DEVICE_OFF_LINE		 = 0x80000010

;
; MessageId: STATUS_DEVICE_BUSY
;
; MessageText:
;
;  {Device Busy}
;  The device is currently busy.
;
STATUS_DEVICE_BUSY		 = 0x80000011

;
; MessageId: STATUS_NO_MORE_EAS
;
; MessageText:
;
;  {No More EAs}
;  No more extended attributes (EAs) were found for the file.
;
STATUS_NO_MORE_EAS		 = 0x80000012

;
; MessageId: STATUS_INVALID_EA_NAME
;
; MessageText:
;
;  {Illegal EA}
;  The specified extended attribute (EA) name contains at least one illegal character.
;
STATUS_INVALID_EA_NAME		 = 0x80000013

;
; MessageId: STATUS_EA_LIST_INCONSISTENT
;
; MessageText:
;
;  {Inconsistent EA List}
;  The extended attribute (EA) list is inconsistent.
;
STATUS_EA_LIST_INCONSISTENT	 = 0x80000014

;
; MessageId: STATUS_INVALID_EA_FLAG
;
; MessageText:
;
;  {Invalid EA Flag}
;  An invalid extended attribute (EA) flag was set.
;
STATUS_INVALID_EA_FLAG		 = 0x80000015

;
; MessageId: STATUS_VERIFY_REQUIRED
;
; MessageText:
;
;  {Verifying Disk}
;  The media has changed and a verify operation is in progress so no reads or writes may be performed to the device, except those used in the verify operation.
;
STATUS_VERIFY_REQUIRED		 = 0x80000016

;
; MessageId: STATUS_EXTRANEOUS_INFORMATION
;
; MessageText:
;
;  {Too Much Information}
;  The specified access control list (AC contained more information than was expected.
;
STATUS_EXTRANEOUS_INFORMATION	 = 0x80000017

;
; MessageId: STATUS_RXACT_COMMIT_NECESSARY
;
; MessageText:
;
;  This warning level status indicates that the transaction state already exists for the registry sub-tree, but that a transaction commit was previously aborted.
;  The commit has NOT been completed, but has not been rolled back either (so it may still be committed if desired).
;
STATUS_RXACT_COMMIT_NECESSARY	 = 0x80000018

;
; MessageId: STATUS_NO_MORE_ENTRIES
;
; MessageText:
;
;  {No More Entries}
;  No more entries are available from an enumeration operation.
;
STATUS_NO_MORE_ENTRIES		 = 0x8000001A

;
; MessageId: STATUS_FILEMARK_DETECTED
;
; MessageText:
;
;  {Filemark Found}
;  A filemark was detected.
;
STATUS_FILEMARK_DETECTED	 = 0x8000001B

;
; MessageId: STATUS_MEDIA_CHANGED
;
; MessageText:
;
;  {Media Changed}
;  The media may have changed.
;
STATUS_MEDIA_CHANGED		 = 0x8000001C

;
; MessageId: STATUS_BUS_RESET
;
; MessageText:
;
;  {I/O Bus Reset}
;  An I/O bus reset was detected.
;
STATUS_BUS_RESET		 = 0x8000001D

;
; MessageId: STATUS_END_OF_MEDIA
;
; MessageText:
;
;  {End of Media}
;  The end of the media was encountered.
;
STATUS_END_OF_MEDIA		 = 0x8000001E

;
; MessageId: STATUS_BEGINNING_OF_MEDIA
;
; MessageText:
;
;  Beginning of tape or partition has been detected.
;
STATUS_BEGINNING_OF_MEDIA	 = 0x8000001F

;
; MessageId: STATUS_MEDIA_CHECK
;
; MessageText:
;
;  {Media Changed}
;  The media may have changed.
;
STATUS_MEDIA_CHECK		 = 0x80000020

;
; MessageId: STATUS_SETMARK_DETECTED
;
; MessageText:
;
;  A tape access reached a setmark.
;
STATUS_SETMARK_DETECTED 	 = 0x80000021

;
; MessageId: STATUS_NO_DATA_DETECTED
;
; MessageText:
;
;  During a tape access, the end of the data written is reached.
;
STATUS_NO_DATA_DETECTED 	 = 0x80000022

;
; MessageId: STATUS_REDIRECTOR_HAS_OPEN_HANDLES
;
; MessageText:
;
;  The redirector is in use and cannot be unloaded.
;
STATUS_REDIRECTOR_HAS_OPEN_HANDLES = 0x80000023

;
; MessageId: STATUS_SERVER_HAS_OPEN_HANDLES
;
; MessageText:
;
;  The server is in use and cannot be unloaded.
;
STATUS_SERVER_HAS_OPEN_HANDLES	 = 0x80000024

;
; MessageId: STATUS_ALREADY_DISCONNECTED
;
; MessageText:
;
;  The specified connection has already been disconnected.
;
STATUS_ALREADY_DISCONNECTED	 = 0x80000025

;
; MessageId: STATUS_LONGJUMP
;
; MessageText:
;
;  A long jump has been executed.
;
STATUS_LONGJUMP 		 = 0x80000026

;
; MessageId: STATUS_CLEANER_CARTRIDGE_INSTALLED
;
; MessageText:
;
;  A cleaner cartridge is present in the tape library.
;
STATUS_CLEANER_CARTRIDGE_INSTALLED = 0x80000027

;
; MessageId: STATUS_PLUGPLAY_QUERY_VETOED
;
; MessageText:
;
;  The Plug and Play query operation was not successful.
;
STATUS_PLUGPLAY_QUERY_VETOED	 = 0x80000028

;
; MessageId: STATUS_UNWIND_CONSOLIDATE
;
; MessageText:
;
;  A frame consolidation has been executed.
;
STATUS_UNWIND_CONSOLIDATE	 = 0x80000029

;
; MessageId: DBG_EXCEPTION_NOT_HANDLED
;
; MessageText:
;
;  Debugger did not handle the exception.
;
DBG_EXCEPTION_NOT_HANDLED	 = 0x80010001	 ; winnt

;
; MessageId: STATUS_CLUSTER_NODE_ALREADY_UP
;
; MessageText:
;
;  The cluster node is already up.
;
STATUS_CLUSTER_NODE_ALREADY_UP	 = 0x80130001

;
; MessageId: STATUS_CLUSTER_NODE_ALREADY_DOWN
;
; MessageText:
;
;  The cluster node is already down.
;
STATUS_CLUSTER_NODE_ALREADY_DOWN = 0x80130002

;
; MessageId: STATUS_CLUSTER_NETWORK_ALREADY_ONLINE
;
; MessageText:
;
;  The cluster network is already online.
;
STATUS_CLUSTER_NETWORK_ALREADY_ONLINE = 0x80130003

;
; MessageId: STATUS_CLUSTER_NETWORK_ALREADY_OFFLINE
;
; MessageText:
;
;  The cluster network is already offline.
;
STATUS_CLUSTER_NETWORK_ALREADY_OFFLINE = 0x80130004

;
; MessageId: STATUS_CLUSTER_NODE_ALREADY_MEMBER
;
; MessageText:
;
;  The cluster node is already a member of the cluster.
;
STATUS_CLUSTER_NODE_ALREADY_MEMBER = 0x80130005



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;/
;
;  Standard Error values
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;/

;
; MessageId: STATUS_UNSUCCESSFUL
;
; MessageText:
;
;  {Operation Failed}
;  The requested operation was unsuccessful.
;
STATUS_UNSUCCESSFUL		 = 0xC0000001

;
; MessageId: STATUS_NOT_IMPLEMENTED
;
; MessageText:
;
;  {Not Implemented}
;  The requested operation is not implemented.
;
STATUS_NOT_IMPLEMENTED		 = 0xC0000002

;
; MessageId: STATUS_INVALID_INFO_CLASS
;
; MessageText:
;
;  {Invalid Parameter}
;  The specified information class is not a valid information class for the specified object.
;
STATUS_INVALID_INFO_CLASS	 = 0xC0000003	 ; ntsubauth

;
; MessageId: STATUS_INFO_LENGTH_MISMATCH
;
; MessageText:
;
;  The specified information record length does not match the length required for the specified information class.
;
STATUS_INFO_LENGTH_MISMATCH	 = 0xC0000004

;
; MessageId: STATUS_ACCESS_VIOLATION
;
; MessageText:
;
;  The instruction at "= 0x%08lx" referenced memory at "= 0x%08lx". The memory could not be "%s".
;
STATUS_ACCESS_VIOLATION 	 = 0xC0000005	 ; winnt

;
; MessageId: STATUS_IN_PAGE_ERROR
;
; MessageText:
;
;  The instruction at "= 0x%08lx" referenced memory at "= 0x%08lx". The required data was not placed into memory because of an I/O error status of "= 0x%08lx".
;
STATUS_IN_PAGE_ERROR		 = 0xC0000006	 ; winnt

;
; MessageId: STATUS_PAGEFILE_QUOTA
;
; MessageText:
;
;  The pagefile quota for the process has been exhausted.
;
STATUS_PAGEFILE_QUOTA		 = 0xC0000007

;
; MessageId: STATUS_INVALID_HANDLE
;
; MessageText:
;
;  An invalid HANDLE was specified.
;
STATUS_INVALID_HANDLE		 = 0xC0000008	 ; winnt

;
; MessageId: STATUS_BAD_INITIAL_STACK
;
; MessageText:
;
;  An invalid initial stack was specified in a call to NtCreateThread.
;
STATUS_BAD_INITIAL_STACK	 = 0xC0000009

;
; MessageId: STATUS_BAD_INITIAL_PC
;
; MessageText:
;
;  An invalid initial start address was specified in a call to NtCreateThread.
;
STATUS_BAD_INITIAL_PC		 = 0xC000000A

;
; MessageId: STATUS_INVALID_CID
;
; MessageText:
;
;  An invalid Client ID was specified.
;
STATUS_INVALID_CID		 = 0xC000000B

;
; MessageId: STATUS_TIMER_NOT_CANCELED
;
; MessageText:
;
;  An attempt was made to cancel or set a timer that has an associated APC and the subject thread is not the thread that originally set the timer with an associated APC routine.
;
STATUS_TIMER_NOT_CANCELED	 = 0xC000000C

;
; MessageId: STATUS_INVALID_PARAMETER
;
; MessageText:
;
;  An invalid parameter was passed to a service or function.
;
STATUS_INVALID_PARAMETER	 = 0xC000000D

;
; MessageId: STATUS_NO_SUCH_DEVICE
;
; MessageText:
;
;  A device which does not exist was specified.
;
STATUS_NO_SUCH_DEVICE		 = 0xC000000E

;
; MessageId: STATUS_NO_SUCH_FILE
;
; MessageText:
;
;  {File Not Found}
;  The file %hs does not exist.
;
STATUS_NO_SUCH_FILE		 = 0xC000000F

;
; MessageId: STATUS_INVALID_DEVICE_REQUEST
;
; MessageText:
;
;  The specified request is not a valid operation for the target device.
;
STATUS_INVALID_DEVICE_REQUEST	 = 0xC0000010

;
; MessageId: STATUS_END_OF_FILE
;
; MessageText:
;
;  The end-of-file marker has been reached. There is no valid data in the file beyond this marker.
;
STATUS_END_OF_FILE		 = 0xC0000011

;
; MessageId: STATUS_WRONG_VOLUME
;
; MessageText:
;
;  {Wrong Volume}
;  The wrong volume is in the drive.
;  Please insert volume %hs into drive %hs.
;
STATUS_WRONG_VOLUME		 = 0xC0000012

;
; MessageId: STATUS_NO_MEDIA_IN_DEVICE
;
; MessageText:
;
;  {No Disk}
;  There is no disk in the drive.
;  Please insert a disk into drive %hs.
;
STATUS_NO_MEDIA_IN_DEVICE	 = 0xC0000013

;
; MessageId: STATUS_UNRECOGNIZED_MEDIA
;
; MessageText:
;
;  {Unknown Disk Format}
;  The disk in drive %hs is not formatted properly.
;  Please check the disk, and reformat if necessary.
;
STATUS_UNRECOGNIZED_MEDIA	 = 0xC0000014

;
; MessageId: STATUS_NONEXISTENT_SECTOR
;
; MessageText:
;
;  {Sector Not Found}
;  The specified sector does not exist.
;
STATUS_NONEXISTENT_SECTOR	 = 0xC0000015

;
; MessageId: STATUS_MORE_PROCESSING_REQUIRED
;
; MessageText:
;
;  {Still Busy}
;  The specified I/O request packet (IRP) cannot be disposed of because the I/O operation is not complete.
;
STATUS_MORE_PROCESSING_REQUIRED  = 0xC0000016

;
; MessageId: STATUS_NO_MEMORY
;
; MessageText:
;
;  {Not Enough Quota}
;  Not enough virtual memory or paging file quota is available to complete the specified operation.
;
STATUS_NO_MEMORY		 = 0xC0000017	 ; winnt

;
; MessageId: STATUS_CONFLICTING_ADDRESSES
;
; MessageText:
;
;  {Conflicting Address Range}
;  The specified address range conflicts with the address space.
;
STATUS_CONFLICTING_ADDRESSES	 = 0xC0000018

;
; MessageId: STATUS_NOT_MAPPED_VIEW
;
; MessageText:
;
;  Address range to unmap is not a mapped view.
;
STATUS_NOT_MAPPED_VIEW		 = 0xC0000019

;
; MessageId: STATUS_UNABLE_TO_FREE_VM
;
; MessageText:
;
;  Virtual memory cannot be freed.
;
STATUS_UNABLE_TO_FREE_VM	 = 0xC000001A

;
; MessageId: STATUS_UNABLE_TO_DELETE_SECTION
;
; MessageText:
;
;  Specified section cannot be deleted.
;
STATUS_UNABLE_TO_DELETE_SECTION  = 0xC000001B

;
; MessageId: STATUS_INVALID_SYSTEM_SERVICE
;
; MessageText:
;
;  An invalid system service was specified in a system service call.
;
STATUS_INVALID_SYSTEM_SERVICE	 = 0xC000001C

;
; MessageId: STATUS_ILLEGAL_INSTRUCTION
;
; MessageText:
;
;  {EXCEPTION}
;  Illegal Instruction
;  An attempt was made to execute an illegal instruction.
;
STATUS_ILLEGAL_INSTRUCTION	 = 0xC000001D	 ; winnt

;
; MessageId: STATUS_INVALID_LOCK_SEQUENCE
;
; MessageText:
;
;  {Invalid Lock Sequence}
;  An attempt was made to execute an invalid lock sequence.
;
STATUS_INVALID_LOCK_SEQUENCE	 = 0xC000001E

;
; MessageId: STATUS_INVALID_VIEW_SIZE
;
; MessageText:
;
;  {Invalid Mapping}
;  An attempt was made to create a view for a section which is bigger than the section.
;
STATUS_INVALID_VIEW_SIZE	 = 0xC000001F

;
; MessageId: STATUS_INVALID_FILE_FOR_SECTION
;
; MessageText:
;
;  {Bad File}
;  The attributes of the specified mapping file for a section of memory cannot be read.
;
STATUS_INVALID_FILE_FOR_SECTION  = 0xC0000020

;
; MessageId: STATUS_ALREADY_COMMITTED
;
; MessageText:
;
;  {Already Committed}
;  The specified address range is already committed.
;
STATUS_ALREADY_COMMITTED	 = 0xC0000021

;
; MessageId: STATUS_ACCESS_DENIED
;
; MessageText:
;
;  {Access Denied}
;  A process has requested access to an object, but has not been granted those access rights.
;
STATUS_ACCESS_DENIED		 = 0xC0000022

;
; MessageId: STATUS_BUFFER_TOO_SMALL
;
; MessageText:
;
;  {Buffer Too Small}
;  The buffer is too small to contain the entry. No information has been written to the buffer.
;
STATUS_BUFFER_TOO_SMALL 	 = 0xC0000023

;
; MessageId: STATUS_OBJECT_TYPE_MISMATCH
;
; MessageText:
;
;  {Wrong Type}
;  There is a mismatch between the type of object required by the requested operation and the type of object that is specified in the request.
;
STATUS_OBJECT_TYPE_MISMATCH	 = 0xC0000024

;
; MessageId: STATUS_NONCONTINUABLE_EXCEPTION
;
; MessageText:
;
;  {EXCEPTION}
;  Cannot Continue
;  Windows cannot continue from this exception.
;
STATUS_NONCONTINUABLE_EXCEPTION  = 0xC0000025	 ; winnt

;
; MessageId: STATUS_INVALID_DISPOSITION
;
; MessageText:
;
;  An invalid exception disposition was returned by an exception handler.
;
STATUS_INVALID_DISPOSITION	 = 0xC0000026	 ; winnt

;
; MessageId: STATUS_UNWIND
;
; MessageText:
;
;  Unwind exception code.
;
STATUS_UNWIND			 = 0xC0000027

;
; MessageId: STATUS_BAD_STACK
;
; MessageText:
;
;  An invalid or unaligned stack was encountered during an unwind operation.
;
STATUS_BAD_STACK		 = 0xC0000028

;
; MessageId: STATUS_INVALID_UNWIND_TARGET
;
; MessageText:
;
;  An invalid unwind target was encountered during an unwind operation.
;
STATUS_INVALID_UNWIND_TARGET	 = 0xC0000029

;
; MessageId: STATUS_NOT_LOCKED
;
; MessageText:
;
;  An attempt was made to unlock a page of memory which was not locked.
;
STATUS_NOT_LOCKED		 = 0xC000002A

;
; MessageId: STATUS_PARITY_ERROR
;
; MessageText:
;
;  Device parity error on I/O operation.
;
STATUS_PARITY_ERROR		 = 0xC000002B

;
; MessageId: STATUS_UNABLE_TO_DECOMMIT_VM
;
; MessageText:
;
;  An attempt was made to decommit uncommitted virtual memory.
;
STATUS_UNABLE_TO_DECOMMIT_VM	 = 0xC000002C

;
; MessageId: STATUS_NOT_COMMITTED
;
; MessageText:
;
;  An attempt was made to change the attributes on memory that has not been committed.
;
STATUS_NOT_COMMITTED		 = 0xC000002D

;
; MessageId: STATUS_INVALID_PORT_ATTRIBUTES
;
; MessageText:
;
;  Invalid Object Attributes specified to NtCreatePort or invalid Port Attributes specified to NtConnectPort
;
STATUS_INVALID_PORT_ATTRIBUTES	 = 0xC000002E

;
; MessageId: STATUS_PORT_MESSAGE_TOO_LONG
;
; MessageText:
;
;  Length of message passed to NtRequestPort or NtRequestWaitReplyPort was longer than the maximum message allowed by the port.
;
STATUS_PORT_MESSAGE_TOO_LONG	 = 0xC000002F

;
; MessageId: STATUS_INVALID_PARAMETER_MIX
;
; MessageText:
;
;  An invalid combination of parameters was specified.
;
STATUS_INVALID_PARAMETER_MIX	 = 0xC0000030

;
; MessageId: STATUS_INVALID_QUOTA_LOWER
;
; MessageText:
;
;  An attempt was made to lower a quota limit below the current usage.
;
STATUS_INVALID_QUOTA_LOWER	 = 0xC0000031

;
; MessageId: STATUS_DISK_CORRUPT_ERROR
;
; MessageText:
;
;  {Corrupt Disk}
;  The file system structure on the disk is corrupt and unusable.
;  Please run the Chkdsk utility on the volume %hs.
;
STATUS_DISK_CORRUPT_ERROR	 = 0xC0000032

;
; MessageId: STATUS_OBJECT_NAME_INVALID
;
; MessageText:
;
;  Object Name invalid.
;
STATUS_OBJECT_NAME_INVALID	 = 0xC0000033

;
; MessageId: STATUS_OBJECT_NAME_NOT_FOUND
;
; MessageText:
;
;  Object Name not found.
;
STATUS_OBJECT_NAME_NOT_FOUND	 = 0xC0000034

;
; MessageId: STATUS_OBJECT_NAME_COLLISION
;
; MessageText:
;
;  Object Name already exists.
;
STATUS_OBJECT_NAME_COLLISION	 = 0xC0000035

;
; MessageId: STATUS_PORT_DISCONNECTED
;
; MessageText:
;
;  Attempt to send a message to a disconnected communication port.
;
STATUS_PORT_DISCONNECTED	 = 0xC0000037

;
; MessageId: STATUS_DEVICE_ALREADY_ATTACHED
;
; MessageText:
;
;  An attempt was made to attach to a device that was already attached to another device.
;
STATUS_DEVICE_ALREADY_ATTACHED	 = 0xC0000038

;
; MessageId: STATUS_OBJECT_PATH_INVALID
;
; MessageText:
;
;  Object Path Component was not a directory object.
;
STATUS_OBJECT_PATH_INVALID	 = 0xC0000039

;
; MessageId: STATUS_OBJECT_PATH_NOT_FOUND
;
; MessageText:
;
;  {Path Not Found}
;  The path %hs does not exist.
;
STATUS_OBJECT_PATH_NOT_FOUND	 = 0xC000003A

;
; MessageId: STATUS_OBJECT_PATH_SYNTAX_BAD
;
; MessageText:
;
;  Object Path Component was not a directory object.
;
STATUS_OBJECT_PATH_SYNTAX_BAD	 = 0xC000003B

;
; MessageId: STATUS_DATA_OVERRUN
;
; MessageText:
;
;  {Data Overrun}
;  A data overrun error occurred.
;
STATUS_DATA_OVERRUN		 = 0xC000003C

;
; MessageId: STATUS_DATA_LATE_ERROR
;
; MessageText:
;
;  {Data Late}
;  A data late error occurred.
;
STATUS_DATA_LATE_ERROR		 = 0xC000003D

;
; MessageId: STATUS_DATA_ERROR
;
; MessageText:
;
;  {Data Error}
;  An error in reading or writing data occurred.
;
STATUS_DATA_ERROR		 = 0xC000003E

;
; MessageId: STATUS_CRC_ERROR
;
; MessageText:
;
;  {Bad CRC}
;  A cyclic redundancy check (CRC) checksum error occurred.
;
STATUS_CRC_ERROR		 = 0xC000003F

;
; MessageId: STATUS_SECTION_TOO_BIG
;
; MessageText:
;
;  {Section Too Large}
;  The specified section is too big to map the file.
;
STATUS_SECTION_TOO_BIG		 = 0xC0000040

;
; MessageId: STATUS_PORT_CONNECTION_REFUSED
;
; MessageText:
;
;  The NtConnectPort request is refused.
;
STATUS_PORT_CONNECTION_REFUSED	 = 0xC0000041

;
; MessageId: STATUS_INVALID_PORT_HANDLE
;
; MessageText:
;
;  The type of port handle is invalid for the operation requested.
;
STATUS_INVALID_PORT_HANDLE	 = 0xC0000042

;
; MessageId: STATUS_SHARING_VIOLATION
;
; MessageText:
;
;  A file cannot be opened because the share access flags are incompatible.
;
STATUS_SHARING_VIOLATION	 = 0xC0000043

;
; MessageId: STATUS_QUOTA_EXCEEDED
;
; MessageText:
;
;  Insufficient quota exists to complete the operation
;
STATUS_QUOTA_EXCEEDED		 = 0xC0000044

;
; MessageId: STATUS_INVALID_PAGE_PROTECTION
;
; MessageText:
;
;  The specified page protection was not valid.
;
STATUS_INVALID_PAGE_PROTECTION	 = 0xC0000045

;
; MessageId: STATUS_MUTANT_NOT_OWNED
;
; MessageText:
;
;  An attempt to release a mutant object was made by a thread that was not the owner of the mutant object.
;
STATUS_MUTANT_NOT_OWNED 	 = 0xC0000046

;
; MessageId: STATUS_SEMAPHORE_LIMIT_EXCEEDED
;
; MessageText:
;
;  An attempt was made to release a semaphore such that its maximum count would have been exceeded.
;
STATUS_SEMAPHORE_LIMIT_EXCEEDED  = 0xC0000047

;
; MessageId: STATUS_PORT_ALREADY_SET
;
; MessageText:
;
;  An attempt to set a processes DebugPort or ExceptionPort was made, but a port already exists in the process.
;
STATUS_PORT_ALREADY_SET 	 = 0xC0000048

;
; MessageId: STATUS_SECTION_NOT_IMAGE
;
; MessageText:
;
;  An attempt was made to query image information on a section which does not map an image.
;
STATUS_SECTION_NOT_IMAGE	 = 0xC0000049

;
; MessageId: STATUS_SUSPEND_COUNT_EXCEEDED
;
; MessageText:
;
;  An attempt was made to suspend a thread whose suspend count was at its maximum.
;
STATUS_SUSPEND_COUNT_EXCEEDED	 = 0xC000004A

;
; MessageId: STATUS_THREAD_IS_TERMINATING
;
; MessageText:
;
;  An attempt was made to suspend a thread that has begun termination.
;
STATUS_THREAD_IS_TERMINATING	 = 0xC000004B

;
; MessageId: STATUS_BAD_WORKING_SET_LIMIT
;
; MessageText:
;
;  An attempt was made to set the working set limit to an invalid value (minimum greater than maximum, etc).
;
STATUS_BAD_WORKING_SET_LIMIT	 = 0xC000004C

;
; MessageId: STATUS_INCOMPATIBLE_FILE_MAP
;
; MessageText:
;
;  A section was created to map a file which is not compatible to an already existing section which maps the same file.
;
STATUS_INCOMPATIBLE_FILE_MAP	 = 0xC000004D

;
; MessageId: STATUS_SECTION_PROTECTION
;
; MessageText:
;
;  A view to a section specifies a protection which is incompatible with the initial view's protection.
;
STATUS_SECTION_PROTECTION	 = 0xC000004E

;
; MessageId: STATUS_EAS_NOT_SUPPORTED
;
; MessageText:
;
;  An operation involving EAs failed because the file system does not support EAs.
;
STATUS_EAS_NOT_SUPPORTED	 = 0xC000004F

;
; MessageId: STATUS_EA_TOO_LARGE
;
; MessageText:
;
;  An EA operation failed because EA set is too large.
;
STATUS_EA_TOO_LARGE		 = 0xC0000050

;
; MessageId: STATUS_NONEXISTENT_EA_ENTRY
;
; MessageText:
;
;  An EA operation failed because the name or EA index is invalid.
;
STATUS_NONEXISTENT_EA_ENTRY	 = 0xC0000051

;
; MessageId: STATUS_NO_EAS_ON_FILE
;
; MessageText:
;
;  The file for which EAs were requested has no EAs.
;
STATUS_NO_EAS_ON_FILE		 = 0xC0000052

;
; MessageId: STATUS_EA_CORRUPT_ERROR
;
; MessageText:
;
;  The EA is corrupt and non-readable.
;
STATUS_EA_CORRUPT_ERROR 	 = 0xC0000053

;
; MessageId: STATUS_FILE_LOCK_CONFLICT
;
; MessageText:
;
;  A requested read/write cannot be granted due to a conflicting file lock.
;
STATUS_FILE_LOCK_CONFLICT	 = 0xC0000054

;
; MessageId: STATUS_LOCK_NOT_GRANTED
;
; MessageText:
;
;  A requested file lock cannot be granted due to other existing locks.
;
STATUS_LOCK_NOT_GRANTED 	 = 0xC0000055

;
; MessageId: STATUS_DELETE_PENDING
;
; MessageText:
;
;  A non close operation has been requested of a file object with a delete pending.
;
STATUS_DELETE_PENDING		 = 0xC0000056

;
; MessageId: STATUS_CTL_FILE_NOT_SUPPORTED
;
; MessageText:
;
;  An attempt was made to set the control attribute on a file. This attribute is not supported in the target file system.
;
STATUS_CTL_FILE_NOT_SUPPORTED	 = 0xC0000057

;
; MessageId: STATUS_UNKNOWN_REVISION
;
; MessageText:
;
;  Indicates a revision number encountered or specified is not one known by the service. It may be a more recent revision than the service is aware of.
;
STATUS_UNKNOWN_REVISION 	 = 0xC0000058

;
; MessageId: STATUS_REVISION_MISMATCH
;
; MessageText:
;
;  Indicates two revision levels are incompatible.
;
STATUS_REVISION_MISMATCH	 = 0xC0000059

;
; MessageId: STATUS_INVALID_OWNER
;
; MessageText:
;
;  Indicates a particular Security ID may not be assigned as the owner of an object.
;
STATUS_INVALID_OWNER		 = 0xC000005A

;
; MessageId: STATUS_INVALID_PRIMARY_GROUP
;
; MessageText:
;
;  Indicates a particular Security ID may not be assigned as the primary group of an object.
;
STATUS_INVALID_PRIMARY_GROUP	 = 0xC000005B

;
; MessageId: STATUS_NO_IMPERSONATION_TOKEN
;
; MessageText:
;
;  An attempt has been made to operate on an impersonation token by a thread that is not currently impersonating a client.
;
STATUS_NO_IMPERSONATION_TOKEN	 = 0xC000005C

;
; MessageId: STATUS_CANT_DISABLE_MANDATORY
;
; MessageText:
;
;  A mandatory group may not be disabled.
;
STATUS_CANT_DISABLE_MANDATORY	 = 0xC000005D

;
; MessageId: STATUS_NO_LOGON_SERVERS
;
; MessageText:
;
;  There are currently no logon servers available to service the logon request.
;
STATUS_NO_LOGON_SERVERS 	 = 0xC000005E

;
; MessageId: STATUS_NO_SUCH_LOGON_SESSION
;
; MessageText:
;
;  A specified logon session does not exist. It may already have been terminated.
;
STATUS_NO_SUCH_LOGON_SESSION	 = 0xC000005F

;
; MessageId: STATUS_NO_SUCH_PRIVILEGE
;
; MessageText:
;
;  A specified privilege does not exist.
;
STATUS_NO_SUCH_PRIVILEGE	 = 0xC0000060

;
; MessageId: STATUS_PRIVILEGE_NOT_HELD
;
; MessageText:
;
;  A required privilege is not held by the client.
;
STATUS_PRIVILEGE_NOT_HELD	 = 0xC0000061

;
; MessageId: STATUS_INVALID_ACCOUNT_NAME
;
; MessageText:
;
;  The name provided is not a properly formed account name.
;
STATUS_INVALID_ACCOUNT_NAME	 = 0xC0000062

;
; MessageId: STATUS_USER_EXISTS
;
; MessageText:
;
;  The specified user already exists.
;
STATUS_USER_EXISTS		 = 0xC0000063

;
; MessageId: STATUS_NO_SUCH_USER
;
; MessageText:
;
;  The specified user does not exist.
;
STATUS_NO_SUCH_USER		 = 0xC0000064	  ; ntsubauth

;
; MessageId: STATUS_GROUP_EXISTS
;
; MessageText:
;
;  The specified group already exists.
;
STATUS_GROUP_EXISTS		 = 0xC0000065

;
; MessageId: STATUS_NO_SUCH_GROUP
;
; MessageText:
;
;  The specified group does not exist.
;
STATUS_NO_SUCH_GROUP		 = 0xC0000066

;
; MessageId: STATUS_MEMBER_IN_GROUP
;
; MessageText:
;
;  The specified user account is already in the specified group account.
;  Also used to indicate a group cannot be deleted because it contains a member.
;
STATUS_MEMBER_IN_GROUP		 = 0xC0000067

;
; MessageId: STATUS_MEMBER_NOT_IN_GROUP
;
; MessageText:
;
;  The specified user account is not a member of the specified group account.
;
STATUS_MEMBER_NOT_IN_GROUP	 = 0xC0000068

;
; MessageId: STATUS_LAST_ADMIN
;
; MessageText:
;
;  Indicates the requested operation would disable or delete the last remaining administration account.
;  This is not allowed to prevent creating a situation in which the system cannot be administrated.
;
STATUS_LAST_ADMIN		 = 0xC0000069

;
; MessageId: STATUS_WRONG_PASSWORD
;
; MessageText:
;
;  When trying to update a password, this return status indicates that the value provided as the current password is not correct.
;
STATUS_WRONG_PASSWORD		 = 0xC000006A	  ; ntsubauth

;
; MessageId: STATUS_ILL_FORMED_PASSWORD
;
; MessageText:
;
;  When trying to update a password, this return status indicates that the value provided for the new password contains values that are not allowed in passwords.
;
STATUS_ILL_FORMED_PASSWORD	 = 0xC000006B

;
; MessageId: STATUS_PASSWORD_RESTRICTION
;
; MessageText:
;
;  When trying to update a password, this status indicates that some password update rule has been violated. For example, the password may not meet length criteria.
;
STATUS_PASSWORD_RESTRICTION	 = 0xC000006C	  ; ntsubauth

;
; MessageId: STATUS_LOGON_FAILURE
;
; MessageText:
;
;  The attempted logon is invalid. This is either due to a bad username or authentication information.
;
STATUS_LOGON_FAILURE		 = 0xC000006D	  ; ntsubauth

;
; MessageId: STATUS_ACCOUNT_RESTRICTION
;
; MessageText:
;
;  Indicates a referenced user name and authentication information are valid, but some user account restriction has prevented successful authentication (such as time-of-day restrictions).
;
STATUS_ACCOUNT_RESTRICTION	 = 0xC000006E	  ; ntsubauth

;
; MessageId: STATUS_INVALID_LOGON_HOURS
;
; MessageText:
;
;  The user account has time restrictions and may not be logged onto at this time.
;
STATUS_INVALID_LOGON_HOURS	 = 0xC000006F	  ; ntsubauth

;
; MessageId: STATUS_INVALID_WORKSTATION
;
; MessageText:
;
;  The user account is restricted such that it may not be used to log on from the source workstation.
;
STATUS_INVALID_WORKSTATION	 = 0xC0000070	  ; ntsubauth

;
; MessageId: STATUS_PASSWORD_EXPIRED
;
; MessageText:
;
;  The user account's password has expired.
;
STATUS_PASSWORD_EXPIRED 	 = 0xC0000071	  ; ntsubauth

;
; MessageId: STATUS_ACCOUNT_DISABLED
;
; MessageText:
;
;  The referenced account is currently disabled and may not be logged on to.
;
STATUS_ACCOUNT_DISABLED 	 = 0xC0000072	  ; ntsubauth

;
; MessageId: STATUS_NONE_MAPPED
;
; MessageText:
;
;  None of the information to be translated has been translated.
;
STATUS_NONE_MAPPED		 = 0xC0000073

;
; MessageId: STATUS_TOO_MANY_LUIDS_REQUESTED
;
; MessageText:
;
;  The number of LUIDs requested may not be allocated with a single allocation.
;
STATUS_TOO_MANY_LUIDS_REQUESTED  = 0xC0000074

;
; MessageId: STATUS_LUIDS_EXHAUSTED
;
; MessageText:
;
;  Indicates there are no more LUIDs to allocate.
;
STATUS_LUIDS_EXHAUSTED		 = 0xC0000075

;
; MessageId: STATUS_INVALID_SUB_AUTHORITY
;
; MessageText:
;
;  Indicates the sub-authority value is invalid for the particular use.
;
STATUS_INVALID_SUB_AUTHORITY	 = 0xC0000076

;
; MessageId: STATUS_INVALID_ACL
;
; MessageText:
;
;  Indicates the ACL structure is not valid.
;
STATUS_INVALID_ACL		 = 0xC0000077

;
; MessageId: STATUS_INVALID_SID
;
; MessageText:
;
;  Indicates the SID structure is not valid.
;
STATUS_INVALID_SID		 = 0xC0000078

;
; MessageId: STATUS_INVALID_SECURITY_DESCR
;
; MessageText:
;
;  Indicates the SECURITY_DESCRIPTOR structure is not valid.
;
STATUS_INVALID_SECURITY_DESCR	 = 0xC0000079

;
; MessageId: STATUS_PROCEDURE_NOT_FOUND
;
; MessageText:
;
;  Indicates the specified procedure address cannot be found in the DLL.
;
STATUS_PROCEDURE_NOT_FOUND	 = 0xC000007A

;
; MessageId: STATUS_INVALID_IMAGE_FORMAT
;
; MessageText:
;
;  {Bad Image}
;  The application or DLL %hs is not a valid Windows image. Please check this against your installation diskette.
;
STATUS_INVALID_IMAGE_FORMAT	 = 0xC000007B

;
; MessageId: STATUS_NO_TOKEN
;
; MessageText:
;
;  An attempt was made to reference a token that doesn't exist.
;  This is typically done by referencing the token associated with a thread when the thread is not impersonating a client.
;
STATUS_NO_TOKEN 		 = 0xC000007C

;
; MessageId: STATUS_BAD_INHERITANCE_ACL
;
; MessageText:
;
;  Indicates that an attempt to build either an inherited ACL or ACE was not successful.
;  This can be caused by a number of things. One of the more probable causes is the replacement of a CreatorId with an SID that didn't fit into the ACE or ACL.
;
STATUS_BAD_INHERITANCE_ACL	 = 0xC000007D

;
; MessageId: STATUS_RANGE_NOT_LOCKED
;
; MessageText:
;
;  The range specified in NtUnlockFile was not locked.
;
STATUS_RANGE_NOT_LOCKED 	 = 0xC000007E

;
; MessageId: STATUS_DISK_FULL
;
; MessageText:
;
;  An operation failed because the disk was full.
;
STATUS_DISK_FULL		 = 0xC000007F

;
; MessageId: STATUS_SERVER_DISABLED
;
; MessageText:
;
;  The GUID allocation server is [already] disabled at the moment.
;
STATUS_SERVER_DISABLED		 = 0xC0000080

;
; MessageId: STATUS_SERVER_NOT_DISABLED
;
; MessageText:
;
;  The GUID allocation server is [already] enabled at the moment.
;
STATUS_SERVER_NOT_DISABLED	 = 0xC0000081

;
; MessageId: STATUS_TOO_MANY_GUIDS_REQUESTED
;
; MessageText:
;
;  Too many GUIDs were requested from the allocation server at once.
;
STATUS_TOO_MANY_GUIDS_REQUESTED  = 0xC0000082

;
; MessageId: STATUS_GUIDS_EXHAUSTED
;
; MessageText:
;
;  The GUIDs could not be allocated because the Authority Agent was exhausted.
;
STATUS_GUIDS_EXHAUSTED		 = 0xC0000083

;
; MessageId: STATUS_INVALID_ID_AUTHORITY
;
; MessageText:
;
;  The value provided was an invalid value for an identifier authority.
;
STATUS_INVALID_ID_AUTHORITY	 = 0xC0000084

;
; MessageId: STATUS_AGENTS_EXHAUSTED
;
; MessageText:
;
;  There are no more authority agent values available for the given identifier authority value.
;
STATUS_AGENTS_EXHAUSTED 	 = 0xC0000085

;
; MessageId: STATUS_INVALID_VOLUME_LABEL
;
; MessageText:
;
;  An invalid volume label has been specified.
;
STATUS_INVALID_VOLUME_LABEL	 = 0xC0000086

;
; MessageId: STATUS_SECTION_NOT_EXTENDED
;
; MessageText:
;
;  A mapped section could not be extended.
;
STATUS_SECTION_NOT_EXTENDED	 = 0xC0000087

;
; MessageId: STATUS_NOT_MAPPED_DATA
;
; MessageText:
;
;  Specified section to flush does not map a data file.
;
STATUS_NOT_MAPPED_DATA		 = 0xC0000088

;
; MessageId: STATUS_RESOURCE_DATA_NOT_FOUND
;
; MessageText:
;
;  Indicates the specified image file did not contain a resource section.
;
STATUS_RESOURCE_DATA_NOT_FOUND	 = 0xC0000089

;
; MessageId: STATUS_RESOURCE_TYPE_NOT_FOUND
;
; MessageText:
;
;  Indicates the specified resource type cannot be found in the image file.
;
STATUS_RESOURCE_TYPE_NOT_FOUND	 = 0xC000008A

;
; MessageId: STATUS_RESOURCE_NAME_NOT_FOUND
;
; MessageText:
;
;  Indicates the specified resource name cannot be found in the image file.
;
STATUS_RESOURCE_NAME_NOT_FOUND	 = 0xC000008B

;
; MessageId: STATUS_ARRAY_BOUNDS_EXCEEDED
;
; MessageText:
;
;  {EXCEPTION}
;  Array bounds exceeded.
;
STATUS_ARRAY_BOUNDS_EXCEEDED	 = 0xC000008C	 ; winnt

;
; MessageId: STATUS_FLOAT_DENORMAL_OPERAND
;
; MessageText:
;
;  {EXCEPTION}
;  Floating-point denormal operand.
;
STATUS_FLOAT_DENORMAL_OPERAND	 = 0xC000008D	 ; winnt

;
; MessageId: STATUS_FLOAT_DIVIDE_BY_ZERO
;
; MessageText:
;
;  {EXCEPTION}
;  Floating-point division by zero.
;
STATUS_FLOAT_DIVIDE_BY_ZERO	 = 0xC000008E	 ; winnt

;
; MessageId: STATUS_FLOAT_INEXACT_RESULT
;
; MessageText:
;
;  {EXCEPTION}
;  Floating-point inexact result.
;
STATUS_FLOAT_INEXACT_RESULT	 = 0xC000008F	 ; winnt

;
; MessageId: STATUS_FLOAT_INVALID_OPERATION
;
; MessageText:
;
;  {EXCEPTION}
;  Floating-point invalid operation.
;
STATUS_FLOAT_INVALID_OPERATION	 = 0xC0000090	 ; winnt

;
; MessageId: STATUS_FLOAT_OVERFLOW
;
; MessageText:
;
;  {EXCEPTION}
;  Floating-point overflow.
;
STATUS_FLOAT_OVERFLOW		 = 0xC0000091	 ; winnt

;
; MessageId: STATUS_FLOAT_STACK_CHECK
;
; MessageText:
;
;  {EXCEPTION}
;  Floating-point stack check.
;
STATUS_FLOAT_STACK_CHECK	 = 0xC0000092	 ; winnt

;
; MessageId: STATUS_FLOAT_UNDERFLOW
;
; MessageText:
;
;  {EXCEPTION}
;  Floating-point underflow.
;
STATUS_FLOAT_UNDERFLOW		 = 0xC0000093	 ; winnt

;
; MessageId: STATUS_INTEGER_DIVIDE_BY_ZERO
;
; MessageText:
;
;  {EXCEPTION}
;  Integer division by zero.
;
STATUS_INTEGER_DIVIDE_BY_ZERO	 = 0xC0000094	 ; winnt

;
; MessageId: STATUS_INTEGER_OVERFLOW
;
; MessageText:
;
;  {EXCEPTION}
;  Integer overflow.
;
STATUS_INTEGER_OVERFLOW 	 = 0xC0000095	 ; winnt

;
; MessageId: STATUS_PRIVILEGED_INSTRUCTION
;
; MessageText:
;
;  {EXCEPTION}
;  Privileged instruction.
;
STATUS_PRIVILEGED_INSTRUCTION	 = 0xC0000096	 ; winnt

;
; MessageId: STATUS_TOO_MANY_PAGING_FILES
;
; MessageText:
;
;  An attempt was made to install more paging files than the system supports.
;
STATUS_TOO_MANY_PAGING_FILES	 = 0xC0000097

;
; MessageId: STATUS_FILE_INVALID
;
; MessageText:
;
;  The volume for a file has been externally altered such that the opened file is no longer valid.
;
STATUS_FILE_INVALID		 = 0xC0000098

;
; MessageId: STATUS_ALLOTTED_SPACE_EXCEEDED
;
; MessageText:
;
;  When a block of memory is allotted for future updates, such as the memory allocated to hold discretionary access control and primary group information, successive updates may exceed the amount of memory originally allotted.
;  Since quota may already have been charged to several processes which have handles to the object, it is not reasonable to alter the size of the allocated memory.
;  Instead, a request that requires more memory than has been allotted must fail and the STATUS_ALLOTED_SPACE_EXCEEDED error returned.
;
STATUS_ALLOTTED_SPACE_EXCEEDED	 = 0xC0000099

;
; MessageId: STATUS_INSUFFICIENT_RESOURCES
;
; MessageText:
;
;  Insufficient system resources exist to complete the API.
;
STATUS_INSUFFICIENT_RESOURCES	 = 0xC000009A	  ; ntsubauth

;
; MessageId: STATUS_DFS_EXIT_PATH_FOUND
;
; MessageText:
;
;  An attempt has been made to open a DFS exit path control file.
;
STATUS_DFS_EXIT_PATH_FOUND	 = 0xC000009B

;
; MessageId: STATUS_DEVICE_DATA_ERROR
;
; MessageText:
;
;  STATUS_DEVICE_DATA_ERROR
;
STATUS_DEVICE_DATA_ERROR	 = 0xC000009C

;
; MessageId: STATUS_DEVICE_NOT_CONNECTED
;
; MessageText:
;
;  STATUS_DEVICE_NOT_CONNECTED
;
STATUS_DEVICE_NOT_CONNECTED	 = 0xC000009D

;
; MessageId: STATUS_DEVICE_POWER_FAILURE
;
; MessageText:
;
;  STATUS_DEVICE_POWER_FAILURE
;
STATUS_DEVICE_POWER_FAILURE	 = 0xC000009E

;
; MessageId: STATUS_FREE_VM_NOT_AT_BASE
;
; MessageText:
;
;  Virtual memory cannot be freed as base address is not the base of the region and a region size of zero was specified.
;
STATUS_FREE_VM_NOT_AT_BASE	 = 0xC000009F

;
; MessageId: STATUS_MEMORY_NOT_ALLOCATED
;
; MessageText:
;
;  An attempt was made to free virtual memory which is not allocated.
;
STATUS_MEMORY_NOT_ALLOCATED	 = 0xC00000A0

;
; MessageId: STATUS_WORKING_SET_QUOTA
;
; MessageText:
;
;  The working set is not big enough to allow the requested pages to be locked.
;
STATUS_WORKING_SET_QUOTA	 = 0xC00000A1

;
; MessageId: STATUS_MEDIA_WRITE_PROTECTED
;
; MessageText:
;
;  {Write Protect Error}
;  The disk cannot be written to because it is write protected.
;  Please remove the write protection from the volume %hs in drive %hs.
;
STATUS_MEDIA_WRITE_PROTECTED	 = 0xC00000A2

;
; MessageId: STATUS_DEVICE_NOT_READY
;
; MessageText:
;
;  {Drive Not Ready}
;  The drive is not ready for use; its door may be open.
;  Please check drive %hs and make sure that a disk is inserted and that the drive door is closed.
;
STATUS_DEVICE_NOT_READY 	 = 0xC00000A3

;
; MessageId: STATUS_INVALID_GROUP_ATTRIBUTES
;
; MessageText:
;
;  The specified attributes are invalid, or incompatible with the attributes for the group as a whole.
;
STATUS_INVALID_GROUP_ATTRIBUTES  = 0xC00000A4

;
; MessageId: STATUS_BAD_IMPERSONATION_LEVEL
;
; MessageText:
;
;  A specified impersonation level is invalid.
;  Also used to indicate a required impersonation level was not provided.
;
STATUS_BAD_IMPERSONATION_LEVEL	 = 0xC00000A5

;
; MessageId: STATUS_CANT_OPEN_ANONYMOUS
;
; MessageText:
;
;  An attempt was made to open an Anonymous level token.
;  Anonymous tokens may not be opened.
;
STATUS_CANT_OPEN_ANONYMOUS	 = 0xC00000A6

;
; MessageId: STATUS_BAD_VALIDATION_CLASS
;
; MessageText:
;
;  The validation information class requested was invalid.
;
STATUS_BAD_VALIDATION_CLASS	 = 0xC00000A7

;
; MessageId: STATUS_BAD_TOKEN_TYPE
;
; MessageText:
;
;  The type of a token object is inappropriate for its attempted use.
;
STATUS_BAD_TOKEN_TYPE		 = 0xC00000A8

;
; MessageId: STATUS_BAD_MASTER_BOOT_RECORD
;
; MessageText:
;
;  The type of a token object is inappropriate for its attempted use.
;
STATUS_BAD_MASTER_BOOT_RECORD	 = 0xC00000A9

;
; MessageId: STATUS_INSTRUCTION_MISALIGNMENT
;
; MessageText:
;
;  An attempt was made to execute an instruction at an unaligned address and the host system does not support unaligned instruction references.
;
STATUS_INSTRUCTION_MISALIGNMENT  = 0xC00000AA

;
; MessageId: STATUS_INSTANCE_NOT_AVAILABLE
;
; MessageText:
;
;  The maximum named pipe instance count has been reached.
;
STATUS_INSTANCE_NOT_AVAILABLE	 = 0xC00000AB

;
; MessageId: STATUS_PIPE_NOT_AVAILABLE
;
; MessageText:
;
;  An instance of a named pipe cannot be found in the listening state.
;
STATUS_PIPE_NOT_AVAILABLE	 = 0xC00000AC

;
; MessageId: STATUS_INVALID_PIPE_STATE
;
; MessageText:
;
;  The named pipe is not in the connected or closing state.
;
STATUS_INVALID_PIPE_STATE	 = 0xC00000AD

;
; MessageId: STATUS_PIPE_BUSY
;
; MessageText:
;
;  The specified pipe is set to complete operations and there are current I/O operations queued so it cannot be changed to queue operations.
;
STATUS_PIPE_BUSY		 = 0xC00000AE

;
; MessageId: STATUS_ILLEGAL_FUNCTION
;
; MessageText:
;
;  The specified handle is not open to the server end of the named pipe.
;
STATUS_ILLEGAL_FUNCTION 	 = 0xC00000AF

;
; MessageId: STATUS_PIPE_DISCONNECTED
;
; MessageText:
;
;  The specified named pipe is in the disconnected state.
;
STATUS_PIPE_DISCONNECTED	 = 0xC00000B0

;
; MessageId: STATUS_PIPE_CLOSING
;
; MessageText:
;
;  The specified named pipe is in the closing state.
;
STATUS_PIPE_CLOSING		 = 0xC00000B1

;
; MessageId: STATUS_PIPE_CONNECTED
;
; MessageText:
;
;  The specified named pipe is in the connected state.
;
STATUS_PIPE_CONNECTED		 = 0xC00000B2

;
; MessageId: STATUS_PIPE_LISTENING
;
; MessageText:
;
;  The specified named pipe is in the listening state.
;
STATUS_PIPE_LISTENING		 = 0xC00000B3

;
; MessageId: STATUS_INVALID_READ_MODE
;
; MessageText:
;
;  The specified named pipe is not in message mode.
;
STATUS_INVALID_READ_MODE	 = 0xC00000B4

;
; MessageId: STATUS_IO_TIMEOUT
;
; MessageText:
;
;  {Device Timeout}
;  The specified I/O operation on %hs was not completed before the time-out period expired.
;
STATUS_IO_TIMEOUT		 = 0xC00000B5

;
; MessageId: STATUS_FILE_FORCED_CLOSED
;
; MessageText:
;
;  The specified file has been closed by another process.
;
STATUS_FILE_FORCED_CLOSED	 = 0xC00000B6

;
; MessageId: STATUS_PROFILING_NOT_STARTED
;
; MessageText:
;
;  Profiling not started.
;
STATUS_PROFILING_NOT_STARTED	 = 0xC00000B7

;
; MessageId: STATUS_PROFILING_NOT_STOPPED
;
; MessageText:
;
;  Profiling not stopped.
;
STATUS_PROFILING_NOT_STOPPED	 = 0xC00000B8

;
; MessageId: STATUS_COULD_NOT_INTERPRET
;
; MessageText:
;
;  The passed ACL did not contain the minimum required information.
;
STATUS_COULD_NOT_INTERPRET	 = 0xC00000B9

;
; MessageId: STATUS_FILE_IS_A_DIRECTORY
;
; MessageText:
;
;  The file that was specified as a target is a directory and the caller specified that it could be anything but a directory.
;
STATUS_FILE_IS_A_DIRECTORY	 = 0xC00000BA

;
; Network specific errors.
;
;
;
; MessageId: STATUS_NOT_SUPPORTED
;
; MessageText:
;
;  The request is not supported.
;
STATUS_NOT_SUPPORTED		 = 0xC00000BB

;
; MessageId: STATUS_REMOTE_NOT_LISTENING
;
; MessageText:
;
;  This remote computer is not listening.
;
STATUS_REMOTE_NOT_LISTENING	 = 0xC00000BC

;
; MessageId: STATUS_DUPLICATE_NAME
;
; MessageText:
;
;  A duplicate name exists on the network.
;
STATUS_DUPLICATE_NAME		 = 0xC00000BD

;
; MessageId: STATUS_BAD_NETWORK_PATH
;
; MessageText:
;
;  The network path cannot be located.
;
STATUS_BAD_NETWORK_PATH 	 = 0xC00000BE

;
; MessageId: STATUS_NETWORK_BUSY
;
; MessageText:
;
;  The network is busy.
;
STATUS_NETWORK_BUSY		 = 0xC00000BF

;
; MessageId: STATUS_DEVICE_DOES_NOT_EXIST
;
; MessageText:
;
;  This device does not exist.
;
STATUS_DEVICE_DOES_NOT_EXIST	 = 0xC00000C0

;
; MessageId: STATUS_TOO_MANY_COMMANDS
;
; MessageText:
;
;  The network BIOS command limit has been reached.
;
STATUS_TOO_MANY_COMMANDS	 = 0xC00000C1

;
; MessageId: STATUS_ADAPTER_HARDWARE_ERROR
;
; MessageText:
;
;  An I/O adapter hardware error has occurred.
;
STATUS_ADAPTER_HARDWARE_ERROR	 = 0xC00000C2

;
; MessageId: STATUS_INVALID_NETWORK_RESPONSE
;
; MessageText:
;
;  The network responded incorrectly.
;
STATUS_INVALID_NETWORK_RESPONSE  = 0xC00000C3

;
; MessageId: STATUS_UNEXPECTED_NETWORK_ERROR
;
; MessageText:
;
;  An unexpected network error occurred.
;
STATUS_UNEXPECTED_NETWORK_ERROR  = 0xC00000C4

;
; MessageId: STATUS_BAD_REMOTE_ADAPTER
;
; MessageText:
;
;  The remote adapter is not compatible.
;
STATUS_BAD_REMOTE_ADAPTER	 = 0xC00000C5

;
; MessageId: STATUS_PRINT_QUEUE_FULL
;
; MessageText:
;
;  The printer queue is full.
;
STATUS_PRINT_QUEUE_FULL 	 = 0xC00000C6

;
; MessageId: STATUS_NO_SPOOL_SPACE
;
; MessageText:
;
;  Space to store the file waiting to be printed is not available on the server.
;
STATUS_NO_SPOOL_SPACE		 = 0xC00000C7

;
; MessageId: STATUS_PRINT_CANCELLED
;
; MessageText:
;
;  The requested print file has been canceled.
;
STATUS_PRINT_CANCELLED		 = 0xC00000C8

;
; MessageId: STATUS_NETWORK_NAME_DELETED
;
; MessageText:
;
;  The network name was deleted.
;
STATUS_NETWORK_NAME_DELETED	 = 0xC00000C9

;
; MessageId: STATUS_NETWORK_ACCESS_DENIED
;
; MessageText:
;
;  Network access is denied.
;
STATUS_NETWORK_ACCESS_DENIED	 = 0xC00000CA

;
; MessageId: STATUS_BAD_DEVICE_TYPE
;
; MessageText:
;
;  {Incorrect Network Resource Type}
;  The specified device type (LPT, for example) conflicts with the actual device type on the remote resource.
;
STATUS_BAD_DEVICE_TYPE		 = 0xC00000CB

;
; MessageId: STATUS_BAD_NETWORK_NAME
;
; MessageText:
;
;  {Network Name Not Found}
;  The specified share name cannot be found on the remote server.
;
STATUS_BAD_NETWORK_NAME 	 = 0xC00000CC

;
; MessageId: STATUS_TOO_MANY_NAMES
;
; MessageText:
;
;  The name limit for the local computer network adapter card was exceeded.
;
STATUS_TOO_MANY_NAMES		 = 0xC00000CD

;
; MessageId: STATUS_TOO_MANY_SESSIONS
;
; MessageText:
;
;  The network BIOS session limit was exceeded.
;
STATUS_TOO_MANY_SESSIONS	 = 0xC00000CE

;
; MessageId: STATUS_SHARING_PAUSED
;
; MessageText:
;
;  File sharing has been temporarily paused.
;
STATUS_SHARING_PAUSED		 = 0xC00000CF

;
; MessageId: STATUS_REQUEST_NOT_ACCEPTED
;
; MessageText:
;
;  No more connections can be made to this remote computer at this time because there are already as many connections as the computer can accept.
;
STATUS_REQUEST_NOT_ACCEPTED	 = 0xC00000D0

;
; MessageId: STATUS_REDIRECTOR_PAUSED
;
; MessageText:
;
;  Print or disk redirection is temporarily paused.
;
STATUS_REDIRECTOR_PAUSED	 = 0xC00000D1

;
; MessageId: STATUS_NET_WRITE_FAULT
;
; MessageText:
;
;  A network data fault occurred.
;
STATUS_NET_WRITE_FAULT		 = 0xC00000D2

;
; MessageId: STATUS_PROFILING_AT_LIMIT
;
; MessageText:
;
;  The number of active profiling objects is at the maximum and no more may be started.
;
STATUS_PROFILING_AT_LIMIT	 = 0xC00000D3

;
; MessageId: STATUS_NOT_SAME_DEVICE
;
; MessageText:
;
;  {Incorrect Volume}
;  The target file of a rename request is located on a different device than the source of the rename request.
;
STATUS_NOT_SAME_DEVICE		 = 0xC00000D4

;
; MessageId: STATUS_FILE_RENAMED
;
; MessageText:
;
;  The file specified has been renamed and thus cannot be modified.
;
STATUS_FILE_RENAMED		 = 0xC00000D5

;
; MessageId: STATUS_VIRTUAL_CIRCUIT_CLOSED
;
; MessageText:
;
;  {Network Request Timeout}
;  The session with a remote server has been disconnected because the time-out interval for a request has expired.
;
STATUS_VIRTUAL_CIRCUIT_CLOSED	 = 0xC00000D6

;
; MessageId: STATUS_NO_SECURITY_ON_OBJECT
;
; MessageText:
;
;  Indicates an attempt was made to operate on the security of an object that does not have security associated with it.
;
STATUS_NO_SECURITY_ON_OBJECT	 = 0xC00000D7

;
; MessageId: STATUS_CANT_WAIT
;
; MessageText:
;
;  Used to indicate that an operation cannot continue without blocking for I/O.
;
STATUS_CANT_WAIT		 = 0xC00000D8

;
; MessageId: STATUS_PIPE_EMPTY
;
; MessageText:
;
;  Used to indicate that a read operation was done on an empty pipe.
;
STATUS_PIPE_EMPTY		 = 0xC00000D9

;
; MessageId: STATUS_CANT_ACCESS_DOMAIN_INFO
;
; MessageText:
;
;  Configuration information could not be read from the domain controller, either because the machine is unavailable, or access has been denied.
;
STATUS_CANT_ACCESS_DOMAIN_INFO	 = 0xC00000DA

;
; MessageId: STATUS_CANT_TERMINATE_SELF
;
; MessageText:
;
;  Indicates that a thread attempted to terminate itself by default (called NtTerminateThread with NUL and it was the last thread in the current process.
;
STATUS_CANT_TERMINATE_SELF	 = 0xC00000DB

;
; MessageId: STATUS_INVALID_SERVER_STATE
;
; MessageText:
;
;  Indicates the Sam Server was in the wrong state to perform the desired operation.
;
STATUS_INVALID_SERVER_STATE	 = 0xC00000DC

;
; MessageId: STATUS_INVALID_DOMAIN_STATE
;
; MessageText:
;
;  Indicates the Domain was in the wrong state to perform the desired operation.
;
STATUS_INVALID_DOMAIN_STATE	 = 0xC00000DD

;
; MessageId: STATUS_INVALID_DOMAIN_ROLE
;
; MessageText:
;
;  This operation is only allowed for the Primary Domain Controller of the domain.
;
STATUS_INVALID_DOMAIN_ROLE	 = 0xC00000DE

;
; MessageId: STATUS_NO_SUCH_DOMAIN
;
; MessageText:
;
;  The specified Domain did not exist.
;
STATUS_NO_SUCH_DOMAIN		 = 0xC00000DF

;
; MessageId: STATUS_DOMAIN_EXISTS
;
; MessageText:
;
;  The specified Domain already exists.
;
STATUS_DOMAIN_EXISTS		 = 0xC00000E0

;
; MessageId: STATUS_DOMAIN_LIMIT_EXCEEDED
;
; MessageText:
;
;  An attempt was made to exceed the limit on the number of domains per server for this release.
;
STATUS_DOMAIN_LIMIT_EXCEEDED	 = 0xC00000E1

;
; MessageId: STATUS_OPLOCK_NOT_GRANTED
;
; MessageText:
;
;  Error status returned when oplock request is denied.
;
STATUS_OPLOCK_NOT_GRANTED	 = 0xC00000E2

;
; MessageId: STATUS_INVALID_OPLOCK_PROTOCOL
;
; MessageText:
;
;  Error status returned when an invalid oplock acknowledgment is received by a file system.
;
STATUS_INVALID_OPLOCK_PROTOCOL	 = 0xC00000E3

;
; MessageId: STATUS_INTERNAL_DB_CORRUPTION
;
; MessageText:
;
;  This error indicates that the requested operation cannot be completed due to a catastrophic media failure or on-disk data structure corruption.
;
STATUS_INTERNAL_DB_CORRUPTION	 = 0xC00000E4

;
; MessageId: STATUS_INTERNAL_ERROR
;
; MessageText:
;
;  An internal error occurred.
;
STATUS_INTERNAL_ERROR		 = 0xC00000E5

;
; MessageId: STATUS_GENERIC_NOT_MAPPED
;
; MessageText:
;
;  Indicates generic access types were contained in an access mask which should already be mapped to non-generic access types.
;
STATUS_GENERIC_NOT_MAPPED	 = 0xC00000E6

;
; MessageId: STATUS_BAD_DESCRIPTOR_FORMAT
;
; MessageText:
;
;  Indicates a security descriptor is not in the necessary format (absolute or self-relative).
;
STATUS_BAD_DESCRIPTOR_FORMAT	 = 0xC00000E7

;
; Status codes raised by the Cache Manager which must be considered as
; "expected" by its callers.
;
;
; MessageId: STATUS_INVALID_USER_BUFFER
;
; MessageText:
;
;  An access to a user buffer failed at an "expected" point in time.
;  This code is defined since the caller does not want to accept STATUS_ACCESS_VIOLATION in its filter.
;
STATUS_INVALID_USER_BUFFER	 = 0xC00000E8

;
; MessageId: STATUS_UNEXPECTED_IO_ERROR
;
; MessageText:
;
;  If an I/O error is returned which is not defined in the standard FsRtl filter, it is converted to the following error which is guaranteed to be in the filter.
;  In this case information is lost, however, the filter correctly handles the exception.
;
STATUS_UNEXPECTED_IO_ERROR	 = 0xC00000E9

;
; MessageId: STATUS_UNEXPECTED_MM_CREATE_ERR
;
; MessageText:
;
;  If an MM error is returned which is not defined in the standard FsRtl filter, it is converted to one of the following errors which is guaranteed to be in the filter.
;  In this case information is lost, however, the filter correctly handles the exception.
;
STATUS_UNEXPECTED_MM_CREATE_ERR  = 0xC00000EA

;
; MessageId: STATUS_UNEXPECTED_MM_MAP_ERROR
;
; MessageText:
;
;  If an MM error is returned which is not defined in the standard FsRtl filter, it is converted to one of the following errors which is guaranteed to be in the filter.
;  In this case information is lost, however, the filter correctly handles the exception.
;
STATUS_UNEXPECTED_MM_MAP_ERROR	 = 0xC00000EB

;
; MessageId: STATUS_UNEXPECTED_MM_EXTEND_ERR
;
; MessageText:
;
;  If an MM error is returned which is not defined in the standard FsRtl filter, it is converted to one of the following errors which is guaranteed to be in the filter.
;  In this case information is lost, however, the filter correctly handles the exception.
;
STATUS_UNEXPECTED_MM_EXTEND_ERR  = 0xC00000EC

;
; MessageId: STATUS_NOT_LOGON_PROCESS
;
; MessageText:
;
;  The requested action is restricted for use by logon processes only. The calling process has not registered as a logon process.
;
STATUS_NOT_LOGON_PROCESS	 = 0xC00000ED

;
; MessageId: STATUS_LOGON_SESSION_EXISTS
;
; MessageText:
;
;  An attempt has been made to start a new session manager or LSA logon session with an ID that is already in use.
;
STATUS_LOGON_SESSION_EXISTS	 = 0xC00000EE

;
; MessageId: STATUS_INVALID_PARAMETER_1
;
; MessageText:
;
;  An invalid parameter was passed to a service or function as the first argument.
;
STATUS_INVALID_PARAMETER_1	 = 0xC00000EF

;
; MessageId: STATUS_INVALID_PARAMETER_2
;
; MessageText:
;
;  An invalid parameter was passed to a service or function as the second argument.
;
STATUS_INVALID_PARAMETER_2	 = 0xC00000F0

;
; MessageId: STATUS_INVALID_PARAMETER_3
;
; MessageText:
;
;  An invalid parameter was passed to a service or function as the third argument.
;
STATUS_INVALID_PARAMETER_3	 = 0xC00000F1

;
; MessageId: STATUS_INVALID_PARAMETER_4
;
; MessageText:
;
;  An invalid parameter was passed to a service or function as the fourth argument.
;
STATUS_INVALID_PARAMETER_4	 = 0xC00000F2

;
; MessageId: STATUS_INVALID_PARAMETER_5
;
; MessageText:
;
;  An invalid parameter was passed to a service or function as the fifth argument.
;
STATUS_INVALID_PARAMETER_5	 = 0xC00000F3

;
; MessageId: STATUS_INVALID_PARAMETER_6
;
; MessageText:
;
;  An invalid parameter was passed to a service or function as the sixth argument.
;
STATUS_INVALID_PARAMETER_6	 = 0xC00000F4

;
; MessageId: STATUS_INVALID_PARAMETER_7
;
; MessageText:
;
;  An invalid parameter was passed to a service or function as the seventh argument.
;
STATUS_INVALID_PARAMETER_7	 = 0xC00000F5

;
; MessageId: STATUS_INVALID_PARAMETER_8
;
; MessageText:
;
;  An invalid parameter was passed to a service or function as the eighth argument.
;
STATUS_INVALID_PARAMETER_8	 = 0xC00000F6

;
; MessageId: STATUS_INVALID_PARAMETER_9
;
; MessageText:
;
;  An invalid parameter was passed to a service or function as the ninth argument.
;
STATUS_INVALID_PARAMETER_9	 = 0xC00000F7

;
; MessageId: STATUS_INVALID_PARAMETER_10
;
; MessageText:
;
;  An invalid parameter was passed to a service or function as the tenth argument.
;
STATUS_INVALID_PARAMETER_10	 = 0xC00000F8

;
; MessageId: STATUS_INVALID_PARAMETER_11
;
; MessageText:
;
;  An invalid parameter was passed to a service or function as the eleventh argument.
;
STATUS_INVALID_PARAMETER_11	 = 0xC00000F9

;
; MessageId: STATUS_INVALID_PARAMETER_12
;
; MessageText:
;
;  An invalid parameter was passed to a service or function as the twelfth argument.
;
STATUS_INVALID_PARAMETER_12	 = 0xC00000FA

;
; MessageId: STATUS_REDIRECTOR_NOT_STARTED
;
; MessageText:
;
;  An attempt was made to access a network file, but the network software was not yet started.
;
STATUS_REDIRECTOR_NOT_STARTED	 = 0xC00000FB

;
; MessageId: STATUS_REDIRECTOR_STARTED
;
; MessageText:
;
;  An attempt was made to start the redirector, but the redirector has already been started.
;
STATUS_REDIRECTOR_STARTED	 = 0xC00000FC

;
; MessageId: STATUS_STACK_OVERFLOW
;
; MessageText:
;
;  A new guard page for the stack cannot be created.
;
STATUS_STACK_OVERFLOW		 = 0xC00000FD	 ; winnt

;
; MessageId: STATUS_NO_SUCH_PACKAGE
;
; MessageText:
;
;  A specified authentication package is unknown.
;
STATUS_NO_SUCH_PACKAGE		 = 0xC00000FE

;
; MessageId: STATUS_BAD_FUNCTION_TABLE
;
; MessageText:
;
;  A malformed function table was encountered during an unwind operation.
;
STATUS_BAD_FUNCTION_TABLE	 = 0xC00000FF

;
; MessageId: STATUS_VARIABLE_NOT_FOUND
;
; MessageText:
;
;  Indicates the specified environment variable name was not found in the specified environment block.
;
STATUS_VARIABLE_NOT_FOUND	 = 0xC0000100

;
; MessageId: STATUS_DIRECTORY_NOT_EMPTY
;
; MessageText:
;
;  Indicates that the directory trying to be deleted is not empty.
;
STATUS_DIRECTORY_NOT_EMPTY	 = 0xC0000101

;
; MessageId: STATUS_FILE_CORRUPT_ERROR
;
; MessageText:
;
;  {Corrupt File}
;  The file or directory %hs is corrupt and unreadable.
;  Please run the Chkdsk utility.
;
STATUS_FILE_CORRUPT_ERROR	 = 0xC0000102

;
; MessageId: STATUS_NOT_A_DIRECTORY
;
; MessageText:
;
;  A requested opened file is not a directory.
;
STATUS_NOT_A_DIRECTORY		 = 0xC0000103

;
; MessageId: STATUS_BAD_LOGON_SESSION_STATE
;
; MessageText:
;
;  The logon session is not in a state that is consistent with the requested operation.
;
STATUS_BAD_LOGON_SESSION_STATE	 = 0xC0000104

;
; MessageId: STATUS_LOGON_SESSION_COLLISION
;
; MessageText:
;
;  An internal LSA error has occurred. An authentication package has requested the creation of a Logon Session but the ID of an already existing Logon Session has been specified.
;
STATUS_LOGON_SESSION_COLLISION	 = 0xC0000105

;
; MessageId: STATUS_NAME_TOO_LONG
;
; MessageText:
;
;  A specified name string is too long for its intended use.
;
STATUS_NAME_TOO_LONG		 = 0xC0000106

;
; MessageId: STATUS_FILES_OPEN
;
; MessageText:
;
;  The user attempted to force close the files on a redirected drive, but there were opened files on the drive, and the user did not specify a sufficient level of force.
;
STATUS_FILES_OPEN		 = 0xC0000107

;
; MessageId: STATUS_CONNECTION_IN_USE
;
; MessageText:
;
;  The user attempted to force close the files on a redirected drive, but there were opened directories on the drive, and the user did not specify a sufficient level of force.
;
STATUS_CONNECTION_IN_USE	 = 0xC0000108

;
; MessageId: STATUS_MESSAGE_NOT_FOUND
;
; MessageText:
;
;  RtlFindMessage could not locate the requested message ID in the message table resource.
;
STATUS_MESSAGE_NOT_FOUND	 = 0xC0000109

;
; MessageId: STATUS_PROCESS_IS_TERMINATING
;
; MessageText:
;
;  An attempt was made to duplicate an object handle into or out of an exiting process.
;
STATUS_PROCESS_IS_TERMINATING	 = 0xC000010A

;
; MessageId: STATUS_INVALID_LOGON_TYPE
;
; MessageText:
;
;  Indicates an invalid value has been provided for the LogonType requested.
;
STATUS_INVALID_LOGON_TYPE	 = 0xC000010B

;
; MessageId: STATUS_NO_GUID_TRANSLATION
;
; MessageText:
;
;  Indicates that an attempt was made to assign protection to a file system file or directory and one of the SIDs in the security descriptor could not be translated into a GUID that could be stored by the file system.
;  This causes the protection attempt to fail, which may cause a file creation attempt to fail.
;
STATUS_NO_GUID_TRANSLATION	 = 0xC000010C

;
; MessageId: STATUS_CANNOT_IMPERSONATE
;
; MessageText:
;
;  Indicates that an attempt has been made to impersonate via a named pipe that has not yet been read from.
;
STATUS_CANNOT_IMPERSONATE	 = 0xC000010D

;
; MessageId: STATUS_IMAGE_ALREADY_LOADED
;
; MessageText:
;
;  Indicates that the specified image is already loaded.
;
STATUS_IMAGE_ALREADY_LOADED	 = 0xC000010E


;
; ============================================================
; NOTE: The following ABIOS error code should be reserved on
;       non ABIOS kernel. Eventually, I will remove the ifdef
;       ABIOS.
; ============================================================
;
;
; MessageId: STATUS_ABIOS_NOT_PRESENT
;
; MessageText:
;
;  STATUS_ABIOS_NOT_PRESENT
;
STATUS_ABIOS_NOT_PRESENT	 = 0xC000010F

;
; MessageId: STATUS_ABIOS_LID_NOT_EXIST
;
; MessageText:
;
;  STATUS_ABIOS_LID_NOT_EXIST
;
STATUS_ABIOS_LID_NOT_EXIST	 = 0xC0000110

;
; MessageId: STATUS_ABIOS_LID_ALREADY_OWNED
;
; MessageText:
;
;  STATUS_ABIOS_LID_ALREADY_OWNED
;
STATUS_ABIOS_LID_ALREADY_OWNED	 = 0xC0000111

;
; MessageId: STATUS_ABIOS_NOT_LID_OWNER
;
; MessageText:
;
;  STATUS_ABIOS_NOT_LID_OWNER
;
STATUS_ABIOS_NOT_LID_OWNER	 = 0xC0000112

;
; MessageId: STATUS_ABIOS_INVALID_COMMAND
;
; MessageText:
;
;  STATUS_ABIOS_INVALID_COMMAND
;
STATUS_ABIOS_INVALID_COMMAND	 = 0xC0000113

;
; MessageId: STATUS_ABIOS_INVALID_LID
;
; MessageText:
;
;  STATUS_ABIOS_INVALID_LID
;
STATUS_ABIOS_INVALID_LID	 = 0xC0000114

;
; MessageId: STATUS_ABIOS_SELECTOR_NOT_AVAILABLE
;
; MessageText:
;
;  STATUS_ABIOS_SELECTOR_NOT_AVAILABLE
;
STATUS_ABIOS_SELECTOR_NOT_AVAILABLE = 0xC0000115

;
; MessageId: STATUS_ABIOS_INVALID_SELECTOR
;
; MessageText:
;
;  STATUS_ABIOS_INVALID_SELECTOR
;
STATUS_ABIOS_INVALID_SELECTOR	 = 0xC0000116

;
; MessageId: STATUS_NO_LDT
;
; MessageText:
;
;  Indicates that an attempt was made to change the size of the LDT for a process that has no LDT.
;
STATUS_NO_LDT			 = 0xC0000117

;
; MessageId: STATUS_INVALID_LDT_SIZE
;
; MessageText:
;
;  Indicates that an attempt was made to grow an LDT by setting its size, or that the size was not an even number of selectors.
;
STATUS_INVALID_LDT_SIZE 	 = 0xC0000118

;
; MessageId: STATUS_INVALID_LDT_OFFSET
;
; MessageText:
;
;  Indicates that the starting value for the LDT information was not an integral multiple of the selector size.
;
STATUS_INVALID_LDT_OFFSET	 = 0xC0000119

;
; MessageId: STATUS_INVALID_LDT_DESCRIPTOR
;
; MessageText:
;
;  Indicates that the user supplied an invalid descriptor when trying to set up Ldt descriptors.
;
STATUS_INVALID_LDT_DESCRIPTOR	 = 0xC000011A

;
; MessageId: STATUS_INVALID_IMAGE_NE_FORMAT
;
; MessageText:
;
;  The specified image file did not have the correct format. It appears to be NE format.
;
STATUS_INVALID_IMAGE_NE_FORMAT	 = 0xC000011B

;
; MessageId: STATUS_RXACT_INVALID_STATE
;
; MessageText:
;
;  Indicates that the transaction state of a registry sub-tree is incompatible with the requested operation.
;  For example, a request has been made to start a new transaction with one already in progress,
;  or a request has been made to apply a transaction when one is not currently in progress.
;
STATUS_RXACT_INVALID_STATE	 = 0xC000011C

;
; MessageId: STATUS_RXACT_COMMIT_FAILURE
;
; MessageText:
;
;  Indicates an error has occurred during a registry transaction commit.
;  The database has been left in an unknown, but probably inconsistent, state.
;  The state of the registry transaction is left as COMMITTING.
;
STATUS_RXACT_COMMIT_FAILURE	 = 0xC000011D

;
; MessageId: STATUS_MAPPED_FILE_SIZE_ZERO
;
; MessageText:
;
;  An attempt was made to map a file of size zero with the maximum size specified as zero.
;
STATUS_MAPPED_FILE_SIZE_ZERO	 = 0xC000011E

;
; MessageId: STATUS_TOO_MANY_OPENED_FILES
;
; MessageText:
;
;  Too many files are opened on a remote server.
;  This error should only be returned by the Windows redirector on a remote drive.
;
STATUS_TOO_MANY_OPENED_FILES	 = 0xC000011F

;
; MessageId: STATUS_CANCELLED
;
; MessageText:
;
;  The I/O request was canceled.
;
STATUS_CANCELLED		 = 0xC0000120

;
; MessageId: STATUS_CANNOT_DELETE
;
; MessageText:
;
;  An attempt has been made to remove a file or directory that cannot be deleted.
;
STATUS_CANNOT_DELETE		 = 0xC0000121

;
; MessageId: STATUS_INVALID_COMPUTER_NAME
;
; MessageText:
;
;  Indicates a name specified as a remote computer name is syntactically invalid.
;
STATUS_INVALID_COMPUTER_NAME	 = 0xC0000122

;
; MessageId: STATUS_FILE_DELETED
;
; MessageText:
;
;  An I/O request other than close was performed on a file after it has been deleted,
;  which can only happen to a request which did not complete before the last handle was closed via NtClose.
;
STATUS_FILE_DELETED		 = 0xC0000123

;
; MessageId: STATUS_SPECIAL_ACCOUNT
;
; MessageText:
;
;  Indicates an operation has been attempted on a built-in (specia SAM account which is incompatible with built-in accounts.
;  For example, built-in accounts cannot be deleted.
;
STATUS_SPECIAL_ACCOUNT		 = 0xC0000124

;
; MessageId: STATUS_SPECIAL_GROUP
;
; MessageText:
;
;  The operation requested may not be performed on the specified group because it is a built-in special group.
;
STATUS_SPECIAL_GROUP		 = 0xC0000125

;
; MessageId: STATUS_SPECIAL_USER
;
; MessageText:
;
;  The operation requested may not be performed on the specified user because it is a built-in special user.
;
STATUS_SPECIAL_USER		 = 0xC0000126

;
; MessageId: STATUS_MEMBERS_PRIMARY_GROUP
;
; MessageText:
;
;  Indicates a member cannot be removed from a group because the group is currently the member's primary group.
;
STATUS_MEMBERS_PRIMARY_GROUP	 = 0xC0000127

;
; MessageId: STATUS_FILE_CLOSED
;
; MessageText:
;
;  An I/O request other than close and several other special case operations was attempted using a file object that had already been closed.
;
STATUS_FILE_CLOSED		 = 0xC0000128

;
; MessageId: STATUS_TOO_MANY_THREADS
;
; MessageText:
;
;  Indicates a process has too many threads to perform the requested action. For example, assignment of a primary token may only be performed when a process has zero or one threads.
;
STATUS_TOO_MANY_THREADS 	 = 0xC0000129

;
; MessageId: STATUS_THREAD_NOT_IN_PROCESS
;
; MessageText:
;
;  An attempt was made to operate on a thread within a specific process, but the thread specified is not in the process specified.
;
STATUS_THREAD_NOT_IN_PROCESS	 = 0xC000012A

;
; MessageId: STATUS_TOKEN_ALREADY_IN_USE
;
; MessageText:
;
;  An attempt was made to establish a token for use as a primary token but the token is already in use. A token can only be the primary token of one process at a time.
;
STATUS_TOKEN_ALREADY_IN_USE	 = 0xC000012B

;
; MessageId: STATUS_PAGEFILE_QUOTA_EXCEEDED
;
; MessageText:
;
;  Page file quota was exceeded.
;
STATUS_PAGEFILE_QUOTA_EXCEEDED	 = 0xC000012C

;
; MessageId: STATUS_COMMITMENT_LIMIT
;
; MessageText:
;
;  {Out of Virtual Memory}
;  Your system is low on virtual memory. To ensure that Windows runs properly, increase the size of your virtual memory paging file. For more information, see Help.
;
STATUS_COMMITMENT_LIMIT 	 = 0xC000012D

;
; MessageId: STATUS_INVALID_IMAGE_LE_FORMAT
;
; MessageText:
;
;  The specified image file did not have the correct format, it appears to be LE format.
;
STATUS_INVALID_IMAGE_LE_FORMAT	 = 0xC000012E

;
; MessageId: STATUS_INVALID_IMAGE_NOT_MZ
;
; MessageText:
;
;  The specified image file did not have the correct format, it did not have an initial MZ.
;
STATUS_INVALID_IMAGE_NOT_MZ	 = 0xC000012F

;
; MessageId: STATUS_INVALID_IMAGE_PROTECT
;
; MessageText:
;
;  The specified image file did not have the correct format, it did not have a proper e_lfarlc in the MZ header.
;
STATUS_INVALID_IMAGE_PROTECT	 = 0xC0000130

;
; MessageId: STATUS_INVALID_IMAGE_WIN_16
;
; MessageText:
;
;  The specified image file did not have the correct format, it appears to be a 16-bit Windows image.
;
STATUS_INVALID_IMAGE_WIN_16	 = 0xC0000131

;
; MessageId: STATUS_LOGON_SERVER_CONFLICT
;
; MessageText:
;
;  The Netlogon service cannot start because another Netlogon service running in the domain conflicts with the specified role.
;
STATUS_LOGON_SERVER_CONFLICT	 = 0xC0000132

;
; MessageId: STATUS_TIME_DIFFERENCE_AT_DC
;
; MessageText:
;
;  The time at the Primary Domain Controller is different than the time at the Backup Domain Controller or member server by too large an amount.
;
STATUS_TIME_DIFFERENCE_AT_DC	 = 0xC0000133

;
; MessageId: STATUS_SYNCHRONIZATION_REQUIRED
;
; MessageText:
;
;  The SAM database on a Windows Server is significantly out of synchronization with the copy on the Domain Controller. A complete synchronization is required.
;
STATUS_SYNCHRONIZATION_REQUIRED  = 0xC0000134

;
; MessageId: STATUS_DLL_NOT_FOUND
;
; MessageText:
;
;  {Unable To Locate Component}
;  This application has failed to start because %hs was not found. Re-installing the application may fix this problem.
;
STATUS_DLL_NOT_FOUND		 = 0xC0000135

;
; MessageId: STATUS_OPEN_FAILED
;
; MessageText:
;
;  The NtCreateFile API failed. This error should never be returned to an application, it is a place holder for the Windows Lan Manager Redirector to use in its internal error mapping routines.
;
STATUS_OPEN_FAILED		 = 0xC0000136

;
; MessageId: STATUS_IO_PRIVILEGE_FAILED
;
; MessageText:
;
;  {Privilege Failed}
;  The I/O permissions for the process could not be changed.
;
STATUS_IO_PRIVILEGE_FAILED	 = 0xC0000137

;
; MessageId: STATUS_ORDINAL_NOT_FOUND
;
; MessageText:
;
;  {Ordinal Not Found}
;  The ordinal %ld could not be located in the dynamic link library %hs.
;
STATUS_ORDINAL_NOT_FOUND	 = 0xC0000138

;
; MessageId: STATUS_ENTRYPOINT_NOT_FOUND
;
; MessageText:
;
;  {Entry Point Not Found}
;  The procedure entry point %hs could not be located in the dynamic link library %hs.
;
STATUS_ENTRYPOINT_NOT_FOUND	 = 0xC0000139

;
; MessageId: STATUS_CONTROL_C_EXIT
;
; MessageText:
;
;  {Application Exit by CTRL+C}
;  The application terminated as a result of a CTRL+C.
;
STATUS_CONTROL_C_EXIT		 = 0xC000013A	 ; winnt

;
; MessageId: STATUS_LOCAL_DISCONNECT
;
; MessageText:
;
;  {Virtual Circuit Closed}
;  The network transport on your computer has closed a network connection. There may or may not be I/O requests outstanding.
;
STATUS_LOCAL_DISCONNECT 	 = 0xC000013B

;
; MessageId: STATUS_REMOTE_DISCONNECT
;
; MessageText:
;
;  {Virtual Circuit Closed}
;  The network transport on a remote computer has closed a network connection. There may or may not be I/O requests outstanding.
;
STATUS_REMOTE_DISCONNECT	 = 0xC000013C

;
; MessageId: STATUS_REMOTE_RESOURCES
;
; MessageText:
;
;  {Insufficient Resources on Remote Computer}
;  The remote computer has insufficient resources to complete the network request. For instance, there may not be enough memory available on the remote computer to carry out the request at this time.
;
STATUS_REMOTE_RESOURCES 	 = 0xC000013D

;
; MessageId: STATUS_LINK_FAILED
;
; MessageText:
;
;  {Virtual Circuit Closed}
;  An existing connection (virtual circuit) has been broken at the remote computer. There is probably something wrong with the network software protocol or the network hardware on the remote computer.
;
STATUS_LINK_FAILED		 = 0xC000013E

;
; MessageId: STATUS_LINK_TIMEOUT
;
; MessageText:
;
;  {Virtual Circuit Closed}
;  The network transport on your computer has closed a network connection because it had to wait too long for a response from the remote computer.
;
STATUS_LINK_TIMEOUT		 = 0xC000013F

;
; MessageId: STATUS_INVALID_CONNECTION
;
; MessageText:
;
;  The connection handle given to the transport was invalid.
;
STATUS_INVALID_CONNECTION	 = 0xC0000140

;
; MessageId: STATUS_INVALID_ADDRESS
;
; MessageText:
;
;  The address handle given to the transport was invalid.
;
STATUS_INVALID_ADDRESS		 = 0xC0000141

;
; MessageId: STATUS_DLL_INIT_FAILED
;
; MessageText:
;
;  {DLL Initialization Failed}
;  Initialization of the dynamic link library %hs failed. The process is terminating abnormally.
;
STATUS_DLL_INIT_FAILED		 = 0xC0000142

;
; MessageId: STATUS_MISSING_SYSTEMFILE
;
; MessageText:
;
;  {Missing System File}
;  The required system file %hs is bad or missing.
;
STATUS_MISSING_SYSTEMFILE	 = 0xC0000143

;
; MessageId: STATUS_UNHANDLED_EXCEPTION
;
; MessageText:
;
;  {Application Error}
;  The exception %s (= 0x%08lx) occurred in the application at location = 0x%08lx.
;
STATUS_UNHANDLED_EXCEPTION	 = 0xC0000144

;
; MessageId: STATUS_APP_INIT_FAILURE
;
; MessageText:
;
;  {Application Error}
;  The application failed to initialize properly (= 0x%lx). Click on OK to terminate the application.
;
STATUS_APP_INIT_FAILURE 	 = 0xC0000145

;
; MessageId: STATUS_PAGEFILE_CREATE_FAILED
;
; MessageText:
;
;  {Unable to Create Paging File}
;  The creation of the paging file %hs failed (%lx). The requested size was %ld.
;
STATUS_PAGEFILE_CREATE_FAILED	 = 0xC0000146

;
; MessageId: STATUS_NO_PAGEFILE
;
; MessageText:
;
;  {No Paging File Specified}
;  No paging file was specified in the system configuration.
;
STATUS_NO_PAGEFILE		 = 0xC0000147

;
; MessageId: STATUS_INVALID_LEVEL
;
; MessageText:
;
;  {Incorrect System Call Level}
;  An invalid level was passed into the specified system call.
;
STATUS_INVALID_LEVEL		 = 0xC0000148

;
; MessageId: STATUS_WRONG_PASSWORD_CORE
;
; MessageText:
;
;  {Incorrect Password to LAN Manager Server}
;  You specified an incorrect password to a LAN Manager 2.x or MS-NET server.
;
STATUS_WRONG_PASSWORD_CORE	 = 0xC0000149

;
; MessageId: STATUS_ILLEGAL_FLOAT_CONTEXT
;
; MessageText:
;
;  {EXCEPTION}
;  A real-mode application issued a floating-point instruction and floating-point hardware is not present.
;
STATUS_ILLEGAL_FLOAT_CONTEXT	 = 0xC000014A

;
; MessageId: STATUS_PIPE_BROKEN
;
; MessageText:
;
;  The pipe operation has failed because the other end of the pipe has been closed.
;
STATUS_PIPE_BROKEN		 = 0xC000014B

;
; MessageId: STATUS_REGISTRY_CORRUPT
;
; MessageText:
;
;  {The Registry Is Corrupt}
;  The structure of one of the files that contains Registry data is corrupt, or the image of the file in memory is corrupt, or the file could not be recovered because the alternate copy or log was absent or corrupt.
;
STATUS_REGISTRY_CORRUPT 	 = 0xC000014C

;
; MessageId: STATUS_REGISTRY_IO_FAILED
;
; MessageText:
;
;  An I/O operation initiated by the Registry failed unrecoverably.
;  The Registry could not read in, or write out, or flush, one of the files that contain the system's image of the Registry.
;
STATUS_REGISTRY_IO_FAILED	 = 0xC000014D

;
; MessageId: STATUS_NO_EVENT_PAIR
;
; MessageText:
;
;  An event pair synchronization operation was performed using the thread specific client/server event pair object, but no event pair object was associated with the thread.
;
STATUS_NO_EVENT_PAIR		 = 0xC000014E

;
; MessageId: STATUS_UNRECOGNIZED_VOLUME
;
; MessageText:
;
;  The volume does not contain a recognized file system.
;  Please make sure that all required file system drivers are loaded and that the volume is not corrupt.
;
STATUS_UNRECOGNIZED_VOLUME	 = 0xC000014F

;
; MessageId: STATUS_SERIAL_NO_DEVICE_INITED
;
; MessageText:
;
;  No serial device was successfully initialized. The serial driver will unload.
;
STATUS_SERIAL_NO_DEVICE_INITED	 = 0xC0000150

;
; MessageId: STATUS_NO_SUCH_ALIAS
;
; MessageText:
;
;  The specified local group does not exist.
;
STATUS_NO_SUCH_ALIAS		 = 0xC0000151

;
; MessageId: STATUS_MEMBER_NOT_IN_ALIAS
;
; MessageText:
;
;  The specified account name is not a member of the local group.
;
STATUS_MEMBER_NOT_IN_ALIAS	 = 0xC0000152

;
; MessageId: STATUS_MEMBER_IN_ALIAS
;
; MessageText:
;
;  The specified account name is already a member of the local group.
;
STATUS_MEMBER_IN_ALIAS		 = 0xC0000153

;
; MessageId: STATUS_ALIAS_EXISTS
;
; MessageText:
;
;  The specified local group already exists.
;
STATUS_ALIAS_EXISTS		 = 0xC0000154

;
; MessageId: STATUS_LOGON_NOT_GRANTED
;
; MessageText:
;
;  A requested type of logon (e.g., Interactive, Network, Service) is not granted by the target system's local security policy.
;  Please ask the system administrator to grant the necessary form of logon.
;
STATUS_LOGON_NOT_GRANTED	 = 0xC0000155

;
; MessageId: STATUS_TOO_MANY_SECRETS
;
; MessageText:
;
;  The maximum number of secrets that may be stored in a single system has been exceeded. The length and number of secrets is limited to satisfy United States State Department export restrictions.
;
STATUS_TOO_MANY_SECRETS 	 = 0xC0000156

;
; MessageId: STATUS_SECRET_TOO_LONG
;
; MessageText:
;
;  The length of a secret exceeds the maximum length allowed. The length and number of secrets is limited to satisfy United States State Department export restrictions.
;
STATUS_SECRET_TOO_LONG		 = 0xC0000157

;
; MessageId: STATUS_INTERNAL_DB_ERROR
;
; MessageText:
;
;  The Local Security Authority (LSA) database contains an internal inconsistency.
;
STATUS_INTERNAL_DB_ERROR	 = 0xC0000158

;
; MessageId: STATUS_FULLSCREEN_MODE
;
; MessageText:
;
;  The requested operation cannot be performed in fullscreen mode.
;
STATUS_FULLSCREEN_MODE		 = 0xC0000159

;
; MessageId: STATUS_TOO_MANY_CONTEXT_IDS
;
; MessageText:
;
;  During a logon attempt, the user's security context accumulated too many security IDs. This is a very unusual situation.
;  Remove the user from some global or local groups to reduce the number of security ids to incorporate into the security context.
;
STATUS_TOO_MANY_CONTEXT_IDS	 = 0xC000015A

;
; MessageId: STATUS_LOGON_TYPE_NOT_GRANTED
;
; MessageText:
;
;  A user has requested a type of logon (e.g., interactive or network) that has not been granted. An administrator has control over who may logon interactively and through the network.
;
STATUS_LOGON_TYPE_NOT_GRANTED	 = 0xC000015B

;
; MessageId: STATUS_NOT_REGISTRY_FILE
;
; MessageText:
;
;  The system has attempted to load or restore a file into the registry, and the specified file is not in the format of a registry file.
;
STATUS_NOT_REGISTRY_FILE	 = 0xC000015C

;
; MessageId: STATUS_NT_CROSS_ENCRYPTION_REQUIRED
;
; MessageText:
;
;  An attempt was made to change a user password in the security account manager without providing the necessary Windows cross-encrypted password.
;
STATUS_NT_CROSS_ENCRYPTION_REQUIRED = 0xC000015D

;
; MessageId: STATUS_DOMAIN_CTRLR_CONFIG_ERROR
;
; MessageText:
;
;  A Windows Server has an incorrect configuration.
;
STATUS_DOMAIN_CTRLR_CONFIG_ERROR = 0xC000015E

;
; MessageId: STATUS_FT_MISSING_MEMBER
;
; MessageText:
;
;  An attempt was made to explicitly access the secondary copy of information via a device control to the Fault Tolerance driver and the secondary copy is not present in the system.
;
STATUS_FT_MISSING_MEMBER	 = 0xC000015F

;
; MessageId: STATUS_ILL_FORMED_SERVICE_ENTRY
;
; MessageText:
;
;  A configuration registry node representing a driver service entry was ill-formed and did not contain required value entries.
;
STATUS_ILL_FORMED_SERVICE_ENTRY  = 0xC0000160

;
; MessageId: STATUS_ILLEGAL_CHARACTER
;
; MessageText:
;
;  An illegal character was encountered. For a multi-byte character set this includes a lead byte without a succeeding trail byte. For the Unicode character set this includes the characters = 0xFFFF and = 0xFFFE.
;
STATUS_ILLEGAL_CHARACTER	 = 0xC0000161

;
; MessageId: STATUS_UNMAPPABLE_CHARACTER
;
; MessageText:
;
;  No mapping for the Unicode character exists in the target multi-byte code page.
;
STATUS_UNMAPPABLE_CHARACTER	 = 0xC0000162

;
; MessageId: STATUS_UNDEFINED_CHARACTER
;
; MessageText:
;
;  The Unicode character is not defined in the Unicode character set installed on the system.
;
STATUS_UNDEFINED_CHARACTER	 = 0xC0000163

;
; MessageId: STATUS_FLOPPY_VOLUME
;
; MessageText:
;
;  The paging file cannot be created on a floppy diskette.
;
STATUS_FLOPPY_VOLUME		 = 0xC0000164

;
; MessageId: STATUS_FLOPPY_ID_MARK_NOT_FOUND
;
; MessageText:
;
;  {Floppy Disk Error}
;  While accessing a floppy disk, an ID address mark was not found.
;
STATUS_FLOPPY_ID_MARK_NOT_FOUND  = 0xC0000165

;
; MessageId: STATUS_FLOPPY_WRONG_CYLINDER
;
; MessageText:
;
;  {Floppy Disk Error}
;  While accessing a floppy disk, the track address from the sector ID field was found to be different than the track address maintained by the controller.
;
STATUS_FLOPPY_WRONG_CYLINDER	 = 0xC0000166

;
; MessageId: STATUS_FLOPPY_UNKNOWN_ERROR
;
; MessageText:
;
;  {Floppy Disk Error}
;  The floppy disk controller reported an error that is not recognized by the floppy disk driver.
;
STATUS_FLOPPY_UNKNOWN_ERROR	 = 0xC0000167

;
; MessageId: STATUS_FLOPPY_BAD_REGISTERS
;
; MessageText:
;
;  {Floppy Disk Error}
;  While accessing a floppy-disk, the controller returned inconsistent results via its registers.
;
STATUS_FLOPPY_BAD_REGISTERS	 = 0xC0000168

;
; MessageId: STATUS_DISK_RECALIBRATE_FAILED
;
; MessageText:
;
;  {Hard Disk Error}
;  While accessing the hard disk, a recalibrate operation failed, even after retries.
;
STATUS_DISK_RECALIBRATE_FAILED	 = 0xC0000169

;
; MessageId: STATUS_DISK_OPERATION_FAILED
;
; MessageText:
;
;  {Hard Disk Error}
;  While accessing the hard disk, a disk operation failed even after retries.
;
STATUS_DISK_OPERATION_FAILED	 = 0xC000016A

;
; MessageId: STATUS_DISK_RESET_FAILED
;
; MessageText:
;
;  {Hard Disk Error}
;  While accessing the hard disk, a disk controller reset was needed, but even that failed.
;
STATUS_DISK_RESET_FAILED	 = 0xC000016B

;
; MessageId: STATUS_SHARED_IRQ_BUSY
;
; MessageText:
;
;  An attempt was made to open a device that was sharing an IRQ with other devices.
;  At least one other device that uses that IRQ was already opened.
;  Two concurrent opens of devices that share an IRQ and only work via interrupts is not supported for the particular bus type that the devices use.
;
STATUS_SHARED_IRQ_BUSY		 = 0xC000016C

;
; MessageId: STATUS_FT_ORPHANING
;
; MessageText:
;
;  {FT Orphaning}
;  A disk that is part of a fault-tolerant volume can no longer be accessed.
;
STATUS_FT_ORPHANING		 = 0xC000016D

;
; MessageId: STATUS_BIOS_FAILED_TO_CONNECT_INTERRUPT
;
; MessageText:
;
;  The system bios failed to connect a system interrupt to the device or bus for
;  which the device is connected.
;
STATUS_BIOS_FAILED_TO_CONNECT_INTERRUPT = 0xC000016E

;
; MessageId: STATUS_PARTITION_FAILURE
;
; MessageText:
;
;  Tape could not be partitioned.
;
STATUS_PARTITION_FAILURE	 = 0xC0000172

;
; MessageId: STATUS_INVALID_BLOCK_LENGTH
;
; MessageText:
;
;  When accessing a new tape of a multivolume partition, the current blocksize is incorrect.
;
STATUS_INVALID_BLOCK_LENGTH	 = 0xC0000173

;
; MessageId: STATUS_DEVICE_NOT_PARTITIONED
;
; MessageText:
;
;  Tape partition information could not be found when loading a tape.
;
STATUS_DEVICE_NOT_PARTITIONED	 = 0xC0000174

;
; MessageId: STATUS_UNABLE_TO_LOCK_MEDIA
;
; MessageText:
;
;  Attempt to lock the eject media mechanism fails.
;
STATUS_UNABLE_TO_LOCK_MEDIA	 = 0xC0000175

;
; MessageId: STATUS_UNABLE_TO_UNLOAD_MEDIA
;
; MessageText:
;
;  Unload media fails.
;
STATUS_UNABLE_TO_UNLOAD_MEDIA	 = 0xC0000176

;
; MessageId: STATUS_EOM_OVERFLOW
;
; MessageText:
;
;  Physical end of tape was detected.
;
STATUS_EOM_OVERFLOW		 = 0xC0000177

;
; MessageId: STATUS_NO_MEDIA
;
; MessageText:
;
;  {No Media}
;  There is no media in the drive.
;  Please insert media into drive %hs.
;
STATUS_NO_MEDIA 		 = 0xC0000178

;
; MessageId: STATUS_NO_SUCH_MEMBER
;
; MessageText:
;
;  A member could not be added to or removed from the local group because the member does not exist.
;
STATUS_NO_SUCH_MEMBER		 = 0xC000017A

;
; MessageId: STATUS_INVALID_MEMBER
;
; MessageText:
;
;  A new member could not be added to a local group because the member has the wrong account type.
;
STATUS_INVALID_MEMBER		 = 0xC000017B

;
; MessageId: STATUS_KEY_DELETED
;
; MessageText:
;
;  Illegal operation attempted on a registry key which has been marked for deletion.
;
STATUS_KEY_DELETED		 = 0xC000017C

;
; MessageId: STATUS_NO_LOG_SPACE
;
; MessageText:
;
;  System could not allocate required space in a registry log.
;
STATUS_NO_LOG_SPACE		 = 0xC000017D

;
; MessageId: STATUS_TOO_MANY_SIDS
;
; MessageText:
;
;  Too many Sids have been specified.
;
STATUS_TOO_MANY_SIDS		 = 0xC000017E

;
; MessageId: STATUS_LM_CROSS_ENCRYPTION_REQUIRED
;
; MessageText:
;
;  An attempt was made to change a user password in the security account manager without providing the necessary LM cross-encrypted password.
;
STATUS_LM_CROSS_ENCRYPTION_REQUIRED = 0xC000017F

;
; MessageId: STATUS_KEY_HAS_CHILDREN
;
; MessageText:
;
;  An attempt was made to create a symbolic link in a registry key that already has subkeys or values.
;
STATUS_KEY_HAS_CHILDREN 	 = 0xC0000180

;
; MessageId: STATUS_CHILD_MUST_BE_VOLATILE
;
; MessageText:
;
;  An attempt was made to create a Stable subkey under a Volatile parent key.
;
STATUS_CHILD_MUST_BE_VOLATILE	 = 0xC0000181

;
; MessageId: STATUS_DEVICE_CONFIGURATION_ERROR
;
; MessageText:
;
;  The I/O device is configured incorrectly or the configuration parameters to the driver are incorrect.
;
STATUS_DEVICE_CONFIGURATION_ERROR = 0xC0000182

;
; MessageId: STATUS_DRIVER_INTERNAL_ERROR
;
; MessageText:
;
;  An error was detected between two drivers or within an I/O driver.
;
STATUS_DRIVER_INTERNAL_ERROR	 = 0xC0000183

;
; MessageId: STATUS_INVALID_DEVICE_STATE
;
; MessageText:
;
;  The device is not in a valid state to perform this request.
;
STATUS_INVALID_DEVICE_STATE	 = 0xC0000184

;
; MessageId: STATUS_IO_DEVICE_ERROR
;
; MessageText:
;
;  The I/O device reported an I/O error.
;
STATUS_IO_DEVICE_ERROR		 = 0xC0000185

;
; MessageId: STATUS_DEVICE_PROTOCOL_ERROR
;
; MessageText:
;
;  A protocol error was detected between the driver and the device.
;
STATUS_DEVICE_PROTOCOL_ERROR	 = 0xC0000186

;
; MessageId: STATUS_BACKUP_CONTROLLER
;
; MessageText:
;
;  This operation is only allowed for the Primary Domain Controller of the domain.
;
STATUS_BACKUP_CONTROLLER	 = 0xC0000187

;
; MessageId: STATUS_LOG_FILE_FULL
;
; MessageText:
;
;  Log file space is insufficient to support this operation.
;
STATUS_LOG_FILE_FULL		 = 0xC0000188

;
; MessageId: STATUS_TOO_LATE
;
; MessageText:
;
;  A write operation was attempted to a volume after it was dismounted.
;
STATUS_TOO_LATE 		 = 0xC0000189

;
; MessageId: STATUS_NO_TRUST_LSA_SECRET
;
; MessageText:
;
;  The workstation does not have a trust secret for the primary domain in the local LSA database.
;
STATUS_NO_TRUST_LSA_SECRET	 = 0xC000018A

;
; MessageId: STATUS_NO_TRUST_SAM_ACCOUNT
;
; MessageText:
;
;  The SAM database on the Windows Server does not have a computer account for this workstation trust relationship.
;
STATUS_NO_TRUST_SAM_ACCOUNT	 = 0xC000018B

;
; MessageId: STATUS_TRUSTED_DOMAIN_FAILURE
;
; MessageText:
;
;  The logon request failed because the trust relationship between the primary domain and the trusted domain failed.
;
STATUS_TRUSTED_DOMAIN_FAILURE	 = 0xC000018C

;
; MessageId: STATUS_TRUSTED_RELATIONSHIP_FAILURE
;
; MessageText:
;
;  The logon request failed because the trust relationship between this workstation and the primary domain failed.
;
STATUS_TRUSTED_RELATIONSHIP_FAILURE = 0xC000018D

;
; MessageId: STATUS_EVENTLOG_FILE_CORRUPT
;
; MessageText:
;
;  The Eventlog log file is corrupt.
;
STATUS_EVENTLOG_FILE_CORRUPT	 = 0xC000018E

;
; MessageId: STATUS_EVENTLOG_CANT_START
;
; MessageText:
;
;  No Eventlog log file could be opened. The Eventlog service did not start.
;
STATUS_EVENTLOG_CANT_START	 = 0xC000018F

;
; MessageId: STATUS_TRUST_FAILURE
;
; MessageText:
;
;  The network logon failed. This may be because the validation authority can't be reached.
;
STATUS_TRUST_FAILURE		 = 0xC0000190

;
; MessageId: STATUS_MUTANT_LIMIT_EXCEEDED
;
; MessageText:
;
;  An attempt was made to acquire a mutant such that its maximum count would have been exceeded.
;
STATUS_MUTANT_LIMIT_EXCEEDED	 = 0xC0000191

;
; MessageId: STATUS_NETLOGON_NOT_STARTED
;
; MessageText:
;
;  An attempt was made to logon, but the netlogon service was not started.
;
STATUS_NETLOGON_NOT_STARTED	 = 0xC0000192

;
; MessageId: STATUS_ACCOUNT_EXPIRED
;
; MessageText:
;
;  The user's account has expired.
;
STATUS_ACCOUNT_EXPIRED		 = 0xC0000193	 ; ntsubauth

;
; MessageId: STATUS_POSSIBLE_DEADLOCK
;
; MessageText:
;
;  {EXCEPTION}
;  Possible deadlock condition.
;
STATUS_POSSIBLE_DEADLOCK	 = 0xC0000194

;
; MessageId: STATUS_NETWORK_CREDENTIAL_CONFLICT
;
; MessageText:
;
;  Multiple connections to a server or shared resource by the same user, using more than one user name, are not allowed. Disconnect all previous connections to the server or shared resource and try again..
;
STATUS_NETWORK_CREDENTIAL_CONFLICT = 0xC0000195

;
; MessageId: STATUS_REMOTE_SESSION_LIMIT
;
; MessageText:
;
;  An attempt was made to establish a session to a network server, but there are already too many sessions established to that server.
;
STATUS_REMOTE_SESSION_LIMIT	 = 0xC0000196

;
; MessageId: STATUS_EVENTLOG_FILE_CHANGED
;
; MessageText:
;
;  The log file has changed between reads.
;
STATUS_EVENTLOG_FILE_CHANGED	 = 0xC0000197

;
; MessageId: STATUS_NOLOGON_INTERDOMAIN_TRUST_ACCOUNT
;
; MessageText:
;
;  The account used is an Interdomain Trust account. Use your global user account or local user account to access this server.
;
STATUS_NOLOGON_INTERDOMAIN_TRUST_ACCOUNT = 0xC0000198

;
; MessageId: STATUS_NOLOGON_WORKSTATION_TRUST_ACCOUNT
;
; MessageText:
;
;  The account used is a Computer Account. Use your global user account or local user account to access this server.
;
STATUS_NOLOGON_WORKSTATION_TRUST_ACCOUNT = 0xC0000199

;
; MessageId: STATUS_NOLOGON_SERVER_TRUST_ACCOUNT
;
; MessageText:
;
;  The account used is an Server Trust account. Use your global user account or local user account to access this server.
;
STATUS_NOLOGON_SERVER_TRUST_ACCOUNT = 0xC000019A

;
; MessageId: STATUS_DOMAIN_TRUST_INCONSISTENT
;
; MessageText:
;
;  The name or SID of the domain specified is inconsistent with the trust information for that domain.
;
STATUS_DOMAIN_TRUST_INCONSISTENT = 0xC000019B

;
; MessageId: STATUS_FS_DRIVER_REQUIRED
;
; MessageText:
;
;  A volume has been accessed for which a file system driver is required that has not yet been loaded.
;
STATUS_FS_DRIVER_REQUIRED	 = 0xC000019C

;
; MessageId: STATUS_NO_USER_SESSION_KEY
;
; MessageText:
;
;  There is no user session key for the specified logon session.
;
STATUS_NO_USER_SESSION_KEY	 = 0xC0000202

;
; MessageId: STATUS_USER_SESSION_DELETED
;
; MessageText:
;
;  The remote user session has been deleted.
;
STATUS_USER_SESSION_DELETED	 = 0xC0000203

;
; MessageId: STATUS_RESOURCE_LANG_NOT_FOUND
;
; MessageText:
;
;  Indicates the specified resource language ID cannot be found in the
;  image file.
;
STATUS_RESOURCE_LANG_NOT_FOUND	 = 0xC0000204

;
; MessageId: STATUS_INSUFF_SERVER_RESOURCES
;
; MessageText:
;
;  Insufficient server resources exist to complete the request.
;
STATUS_INSUFF_SERVER_RESOURCES	 = 0xC0000205

;
; MessageId: STATUS_INVALID_BUFFER_SIZE
;
; MessageText:
;
;  The size of the buffer is invalid for the specified operation.
;
STATUS_INVALID_BUFFER_SIZE	 = 0xC0000206

;
; MessageId: STATUS_INVALID_ADDRESS_COMPONENT
;
; MessageText:
;
;  The transport rejected the network address specified as invalid.
;
STATUS_INVALID_ADDRESS_COMPONENT = 0xC0000207

;
; MessageId: STATUS_INVALID_ADDRESS_WILDCARD
;
; MessageText:
;
;  The transport rejected the network address specified due to an invalid use of a wildcard.
;
STATUS_INVALID_ADDRESS_WILDCARD  = 0xC0000208

;
; MessageId: STATUS_TOO_MANY_ADDRESSES
;
; MessageText:
;
;  The transport address could not be opened because all the available addresses are in use.
;
STATUS_TOO_MANY_ADDRESSES	 = 0xC0000209

;
; MessageId: STATUS_ADDRESS_ALREADY_EXISTS
;
; MessageText:
;
;  The transport address could not be opened because it already exists.
;
STATUS_ADDRESS_ALREADY_EXISTS	 = 0xC000020A

;
; MessageId: STATUS_ADDRESS_CLOSED
;
; MessageText:
;
;  The transport address is now closed.
;
STATUS_ADDRESS_CLOSED		 = 0xC000020B

;
; MessageId: STATUS_CONNECTION_DISCONNECTED
;
; MessageText:
;
;  The transport connection is now disconnected.
;
STATUS_CONNECTION_DISCONNECTED	 = 0xC000020C

;
; MessageId: STATUS_CONNECTION_RESET
;
; MessageText:
;
;  The transport connection has been reset.
;
STATUS_CONNECTION_RESET 	 = 0xC000020D

;
; MessageId: STATUS_TOO_MANY_NODES
;
; MessageText:
;
;  The transport cannot dynamically acquire any more nodes.
;
STATUS_TOO_MANY_NODES		 = 0xC000020E

;
; MessageId: STATUS_TRANSACTION_ABORTED
;
; MessageText:
;
;  The transport aborted a pending transaction.
;
STATUS_TRANSACTION_ABORTED	 = 0xC000020F

;
; MessageId: STATUS_TRANSACTION_TIMED_OUT
;
; MessageText:
;
;  The transport timed out a request waiting for a response.
;
STATUS_TRANSACTION_TIMED_OUT	 = 0xC0000210

;
; MessageId: STATUS_TRANSACTION_NO_RELEASE
;
; MessageText:
;
;  The transport did not receive a release for a pending response.
;
STATUS_TRANSACTION_NO_RELEASE	 = 0xC0000211

;
; MessageId: STATUS_TRANSACTION_NO_MATCH
;
; MessageText:
;
;  The transport did not find a transaction matching the specific
;  token.
;
STATUS_TRANSACTION_NO_MATCH	 = 0xC0000212

;
; MessageId: STATUS_TRANSACTION_RESPONDED
;
; MessageText:
;
;  The transport had previously responded to a transaction request.
;
STATUS_TRANSACTION_RESPONDED	 = 0xC0000213

;
; MessageId: STATUS_TRANSACTION_INVALID_ID
;
; MessageText:
;
;  The transport does not recognized the transaction request identifier specified.
;
STATUS_TRANSACTION_INVALID_ID	 = 0xC0000214

;
; MessageId: STATUS_TRANSACTION_INVALID_TYPE
;
; MessageText:
;
;  The transport does not recognize the transaction request type specified.
;
STATUS_TRANSACTION_INVALID_TYPE  = 0xC0000215

;
; MessageId: STATUS_NOT_SERVER_SESSION
;
; MessageText:
;
;  The transport can only process the specified request on the server side of a session.
;
STATUS_NOT_SERVER_SESSION	 = 0xC0000216

;
; MessageId: STATUS_NOT_CLIENT_SESSION
;
; MessageText:
;
;  The transport can only process the specified request on the client side of a session.
;
STATUS_NOT_CLIENT_SESSION	 = 0xC0000217

;
; MessageId: STATUS_CANNOT_LOAD_REGISTRY_FILE
;
; MessageText:
;
;  {Registry File Failure}
;  The registry cannot load the hive (file):
;  %hs
;  or its log or alternate.
;  It is corrupt, absent, or not writable.
;
STATUS_CANNOT_LOAD_REGISTRY_FILE = 0xC0000218

;
; MessageId: STATUS_DEBUG_ATTACH_FAILED
;
; MessageText:
;
;  {Unexpected Failure in DebugActiveProcess}
;  An unexpected failure occurred while processing a DebugActiveProcess API request. You may choose OK to terminate the process, or Cancel to ignore the error.
;
STATUS_DEBUG_ATTACH_FAILED	 = 0xC0000219

;
; MessageId: STATUS_SYSTEM_PROCESS_TERMINATED
;
; MessageText:
;
;  {Fatal System Error}
;  The %hs system process terminated unexpectedly with a status of = 0x%08x (= 0x%08x = 0x%08x).
;  The system has been shut down.
;
STATUS_SYSTEM_PROCESS_TERMINATED = 0xC000021A

;
; MessageId: STATUS_DATA_NOT_ACCEPTED
;
; MessageText:
;
;  {Data Not Accepted}
;  The TDI client could not handle the data received during an indication.
;
STATUS_DATA_NOT_ACCEPTED	 = 0xC000021B

;
; MessageId: STATUS_NO_BROWSER_SERVERS_FOUND
;
; MessageText:
;
;  {Unable to Retrieve Browser Server List}
;  The list of servers for this workgroup is not currently available.
;
STATUS_NO_BROWSER_SERVERS_FOUND  = 0xC000021C

;
; MessageId: STATUS_VDM_HARD_ERROR
;
; MessageText:
;
;  NTVDM encountered a hard error.
;
STATUS_VDM_HARD_ERROR		 = 0xC000021D

;
; MessageId: STATUS_DRIVER_CANCEL_TIMEOUT
;
; MessageText:
;
;  {Cancel Timeout}
;  The driver %hs failed to complete a cancelled I/O request in the allotted time.
;
STATUS_DRIVER_CANCEL_TIMEOUT	 = 0xC000021E

;
; MessageId: STATUS_REPLY_MESSAGE_MISMATCH
;
; MessageText:
;
;  {Reply Message Mismatch}
;  An attempt was made to reply to an LPC message, but the thread specified by the client ID in the message was not waiting on that message.
;
STATUS_REPLY_MESSAGE_MISMATCH	 = 0xC000021F

;
; MessageId: STATUS_MAPPED_ALIGNMENT
;
; MessageText:
;
;  {Mapped View Alignment Incorrect}
;  An attempt was made to map a view of a file, but either the specified base address or the offset into the file were not aligned on the proper allocation granularity.
;
STATUS_MAPPED_ALIGNMENT 	 = 0xC0000220

;
; MessageId: STATUS_IMAGE_CHECKSUM_MISMATCH
;
; MessageText:
;
;  {Bad Image Checksum}
;  The image %hs is possibly corrupt. The header checksum does not match the computed checksum.
;
STATUS_IMAGE_CHECKSUM_MISMATCH	 = 0xC0000221

;
; MessageId: STATUS_LOST_WRITEBEHIND_DATA
;
; MessageText:
;
;  {Delayed Write Failed}
;  Windows was unable to save all the data for the file %hs. The data has been lost.
;  This error may be caused by a failure of your computer hardware or network connection. Please try to save this file elsewhere.
;
STATUS_LOST_WRITEBEHIND_DATA	 = 0xC0000222

;
; MessageId: STATUS_CLIENT_SERVER_PARAMETERS_INVALID
;
; MessageText:
;
;  The parameter(s) passed to the server in the client/server shared memory window were invalid. Too much data may have been put in the shared memory window.
;
STATUS_CLIENT_SERVER_PARAMETERS_INVALID = 0xC0000223

;
; MessageId: STATUS_PASSWORD_MUST_CHANGE
;
; MessageText:
;
;  The user's password must be changed before logging on the first time.
;
STATUS_PASSWORD_MUST_CHANGE	 = 0xC0000224	 ; ntsubauth

;
; MessageId: STATUS_NOT_FOUND
;
; MessageText:
;
;  The object was not found.
;
STATUS_NOT_FOUND		 = 0xC0000225

;
; MessageId: STATUS_NOT_TINY_STREAM
;
; MessageText:
;
;  The stream is not a tiny stream.
;
STATUS_NOT_TINY_STREAM		 = 0xC0000226

;
; MessageId: STATUS_RECOVERY_FAILURE
;
; MessageText:
;
;  A transaction recover failed.
;
STATUS_RECOVERY_FAILURE 	 = 0xC0000227

;
; MessageId: STATUS_STACK_OVERFLOW_READ
;
; MessageText:
;
;  The request must be handled by the stack overflow code.
;
STATUS_STACK_OVERFLOW_READ	 = 0xC0000228

;
; MessageId: STATUS_FAIL_CHECK
;
; MessageText:
;
;  A consistency check failed.
;
STATUS_FAIL_CHECK		 = 0xC0000229

;
; MessageId: STATUS_DUPLICATE_OBJECTID
;
; MessageText:
;
;  The attempt to insert the ID in the index failed because the ID is already in the index.
;
STATUS_DUPLICATE_OBJECTID	 = 0xC000022A

;
; MessageId: STATUS_OBJECTID_EXISTS
;
; MessageText:
;
;  The attempt to set the object's ID failed because the object already has an ID.
;
STATUS_OBJECTID_EXISTS		 = 0xC000022B

;
; MessageId: STATUS_CONVERT_TO_LARGE
;
; MessageText:
;
;  Internal OFS status codes indicating how an allocation operation is handled. Either it is retried after the containing onode is moved or the extent stream is converted to a large stream.
;
STATUS_CONVERT_TO_LARGE 	 = 0xC000022C

;
; MessageId: STATUS_RETRY
;
; MessageText:
;
;  The request needs to be retried.
;
STATUS_RETRY			 = 0xC000022D

;
; MessageId: STATUS_FOUND_OUT_OF_SCOPE
;
; MessageText:
;
;  The attempt to find the object found an object matching by ID on the volume but it is out of the scope of the handle used for the operation.
;
STATUS_FOUND_OUT_OF_SCOPE	 = 0xC000022E

;
; MessageId: STATUS_ALLOCATE_BUCKET
;
; MessageText:
;
;  The bucket array must be grown. Retry transaction after doing so.
;
STATUS_ALLOCATE_BUCKET		 = 0xC000022F

;
; MessageId: STATUS_PROPSET_NOT_FOUND
;
; MessageText:
;
;  The property set specified does not exist on the object.
;
STATUS_PROPSET_NOT_FOUND	 = 0xC0000230

;
; MessageId: STATUS_MARSHALL_OVERFLOW
;
; MessageText:
;
;  The user/kernel marshalling buffer has overflowed.
;
STATUS_MARSHALL_OVERFLOW	 = 0xC0000231

;
; MessageId: STATUS_INVALID_VARIANT
;
; MessageText:
;
;  The supplied variant structure contains invalid data.
;
STATUS_INVALID_VARIANT		 = 0xC0000232

;
; MessageId: STATUS_DOMAIN_CONTROLLER_NOT_FOUND
;
; MessageText:
;
;  Could not find a domain controller for this domain.
;
STATUS_DOMAIN_CONTROLLER_NOT_FOUND = 0xC0000233

;
; MessageId: STATUS_ACCOUNT_LOCKED_OUT
;
; MessageText:
;
;  The user account has been automatically locked because too many invalid logon attempts or password change attempts have been requested.
;
STATUS_ACCOUNT_LOCKED_OUT	 = 0xC0000234	 ; ntsubauth

;
; MessageId: STATUS_HANDLE_NOT_CLOSABLE
;
; MessageText:
;
;  NtClose was called on a handle that was protected from close via NtSetInformationObject.
;
STATUS_HANDLE_NOT_CLOSABLE	 = 0xC0000235

;
; MessageId: STATUS_CONNECTION_REFUSED
;
; MessageText:
;
;  The transport connection attempt was refused by the remote system.
;
STATUS_CONNECTION_REFUSED	 = 0xC0000236

;
; MessageId: STATUS_GRACEFUL_DISCONNECT
;
; MessageText:
;
;  The transport connection was gracefully closed.
;
STATUS_GRACEFUL_DISCONNECT	 = 0xC0000237

;
; MessageId: STATUS_ADDRESS_ALREADY_ASSOCIATED
;
; MessageText:
;
;  The transport endpoint already has an address associated with it.
;
STATUS_ADDRESS_ALREADY_ASSOCIATED = 0xC0000238

;
; MessageId: STATUS_ADDRESS_NOT_ASSOCIATED
;
; MessageText:
;
;  An address has not yet been associated with the transport endpoint.
;
STATUS_ADDRESS_NOT_ASSOCIATED	 = 0xC0000239

;
; MessageId: STATUS_CONNECTION_INVALID
;
; MessageText:
;
;  An operation was attempted on a nonexistent transport connection.
;
STATUS_CONNECTION_INVALID	 = 0xC000023A

;
; MessageId: STATUS_CONNECTION_ACTIVE
;
; MessageText:
;
;  An invalid operation was attempted on an active transport connection.
;
STATUS_CONNECTION_ACTIVE	 = 0xC000023B

;
; MessageId: STATUS_NETWORK_UNREACHABLE
;
; MessageText:
;
;  The remote network is not reachable by the transport.
;
STATUS_NETWORK_UNREACHABLE	 = 0xC000023C

;
; MessageId: STATUS_HOST_UNREACHABLE
;
; MessageText:
;
;  The remote system is not reachable by the transport.
;
STATUS_HOST_UNREACHABLE 	 = 0xC000023D

;
; MessageId: STATUS_PROTOCOL_UNREACHABLE
;
; MessageText:
;
;  The remote system does not support the transport protocol.
;
STATUS_PROTOCOL_UNREACHABLE	 = 0xC000023E

;
; MessageId: STATUS_PORT_UNREACHABLE
;
; MessageText:
;
;  No service is operating at the destination port of the transport on the remote system.
;
STATUS_PORT_UNREACHABLE 	 = 0xC000023F

;
; MessageId: STATUS_REQUEST_ABORTED
;
; MessageText:
;
;  The request was aborted.
;
STATUS_REQUEST_ABORTED		 = 0xC0000240

;
; MessageId: STATUS_CONNECTION_ABORTED
;
; MessageText:
;
;  The transport connection was aborted by the local system.
;
STATUS_CONNECTION_ABORTED	 = 0xC0000241

;
; MessageId: STATUS_BAD_COMPRESSION_BUFFER
;
; MessageText:
;
;  The specified buffer contains ill-formed data.
;
STATUS_BAD_COMPRESSION_BUFFER	 = 0xC0000242

;
; MessageId: STATUS_USER_MAPPED_FILE
;
; MessageText:
;
;  The requested operation cannot be performed on a file with a user mapped section open.
;
STATUS_USER_MAPPED_FILE 	 = 0xC0000243

;
; MessageId: STATUS_AUDIT_FAILED
;
; MessageText:
;
;  {Audit Failed}
;  An attempt to generate a security audit failed.
;
STATUS_AUDIT_FAILED		 = 0xC0000244

;
; MessageId: STATUS_TIMER_RESOLUTION_NOT_SET
;
; MessageText:
;
;  The timer resolution was not previously set by the current process.
;
STATUS_TIMER_RESOLUTION_NOT_SET  = 0xC0000245

;
; MessageId: STATUS_CONNECTION_COUNT_LIMIT
;
; MessageText:
;
;  A connection to the server could not be made because the limit on the number of concurrent connections for this account has been reached.
;
STATUS_CONNECTION_COUNT_LIMIT	 = 0xC0000246

;
; MessageId: STATUS_LOGIN_TIME_RESTRICTION
;
; MessageText:
;
;  Attempting to login during an unauthorized time of day for this account.
;
STATUS_LOGIN_TIME_RESTRICTION	 = 0xC0000247

;
; MessageId: STATUS_LOGIN_WKSTA_RESTRICTION
;
; MessageText:
;
;  The account is not authorized to login from this station.
;
STATUS_LOGIN_WKSTA_RESTRICTION	 = 0xC0000248

;
; MessageId: STATUS_IMAGE_MP_UP_MISMATCH
;
; MessageText:
;
;  {UP/MP Image Mismatch}
;  The image %hs has been modified for use on a uniprocessor system, but you are running it on a multiprocessor machine.
;  Please reinstall the image file.
;
STATUS_IMAGE_MP_UP_MISMATCH	 = 0xC0000249

;
; MessageId: STATUS_INSUFFICIENT_LOGON_INFO
;
; MessageText:
;
;  There is insufficient account information to log you on.
;
STATUS_INSUFFICIENT_LOGON_INFO	 = 0xC0000250

;
; MessageId: STATUS_BAD_DLL_ENTRYPOINT
;
; MessageText:
;
;  {Invalid DLL Entrypoint}
;  The dynamic link library %hs is not written correctly. The stack pointer has been left in an inconsistent state.
;  The entrypoint should be declared as WINAPI or STDCALL. Select YES to fail the DLL load. Select NO to continue execution. Selecting NO may cause the application to operate incorrectly.
;
STATUS_BAD_DLL_ENTRYPOINT	 = 0xC0000251

;
; MessageId: STATUS_BAD_SERVICE_ENTRYPOINT
;
; MessageText:
;
;  {Invalid Service Callback Entrypoint}
;  The %hs service is not written correctly. The stack pointer has been left in an inconsistent state.
;  The callback entrypoint should be declared as WINAPI or STDCALL. Selecting OK will cause the service to continue operation. However, the service process may operate incorrectly.
;
STATUS_BAD_SERVICE_ENTRYPOINT	 = 0xC0000252

;
; MessageId: STATUS_LPC_REPLY_LOST
;
; MessageText:
;
;  The server received the messages but did not send a reply.
;
STATUS_LPC_REPLY_LOST		 = 0xC0000253

;
; MessageId: STATUS_IP_ADDRESS_CONFLICT1
;
; MessageText:
;
;  There is an IP address conflict with another system on the network
;
STATUS_IP_ADDRESS_CONFLICT1	 = 0xC0000254

;
; MessageId: STATUS_IP_ADDRESS_CONFLICT2
;
; MessageText:
;
;  There is an IP address conflict with another system on the network
;
STATUS_IP_ADDRESS_CONFLICT2	 = 0xC0000255

;
; MessageId: STATUS_REGISTRY_QUOTA_LIMIT
;
; MessageText:
;
;  {Low On Registry Space}
;  The system has reached the maximum size allowed for the system part of the registry.  Additional storage requests will be ignored.
;
STATUS_REGISTRY_QUOTA_LIMIT	 = 0xC0000256

;
; MessageId: STATUS_PATH_NOT_COVERED
;
; MessageText:
;
;  The contacted server does not support the indicated part of the DFS namespace.
;
STATUS_PATH_NOT_COVERED 	 = 0xC0000257

;
; MessageId: STATUS_NO_CALLBACK_ACTIVE
;
; MessageText:
;
;  A callback return system service cannot be executed when no callback is active.
;
STATUS_NO_CALLBACK_ACTIVE	 = 0xC0000258

;
; MessageId: STATUS_LICENSE_QUOTA_EXCEEDED
;
; MessageText:
;
;  The service being accessed is licensed for a particular number of connections.
;  No more connections can be made to the service at this time because there are already as many connections as the service can accept.
;
STATUS_LICENSE_QUOTA_EXCEEDED	 = 0xC0000259

;
; MessageId: STATUS_PWD_TOO_SHORT
;
; MessageText:
;
;  The password provided is too short to meet the policy of your user account.
;  Please choose a longer password.
;
STATUS_PWD_TOO_SHORT		 = 0xC000025A

;
; MessageId: STATUS_PWD_TOO_RECENT
;
; MessageText:
;
;  The policy of your user account does not allow you to change passwords too frequently.
;  This is done to prevent users from changing back to a familiar, but potentially discovered, password.
;  If you feel your password has been compromised then please contact your administrator immediately to have a new one assigned.
;
STATUS_PWD_TOO_RECENT		 = 0xC000025B

;
; MessageId: STATUS_PWD_HISTORY_CONFLICT
;
; MessageText:
;
;  You have attempted to change your password to one that you have used in the past.
;  The policy of your user account does not allow this. Please select a password that you have not previously used.
;
STATUS_PWD_HISTORY_CONFLICT	 = 0xC000025C

;
; MessageId: STATUS_PLUGPLAY_NO_DEVICE
;
; MessageText:
;
;  You have attempted to load a legacy device driver while its device instance had been disabled.
;
STATUS_PLUGPLAY_NO_DEVICE	 = 0xC000025E

;
; MessageId: STATUS_UNSUPPORTED_COMPRESSION
;
; MessageText:
;
;  The specified compression format is unsupported.
;
STATUS_UNSUPPORTED_COMPRESSION	 = 0xC000025F

;
; MessageId: STATUS_INVALID_HW_PROFILE
;
; MessageText:
;
;  The specified hardware profile configuration is invalid.
;
STATUS_INVALID_HW_PROFILE	 = 0xC0000260

;
; MessageId: STATUS_INVALID_PLUGPLAY_DEVICE_PATH
;
; MessageText:
;
;  The specified Plug and Play registry device path is invalid.
;
STATUS_INVALID_PLUGPLAY_DEVICE_PATH = 0xC0000261

;
; MessageId: STATUS_DRIVER_ORDINAL_NOT_FOUND
;
; MessageText:
;
;  {Driver Entry Point Not Found}
;  The %hs device driver could not locate the ordinal %ld in driver %hs.
;
STATUS_DRIVER_ORDINAL_NOT_FOUND  = 0xC0000262

;
; MessageId: STATUS_DRIVER_ENTRYPOINT_NOT_FOUND
;
; MessageText:
;
;  {Driver Entry Point Not Found}
;  The %hs device driver could not locate the entry point %hs in driver %hs.
;
STATUS_DRIVER_ENTRYPOINT_NOT_FOUND = 0xC0000263

;
; MessageId: STATUS_RESOURCE_NOT_OWNED
;
; MessageText:
;
;  {Application Error}
;  The application attempted to release a resource it did not own. Click on OK to terminate the application.
;
STATUS_RESOURCE_NOT_OWNED	 = 0xC0000264

;
; MessageId: STATUS_TOO_MANY_LINKS
;
; MessageText:
;
;  An attempt was made to create more links on a file than the file system supports.
;
STATUS_TOO_MANY_LINKS		 = 0xC0000265

;
; MessageId: STATUS_QUOTA_LIST_INCONSISTENT
;
; MessageText:
;
;  The specified quota list is internally inconsistent with its descriptor.
;
STATUS_QUOTA_LIST_INCONSISTENT	 = 0xC0000266

;
; MessageId: STATUS_FILE_IS_OFFLINE
;
; MessageText:
;
;  The specified file has been relocated to offline storage.
;
STATUS_FILE_IS_OFFLINE		 = 0xC0000267

;
; MessageId: STATUS_EVALUATION_EXPIRATION
;
; MessageText:
;
;  {Windows Evaluation Notification}
;  The evaluation period for this installation of Windows has expired. This system will shutdown in 1 hour. To restore access to this installation of Windows, please upgrade this installation using a licensed distribution of this product.
;
STATUS_EVALUATION_EXPIRATION	 = 0xC0000268

;
; MessageId: STATUS_ILLEGAL_DLL_RELOCATION
;
; MessageText:
;
;  {Illegal System DLL Relocation}
;  The system DLL %hs was relocated in memory. The application will not run properly.
;  The relocation occurred because the DLL %hs occupied an address range reserved for Windows system DLLs. The vendor supplying the DLL should be contacted for a new DLL.
;
STATUS_ILLEGAL_DLL_RELOCATION	 = 0xC0000269

;
; MessageId: STATUS_LICENSE_VIOLATION
;
; MessageText:
;
;  {License Violation}
;  The system has detected tampering with your registered product type. This is a violation of your software license. Tampering with product type is not permitted.
;
STATUS_LICENSE_VIOLATION	 = 0xC000026A

;
; MessageId: STATUS_DLL_INIT_FAILED_LOGOFF
;
; MessageText:
;
;  {DLL Initialization Failed}
;  The application failed to initialize because the window station is shutting down.
;
STATUS_DLL_INIT_FAILED_LOGOFF	 = 0xC000026B

;
; MessageId: STATUS_DRIVER_UNABLE_TO_LOAD
;
; MessageText:
;
;  {Unable to Load Device Driver}
;  %hs device driver could not be loaded.
;  Error Status was = 0x%x
;
STATUS_DRIVER_UNABLE_TO_LOAD	 = 0xC000026C

;
; MessageId: STATUS_DFS_UNAVAILABLE
;
; MessageText:
;
;  DFS is unavailable on the contacted server.
;
STATUS_DFS_UNAVAILABLE		 = 0xC000026D

;
; MessageId: STATUS_VOLUME_DISMOUNTED
;
; MessageText:
;
;  An operation was attempted to a volume after it was dismounted.
;
STATUS_VOLUME_DISMOUNTED	 = 0xC000026E

;
; MessageId: STATUS_WX86_INTERNAL_ERROR
;
; MessageText:
;
;  An internal error occurred in the Win32 x86 emulation subsystem.
;
STATUS_WX86_INTERNAL_ERROR	 = 0xC000026F

;
; MessageId: STATUS_WX86_FLOAT_STACK_CHECK
;
; MessageText:
;
;  Win32 x86 emulation subsystem Floating-point stack check.
;
STATUS_WX86_FLOAT_STACK_CHECK	 = 0xC0000270

;
; MessageId: STATUS_VALIDATE_CONTINUE
;
; MessageText:
;
;  The validation process needs to continue on to the next step.
;
STATUS_VALIDATE_CONTINUE	 = 0xC0000271

;
; MessageId: STATUS_NO_MATCH
;
; MessageText:
;
;  There was no match for the specified key in the index.
;
STATUS_NO_MATCH 		 = 0xC0000272

;
; MessageId: STATUS_NO_MORE_MATCHES
;
; MessageText:
;
;  There are no more matches for the current index enumeration.
;
STATUS_NO_MORE_MATCHES		 = 0xC0000273

;
; MessageId: STATUS_NOT_A_REPARSE_POINT
;
; MessageText:
;
;  The NTFS file or directory is not a reparse point.
;
STATUS_NOT_A_REPARSE_POINT	 = 0xC0000275

;
; MessageId: STATUS_IO_REPARSE_TAG_INVALID
;
; MessageText:
;
;  The Windows I/O reparse tag passed for the NTFS reparse point is invalid.
;
STATUS_IO_REPARSE_TAG_INVALID	 = 0xC0000276

;
; MessageId: STATUS_IO_REPARSE_TAG_MISMATCH
;
; MessageText:
;
;  The Windows I/O reparse tag does not match the one present in the NTFS reparse point.
;
STATUS_IO_REPARSE_TAG_MISMATCH	 = 0xC0000277

;
; MessageId: STATUS_IO_REPARSE_DATA_INVALID
;
; MessageText:
;
;  The user data passed for the NTFS reparse point is invalid.
;
STATUS_IO_REPARSE_DATA_INVALID	 = 0xC0000278

;
; MessageId: STATUS_IO_REPARSE_TAG_NOT_HANDLED
;
; MessageText:
;
;  The layered file system driver for this IO tag did not handle it when needed.
;
STATUS_IO_REPARSE_TAG_NOT_HANDLED = 0xC0000279

;
; MessageId: STATUS_REPARSE_POINT_NOT_RESOLVED
;
; MessageText:
;
;  The NTFS symbolic link could not be resolved even though the initial file name is valid.
;
STATUS_REPARSE_POINT_NOT_RESOLVED = 0xC0000280

;
; MessageId: STATUS_DIRECTORY_IS_A_REPARSE_POINT
;
; MessageText:
;
;  The NTFS directory is a reparse point.
;
STATUS_DIRECTORY_IS_A_REPARSE_POINT = 0xC0000281

;
; MessageId: STATUS_RANGE_LIST_CONFLICT
;
; MessageText:
;
;  The range could not be added to the range list because of a conflict.
;
STATUS_RANGE_LIST_CONFLICT	 = 0xC0000282

;
; MessageId: STATUS_SOURCE_ELEMENT_EMPTY
;
; MessageText:
;
;  The specified medium changer source element contains no media.
;
STATUS_SOURCE_ELEMENT_EMPTY	 = 0xC0000283

;
; MessageId: STATUS_DESTINATION_ELEMENT_FULL
;
; MessageText:
;
;  The specified medium changer destination element already contains media.
;
STATUS_DESTINATION_ELEMENT_FULL  = 0xC0000284

;
; MessageId: STATUS_ILLEGAL_ELEMENT_ADDRESS
;
; MessageText:
;
;  The specified medium changer element does not exist.
;
STATUS_ILLEGAL_ELEMENT_ADDRESS	 = 0xC0000285

;
; MessageId: STATUS_MAGAZINE_NOT_PRESENT
;
; MessageText:
;
;  The specified element is contained within a magazine that is no longer present.
;
STATUS_MAGAZINE_NOT_PRESENT	 = 0xC0000286

;
; MessageId: STATUS_REINITIALIZATION_NEEDED
;
; MessageText:
;
;  The device requires reinitialization due to hardware errors.
;
STATUS_REINITIALIZATION_NEEDED	 = 0xC0000287

;
; MessageId: STATUS_DEVICE_REQUIRES_CLEANING
;
; MessageText:
;
;  The device has indicated that cleaning is necessary.
;
STATUS_DEVICE_REQUIRES_CLEANING  = 0x80000288

;
; MessageId: STATUS_DEVICE_DOOR_OPEN
;
; MessageText:
;
;  The device has indicated that it's door is open. Further operations require it closed and secured.
;
STATUS_DEVICE_DOOR_OPEN 	 = 0x80000289

;
; MessageId: STATUS_ENCRYPTION_FAILED
;
; MessageText:
;
;  The file encryption attempt failed.
;
STATUS_ENCRYPTION_FAILED	 = 0xC000028A

;
; MessageId: STATUS_DECRYPTION_FAILED
;
; MessageText:
;
;  The file decryption attempt failed.
;
STATUS_DECRYPTION_FAILED	 = 0xC000028B

;
; MessageId: STATUS_RANGE_NOT_FOUND
;
; MessageText:
;
;  The specified range could not be found in the range list.
;
STATUS_RANGE_NOT_FOUND		 = 0xC000028C

;
; MessageId: STATUS_NO_RECOVERY_POLICY
;
; MessageText:
;
;  There is no encryption recovery policy configured for this system.
;
STATUS_NO_RECOVERY_POLICY	 = 0xC000028D

;
; MessageId: STATUS_NO_EFS
;
; MessageText:
;
;  The required encryption driver is not loaded for this system.
;
STATUS_NO_EFS			 = 0xC000028E

;
; MessageId: STATUS_WRONG_EFS
;
; MessageText:
;
;  The file was encrypted with a different encryption driver than is currently loaded.
;
STATUS_WRONG_EFS		 = 0xC000028F

;
; MessageId: STATUS_NO_USER_KEYS
;
; MessageText:
;
;  There are no EFS keys defined for the user.
;
STATUS_NO_USER_KEYS		 = 0xC0000290

;
; MessageId: STATUS_FILE_NOT_ENCRYPTED
;
; MessageText:
;
;  The specified file is not encrypted.
;
STATUS_FILE_NOT_ENCRYPTED	 = 0xC0000291

;
; MessageId: STATUS_NOT_EXPORT_FORMAT
;
; MessageText:
;
;  The specified file is not in the defined EFS export format.
;
STATUS_NOT_EXPORT_FORMAT	 = 0xC0000292

;
; MessageId: STATUS_FILE_ENCRYPTED
;
; MessageText:
;
;  The specified file is encrypted and the user does not have the ability to decrypt it.
;
STATUS_FILE_ENCRYPTED		 = 0xC0000293

;
; MessageId: STATUS_WAKE_SYSTEM
;
; MessageText:
;
;  The system has awoken
;
STATUS_WAKE_SYSTEM		 = 0x40000294

;
; MessageId: STATUS_WMI_GUID_NOT_FOUND
;
; MessageText:
;
;  The guid passed was not recognized as valid by a WMI data provider.
;
STATUS_WMI_GUID_NOT_FOUND	 = 0xC0000295

;
; MessageId: STATUS_WMI_INSTANCE_NOT_FOUND
;
; MessageText:
;
;  The instance name passed was not recognized as valid by a WMI data provider.
;
STATUS_WMI_INSTANCE_NOT_FOUND	 = 0xC0000296

;
; MessageId: STATUS_WMI_ITEMID_NOT_FOUND
;
; MessageText:
;
;  The data item id passed was not recognized as valid by a WMI data provider.
;
STATUS_WMI_ITEMID_NOT_FOUND	 = 0xC0000297

;
; MessageId: STATUS_WMI_TRY_AGAIN
;
; MessageText:
;
;  The WMI request could not be completed and should be retried.
;
STATUS_WMI_TRY_AGAIN		 = 0xC0000298

;
; MessageId: STATUS_SHARED_POLICY
;
; MessageText:
;
;  The policy object is shared and can only be modified at the root
;
STATUS_SHARED_POLICY		 = 0xC0000299

;
; MessageId: STATUS_POLICY_OBJECT_NOT_FOUND
;
; MessageText:
;
;  The policy object does not exist when it should
;
STATUS_POLICY_OBJECT_NOT_FOUND	 = 0xC000029A

;
; MessageId: STATUS_POLICY_ONLY_IN_DS
;
; MessageText:
;
;  The requested policy information only lives in the Ds
;
STATUS_POLICY_ONLY_IN_DS	 = 0xC000029B

;
; MessageId: STATUS_VOLUME_NOT_UPGRADED
;
; MessageText:
;
;  The volume must be upgraded to enable this feature
;
STATUS_VOLUME_NOT_UPGRADED	 = 0xC000029C

;
; MessageId: STATUS_REMOTE_STORAGE_NOT_ACTIVE
;
; MessageText:
;
;  The remote storage service is not operational at this time.
;
STATUS_REMOTE_STORAGE_NOT_ACTIVE = 0xC000029D

;
; MessageId: STATUS_REMOTE_STORAGE_MEDIA_ERROR
;
; MessageText:
;
;  The remote storage service encountered a media error.
;
STATUS_REMOTE_STORAGE_MEDIA_ERROR = 0xC000029E

;
; MessageId: STATUS_NO_TRACKING_SERVICE
;
; MessageText:
;
;  The tracking (workstation) service is not running.
;
STATUS_NO_TRACKING_SERVICE	 = 0xC000029F

;
; MessageId: STATUS_SERVER_SID_MISMATCH
;
; MessageText:
;
;  The server process is running under a SID different than that required by client.
;
STATUS_SERVER_SID_MISMATCH	 = 0xC00002A0

;
; Directory Service specific Errors
;
;
; MessageId: STATUS_DS_NO_ATTRIBUTE_OR_VALUE
;
; MessageText:
;
;  The specified directory service attribute or value does not exist.
;
STATUS_DS_NO_ATTRIBUTE_OR_VALUE  = 0xC00002A1

;
; MessageId: STATUS_DS_INVALID_ATTRIBUTE_SYNTAX
;
; MessageText:
;
;  The attribute syntax specified to the directory service is invalid.
;
STATUS_DS_INVALID_ATTRIBUTE_SYNTAX = 0xC00002A2

;
; MessageId: STATUS_DS_ATTRIBUTE_TYPE_UNDEFINED
;
; MessageText:
;
;  The attribute type specified to the directory service is not defined.
;
STATUS_DS_ATTRIBUTE_TYPE_UNDEFINED = 0xC00002A3

;
; MessageId: STATUS_DS_ATTRIBUTE_OR_VALUE_EXISTS
;
; MessageText:
;
;  The specified directory service attribute or value already exists.
;
STATUS_DS_ATTRIBUTE_OR_VALUE_EXISTS = 0xC00002A4

;
; MessageId: STATUS_DS_BUSY
;
; MessageText:
;
;  The directory service is busy.
;
STATUS_DS_BUSY			 = 0xC00002A5

;
; MessageId: STATUS_DS_UNAVAILABLE
;
; MessageText:
;
;  The directory service is not available.
;
STATUS_DS_UNAVAILABLE		 = 0xC00002A6

;
; MessageId: STATUS_DS_NO_RIDS_ALLOCATED
;
; MessageText:
;
;  The directory service was unable to allocate a relative identifier.
;
STATUS_DS_NO_RIDS_ALLOCATED	 = 0xC00002A7

;
; MessageId: STATUS_DS_NO_MORE_RIDS
;
; MessageText:
;
;  The directory service has exhausted the pool of relative identifiers.
;
STATUS_DS_NO_MORE_RIDS		 = 0xC00002A8

;
; MessageId: STATUS_DS_INCORRECT_ROLE_OWNER
;
; MessageText:
;
;  The requested operation could not be performed because the directory service is not the master for that type of operation.
;
STATUS_DS_INCORRECT_ROLE_OWNER	 = 0xC00002A9

;
; MessageId: STATUS_DS_RIDMGR_INIT_ERROR
;
; MessageText:
;
;  The directory service was unable to initialize the subsystem that allocates relative identifiers.
;
STATUS_DS_RIDMGR_INIT_ERROR	 = 0xC00002AA

;
; MessageId: STATUS_DS_OBJ_CLASS_VIOLATION
;
; MessageText:
;
;  The requested operation did not satisfy one or more constraints associated with the class of the object.
;
STATUS_DS_OBJ_CLASS_VIOLATION	 = 0xC00002AB

;
; MessageId: STATUS_DS_CANT_ON_NON_LEAF
;
; MessageText:
;
;  The directory service can perform the requested operation only on a leaf object.
;
STATUS_DS_CANT_ON_NON_LEAF	 = 0xC00002AC

;
; MessageId: STATUS_DS_CANT_ON_RDN
;
; MessageText:
;
;  The directory service cannot perform the requested operation on the Relatively Defined Name (RDN) attribute of an object.
;
STATUS_DS_CANT_ON_RDN		 = 0xC00002AD

;
; MessageId: STATUS_DS_CANT_MOD_OBJ_CLASS
;
; MessageText:
;
;  The directory service detected an attempt to modify the object class of an object.
;
STATUS_DS_CANT_MOD_OBJ_CLASS	 = 0xC00002AE

;
; MessageId: STATUS_DS_CROSS_DOM_MOVE_FAILED
;
; MessageText:
;
;  An error occurred while performing a cross domain move operation.
;
STATUS_DS_CROSS_DOM_MOVE_FAILED  = 0xC00002AF

;
; MessageId: STATUS_DS_GC_NOT_AVAILABLE
;
; MessageText:
;
;  Unable to Contact the Global Catalog Server.
;
STATUS_DS_GC_NOT_AVAILABLE	 = 0xC00002B0

;
; MessageId: STATUS_DIRECTORY_SERVICE_REQUIRED
;
; MessageText:
;
;  The requested operation requires a directory service, and none was available.
;
STATUS_DIRECTORY_SERVICE_REQUIRED = 0xC00002B1

;
; MessageId: STATUS_REPARSE_ATTRIBUTE_CONFLICT
;
; MessageText:
;
;  The reparse attribute cannot be set as it is incompatible with an existing attribute.
;
STATUS_REPARSE_ATTRIBUTE_CONFLICT = 0xC00002B2

;
; MessageId: STATUS_CANT_ENABLE_DENY_ONLY
;
; MessageText:
;
;  A group marked use for deny only  can not be enabled.
;
STATUS_CANT_ENABLE_DENY_ONLY	 = 0xC00002B3

;
; MessageId: STATUS_FLOAT_MULTIPLE_FAULTS
;
; MessageText:
;
;  {EXCEPTION}
;  Multiple floating point faults.
;
STATUS_FLOAT_MULTIPLE_FAULTS	 = 0xC00002B4	 ; winnt

;
; MessageId: STATUS_FLOAT_MULTIPLE_TRAPS
;
; MessageText:
;
;  {EXCEPTION}
;  Multiple floating point traps.
;
STATUS_FLOAT_MULTIPLE_TRAPS	 = 0xC00002B5	 ; winnt

;
; MessageId: STATUS_DEVICE_REMOVED
;
; MessageText:
;
;  The device has been removed.
;
STATUS_DEVICE_REMOVED		 = 0xC00002B6

;
; MessageId: STATUS_JOURNAL_DELETE_IN_PROGRESS
;
; MessageText:
;
;  The volume change journal is being deleted.
;
STATUS_JOURNAL_DELETE_IN_PROGRESS = 0xC00002B7

;
; MessageId: STATUS_JOURNAL_NOT_ACTIVE
;
; MessageText:
;
;  The volume change journal is not active.
;
STATUS_JOURNAL_NOT_ACTIVE	 = 0xC00002B8

;
; MessageId: STATUS_NOINTERFACE
;
; MessageText:
;
;  The requested interface is not supported.
;
STATUS_NOINTERFACE		 = 0xC00002B9

;
; MessageId: STATUS_DS_ADMIN_LIMIT_EXCEEDED
;
; MessageText:
;
;  A directory service resource limit has been exceeded.
;
STATUS_DS_ADMIN_LIMIT_EXCEEDED	 = 0xC00002C1

;
; MessageId: STATUS_DRIVER_FAILED_SLEEP
;
; MessageText:
;
;  {System Standby Failed}
;  The driver %hs does not support standby mode. Updating this driver may allow the system to go to standby mode.
;
STATUS_DRIVER_FAILED_SLEEP	 = 0xC00002C2

;
; MessageId: STATUS_MUTUAL_AUTHENTICATION_FAILED
;
; MessageText:
;
;  Mutual Authentication failed. The server's password is out of date at the domain controller.
;
STATUS_MUTUAL_AUTHENTICATION_FAILED = 0xC00002C3

;
; MessageId: STATUS_CORRUPT_SYSTEM_FILE
;
; MessageText:
;
;  The system file %1 has become corrupt and has been replaced.
;
STATUS_CORRUPT_SYSTEM_FILE	 = 0xC00002C4

;
; MessageId: STATUS_DATATYPE_MISALIGNMENT_ERROR
;
; MessageText:
;
;  {EXCEPTION}
;  Alignment Error
;  A datatype misalignment error was detected in a load or store instruction.
;
STATUS_DATATYPE_MISALIGNMENT_ERROR = 0xC00002C5    

;
; MessageId: STATUS_WMI_READ_ONLY
;
; MessageText:
;
;  The WMI data item or data block is read only.
;
STATUS_WMI_READ_ONLY		 = 0xC00002C6

;
; MessageId: STATUS_WMI_SET_FAILURE
;
; MessageText:
;
;  The WMI data item or data block could not be changed.
;
STATUS_WMI_SET_FAILURE		 = 0xC00002C7

;
; MessageId: STATUS_COMMITMENT_MINIMUM
;
; MessageText:
;
;  {Virtual Memory Minimum Too Low}
;  Your system is low on virtual memory. Windows is increasing the size of your virtual memory paging file.
;  During this process, memory requests for some applications may be denied. For more information, see Help.
;
STATUS_COMMITMENT_MINIMUM	 = 0xC00002C8

;
; MessageId: STATUS_REG_NAT_CONSUMPTION
;
; MessageText:
;
;  {EXCEPTION}
;  Register NaT consumption faults.
;  A NaT value is consumed on a non speculative instruction.
;
STATUS_REG_NAT_CONSUMPTION	 = 0xC00002C9	 ; winnt

;
; MessageId: STATUS_TRANSPORT_FULL
;
; MessageText:
;
;  The medium changer's transport element contains media, which is causing the operation to fail.
;
STATUS_TRANSPORT_FULL		 = 0xC00002CA

;
; MessageId: STATUS_DS_SAM_INIT_FAILURE
;
; MessageText:
;
;  Security Accounts Manager initialization failed because of the following error:
;  %hs
;  Error Status: = 0x%x.
;  Please click OK to shutdown this system and reboot into Directory Services Restore Mode, check the event log for more detailed information.
;
STATUS_DS_SAM_INIT_FAILURE	 = 0xC00002CB

;
; MessageId: STATUS_ONLY_IF_CONNECTED
;
; MessageText:
;
;  This operation is supported only when you are connected to the server.
;
STATUS_ONLY_IF_CONNECTED	 = 0xC00002CC

;
; MessageId: STATUS_DS_SENSITIVE_GROUP_VIOLATION
;
; MessageText:
;
;  Only an administrator can modify the membership list of an administrative group.
;
STATUS_DS_SENSITIVE_GROUP_VIOLATION = 0xC00002CD

;
; MessageId: STATUS_PNP_RESTART_ENUMERATION
;
; MessageText:
;
;  A device was removed so enumeration must be restarted.
;
STATUS_PNP_RESTART_ENUMERATION	 = 0xC00002CE

;
; MessageId: STATUS_JOURNAL_ENTRY_DELETED
;
; MessageText:
;
;  The journal entry has been deleted from the journal.
;
STATUS_JOURNAL_ENTRY_DELETED	 = 0xC00002CF

;
; MessageId: STATUS_DS_CANT_MOD_PRIMARYGROUPID
;
; MessageText:
;
;  Cannot change the primary group ID of a domain controller account.
;
STATUS_DS_CANT_MOD_PRIMARYGROUPID = 0xC00002D0

;
; MessageId: STATUS_SYSTEM_IMAGE_BAD_SIGNATURE
;
; MessageText:
;
;  {Fatal System Error}
;  The system image %s is not properly signed.
;  The file has been replaced with the signed file.
;  The system has been shut down.
;
STATUS_SYSTEM_IMAGE_BAD_SIGNATURE = 0xC00002D1

;
; MessageId: STATUS_PNP_REBOOT_REQUIRED
;
; MessageText:
;
;  Device will not start without a reboot.
;
STATUS_PNP_REBOOT_REQUIRED	 = 0xC00002D2

;
; MessageId: STATUS_POWER_STATE_INVALID
;
; MessageText:
;
;  Current device power state cannot support this request.
;
STATUS_POWER_STATE_INVALID	 = 0xC00002D3

;
; MessageId: STATUS_DS_INVALID_GROUP_TYPE
;
; MessageText:
;
;  The specified group type is invalid.
;
STATUS_DS_INVALID_GROUP_TYPE	 = 0xC00002D4

;
; MessageId: STATUS_DS_NO_NEST_GLOBALGROUP_IN_MIXEDDOMAIN
;
; MessageText:
;
;  In mixed domain no nesting of global group if group is security enabled.
;
STATUS_DS_NO_NEST_GLOBALGROUP_IN_MIXEDDOMAIN = 0xC00002D5

;
; MessageId: STATUS_DS_NO_NEST_LOCALGROUP_IN_MIXEDDOMAIN
;
; MessageText:
;
;  In mixed domain, cannot nest local groups with other local groups, if the group is security enabled.
;
STATUS_DS_NO_NEST_LOCALGROUP_IN_MIXEDDOMAIN = 0xC00002D6

;
; MessageId: STATUS_DS_GLOBAL_CANT_HAVE_LOCAL_MEMBER
;
; MessageText:
;
;  A global group cannot have a local group as a member.
;
STATUS_DS_GLOBAL_CANT_HAVE_LOCAL_MEMBER = 0xC00002D7

;
; MessageId: STATUS_DS_GLOBAL_CANT_HAVE_UNIVERSAL_MEMBER
;
; MessageText:
;
;  A global group cannot have a universal group as a member.
;
STATUS_DS_GLOBAL_CANT_HAVE_UNIVERSAL_MEMBER = 0xC00002D8

;
; MessageId: STATUS_DS_UNIVERSAL_CANT_HAVE_LOCAL_MEMBER
;
; MessageText:
;
;  A universal group cannot have a local group as a member.
;
STATUS_DS_UNIVERSAL_CANT_HAVE_LOCAL_MEMBER = 0xC00002D9

;
; MessageId: STATUS_DS_GLOBAL_CANT_HAVE_CROSSDOMAIN_MEMBER
;
; MessageText:
;
;  A global group cannot have a cross domain member.
;
STATUS_DS_GLOBAL_CANT_HAVE_CROSSDOMAIN_MEMBER = 0xC00002DA

;
; MessageId: STATUS_DS_LOCAL_CANT_HAVE_CROSSDOMAIN_LOCAL_MEMBER
;
; MessageText:
;
;  A local group cannot have another cross domain local group as a member.
;
STATUS_DS_LOCAL_CANT_HAVE_CROSSDOMAIN_LOCAL_MEMBER = 0xC00002DB

;
; MessageId: STATUS_DS_HAVE_PRIMARY_MEMBERS
;
; MessageText:
;
;  Can not change to security disabled group because of having primary members in this group.
;
STATUS_DS_HAVE_PRIMARY_MEMBERS	 = 0xC00002DC

;
; MessageId: STATUS_WMI_NOT_SUPPORTED
;
; MessageText:
;
;  The WMI operation is not supported by the data block or method.
;
STATUS_WMI_NOT_SUPPORTED	 = 0xC00002DD

;
; MessageId: STATUS_INSUFFICIENT_POWER
;
; MessageText:
;
;  There is not enough power to complete the requested operation.
;
STATUS_INSUFFICIENT_POWER	 = 0xC00002DE

;
; MessageId: STATUS_SAM_NEED_BOOTKEY_PASSWORD
;
; MessageText:
;
;  Security Account Manager needs to get the boot password.
;
STATUS_SAM_NEED_BOOTKEY_PASSWORD = 0xC00002DF

;
; MessageId: STATUS_SAM_NEED_BOOTKEY_FLOPPY
;
; MessageText:
;
;  Security Account Manager needs to get the boot key from floppy disk.
;
STATUS_SAM_NEED_BOOTKEY_FLOPPY	 = 0xC00002E0

;
; MessageId: STATUS_DS_CANT_START
;
; MessageText:
;
;  Directory Service can not start.
;
STATUS_DS_CANT_START		 = 0xC00002E1

;
; MessageId: STATUS_DS_INIT_FAILURE
;
; MessageText:
;
;  Directory Services could not start because of the following error:
;  %hs
;  Error Status: = 0x%x.
;  Please click OK to shutdown this system and reboot into Directory Services Restore Mode, check the event log for more detailed information.
;
STATUS_DS_INIT_FAILURE		 = 0xC00002E2

;
; MessageId: STATUS_SAM_INIT_FAILURE
;
; MessageText:
;
;  Security Accounts Manager initialization failed because of the following error:
;  %hs
;  Error Status: = 0x%x.
;  Please click OK to shutdown this system and reboot into Safe Mode, check the event log for more detailed information.
;
STATUS_SAM_INIT_FAILURE 	 = 0xC00002E3

;
; MessageId: STATUS_DS_GC_REQUIRED
;
; MessageText:
;
;  The requested operation can be performed only on a global catalog server.
;
STATUS_DS_GC_REQUIRED		 = 0xC00002E4

;
; MessageId: STATUS_DS_LOCAL_MEMBER_OF_LOCAL_ONLY
;
; MessageText:
;
;  A local group can only be a member of other local groups in the same domain.
;
STATUS_DS_LOCAL_MEMBER_OF_LOCAL_ONLY = 0xC00002E5

;
; MessageId: STATUS_DS_NO_FPO_IN_UNIVERSAL_GROUPS
;
; MessageText:
;
;  Foreign security principals cannot be members of universal groups.
;
STATUS_DS_NO_FPO_IN_UNIVERSAL_GROUPS = 0xC00002E6

;
; MessageId: STATUS_DS_MACHINE_ACCOUNT_QUOTA_EXCEEDED
;
; MessageText:
;
;  Your computer could not be joined to the domain. You have exceeded the maximum number of computer accounts you are allowed to create in this domain. Contact your system administrator to have this limit reset or increased.
;
STATUS_DS_MACHINE_ACCOUNT_QUOTA_EXCEEDED = 0xC00002E7

;
; MessageId: STATUS_MULTIPLE_FAULT_VIOLATION
;
; MessageText:
;
;  STATUS_MULTIPLE_FAULT_VIOLATION
;
STATUS_MULTIPLE_FAULT_VIOLATION  = 0xC00002E8

;
; MessageId: STATUS_CURRENT_DOMAIN_NOT_ALLOWED
;
; MessageText:
;
;  This operation can not be performed on the current domain.
;
STATUS_CURRENT_DOMAIN_NOT_ALLOWED = 0xC00002E9

;
; MessageId: STATUS_CANNOT_MAKE
;
; MessageText:
;
;  The directory or file cannot be created.
;
STATUS_CANNOT_MAKE		 = 0xC00002EA

;
; MessageId: STATUS_SYSTEM_SHUTDOWN
;
; MessageText:
;
;  The system is in the process of shutting down.
;
STATUS_SYSTEM_SHUTDOWN		 = 0xC00002EB

;
; MessageId: STATUS_DS_INIT_FAILURE_CONSOLE
;
; MessageText:
;
;  Directory Services could not start because of the following error:
;  %hs
;  Error Status: = 0x%x.
;  Please click OK to shutdown the system. You can use the recovery console to diagnose the system further.
;
STATUS_DS_INIT_FAILURE_CONSOLE	 = 0xC00002EC

;
; MessageId: STATUS_DS_SAM_INIT_FAILURE_CONSOLE
;
; MessageText:
;
;  Security Accounts Manager initialization failed because of the following error:
;  %hs
;  Error Status: = 0x%x.
;  Please click OK to shutdown the system. You can use the recovery console to diagnose the system further.
;
STATUS_DS_SAM_INIT_FAILURE_CONSOLE = 0xC00002ED

;
; MessageId: STATUS_UNFINISHED_CONTEXT_DELETED
;
; MessageText:
;
;  A security context was deleted before the context was completed.  This is considered a logon failure.
;
STATUS_UNFINISHED_CONTEXT_DELETED = 0xC00002EE

;
; MessageId: STATUS_NO_TGT_REPLY
;
; MessageText:
;
;  The client is trying to negotiate a context and the server requires user-to-user but didn't send a TGT reply.
;
STATUS_NO_TGT_REPLY		 = 0xC00002EF

;
; MessageId: STATUS_OBJECTID_NOT_FOUND
;
; MessageText:
;
;  An object ID was not found in the file.
;
STATUS_OBJECTID_NOT_FOUND	 = 0xC00002F0

;
; MessageId: STATUS_NO_IP_ADDRESSES
;
; MessageText:
;
;  Unable to accomplish the requested task because the local machine does not have any IP addresses.
;
STATUS_NO_IP_ADDRESSES		 = 0xC00002F1

;
; MessageId: STATUS_WRONG_CREDENTIAL_HANDLE
;
; MessageText:
;
;  The supplied credential handle does not match the credential associated with the security context.
;
STATUS_WRONG_CREDENTIAL_HANDLE	 = 0xC00002F2

;
; MessageId: STATUS_CRYPTO_SYSTEM_INVALID
;
; MessageText:
;
;  The crypto system or checksum function is invalid because a required function is unavailable.
;
STATUS_CRYPTO_SYSTEM_INVALID	 = 0xC00002F3

;
; MessageId: STATUS_MAX_REFERRALS_EXCEEDED
;
; MessageText:
;
;  The number of maximum ticket referrals has been exceeded.
;
STATUS_MAX_REFERRALS_EXCEEDED	 = 0xC00002F4

;
; MessageId: STATUS_MUST_BE_KDC
;
; MessageText:
;
;  The local machine must be a Kerberos KDC (domain controller) and it is not.
;
STATUS_MUST_BE_KDC		 = 0xC00002F5

;
; MessageId: STATUS_STRONG_CRYPTO_NOT_SUPPORTED
;
; MessageText:
;
;  The other end of the security negotiation is requires strong crypto but it is not supported on the local machine.
;
STATUS_STRONG_CRYPTO_NOT_SUPPORTED = 0xC00002F6

;
; MessageId: STATUS_TOO_MANY_PRINCIPALS
;
; MessageText:
;
;  The KDC reply contained more than one principal name.
;
STATUS_TOO_MANY_PRINCIPALS	 = 0xC00002F7

;
; MessageId: STATUS_NO_PA_DATA
;
; MessageText:
;
;  Expected to find PA data for a hint of what etype to use, but it was not found.
;
STATUS_NO_PA_DATA		 = 0xC00002F8

;
; MessageId: STATUS_PKINIT_NAME_MISMATCH
;
; MessageText:
;
;  The client cert name does not matches the user name or the KDC name is incorrect.
;
STATUS_PKINIT_NAME_MISMATCH	 = 0xC00002F9

;
; MessageId: STATUS_SMARTCARD_LOGON_REQUIRED
;
; MessageText:
;
;  Smartcard logon is required and was not used.
;
STATUS_SMARTCARD_LOGON_REQUIRED  = 0xC00002FA

;
; MessageId: STATUS_KDC_INVALID_REQUEST
;
; MessageText:
;
;  An invalid request was sent to the KDC.
;
STATUS_KDC_INVALID_REQUEST	 = 0xC00002FB

;
; MessageId: STATUS_KDC_UNABLE_TO_REFER
;
; MessageText:
;
;  The KDC was unable to generate a referral for the service requested.
;
STATUS_KDC_UNABLE_TO_REFER	 = 0xC00002FC

;
; MessageId: STATUS_KDC_UNKNOWN_ETYPE
;
; MessageText:
;
;  The encryption type requested is not supported by the KDC.
;
STATUS_KDC_UNKNOWN_ETYPE	 = 0xC00002FD

;
; MessageId: STATUS_SHUTDOWN_IN_PROGRESS
;
; MessageText:
;
;  A system shutdown is in progress.
;
STATUS_SHUTDOWN_IN_PROGRESS	 = 0xC00002FE

;
; MessageId: STATUS_SERVER_SHUTDOWN_IN_PROGRESS
;
; MessageText:
;
;  The server machine is shutting down.
;
STATUS_SERVER_SHUTDOWN_IN_PROGRESS = 0xC00002FF

;
; MessageId: STATUS_NOT_SUPPORTED_ON_SBS
;
; MessageText:
;
;  This operation is not supported on a Microsoft Small Business Server
;
STATUS_NOT_SUPPORTED_ON_SBS	 = 0xC0000300

;
; MessageId: STATUS_WMI_GUID_DISCONNECTED
;
; MessageText:
;
;  The WMI GUID is no longer available
;
STATUS_WMI_GUID_DISCONNECTED	 = 0xC0000301

;
; MessageId: STATUS_WMI_ALREADY_DISABLED
;
; MessageText:
;
;  Collection or events for the WMI GUID is already disabled.
;
STATUS_WMI_ALREADY_DISABLED	 = 0xC0000302

;
; MessageId: STATUS_WMI_ALREADY_ENABLED
;
; MessageText:
;
;  Collection or events for the WMI GUID is already enabled.
;
STATUS_WMI_ALREADY_ENABLED	 = 0xC0000303

;
; MessageId: STATUS_MFT_TOO_FRAGMENTED
;
; MessageText:
;
;  The Master File Table on the volume is too fragmented to complete this operation.
;
STATUS_MFT_TOO_FRAGMENTED	 = 0xC0000304

;
; MessageId: STATUS_COPY_PROTECTION_FAILURE
;
; MessageText:
;
;  Copy protection failure.
;
STATUS_COPY_PROTECTION_FAILURE	 = 0xC0000305

;
; MessageId: STATUS_CSS_AUTHENTICATION_FAILURE
;
; MessageText:
;
;  Copy protection error - DVD CSS Authentication failed.
;
STATUS_CSS_AUTHENTICATION_FAILURE = 0xC0000306

;
; MessageId: STATUS_CSS_KEY_NOT_PRESENT
;
; MessageText:
;
;  Copy protection error - The given sector does not contain a valid key.
;
STATUS_CSS_KEY_NOT_PRESENT	 = 0xC0000307

;
; MessageId: STATUS_CSS_KEY_NOT_ESTABLISHED
;
; MessageText:
;
;  Copy protection error - DVD session key not established.
;
STATUS_CSS_KEY_NOT_ESTABLISHED	 = 0xC0000308

;
; MessageId: STATUS_CSS_SCRAMBLED_SECTOR
;
; MessageText:
;
;  Copy protection error - The read failed because the sector is encrypted.
;
STATUS_CSS_SCRAMBLED_SECTOR	 = 0xC0000309

;
; MessageId: STATUS_CSS_REGION_MISMATCH
;
; MessageText:
;
;  Copy protection error - The given DVD's region does not correspond to the
;  region setting of the drive.
;
STATUS_CSS_REGION_MISMATCH	 = 0xC000030A

;
; MessageId: STATUS_CSS_RESETS_EXHAUSTED
;
; MessageText:
;
;  Copy protection error - The drive's region setting may be permanent.
;
STATUS_CSS_RESETS_EXHAUSTED	 = 0xC000030B

;
; MessageId: STATUS_PKINIT_FAILURE
;
; MessageText:
;
;  The kerberos protocol encountered an error while validating the KDC certificate during smartcard Logon
;
STATUS_PKINIT_FAILURE		 = 0xC0000320

;
; MessageId: STATUS_SMARTCARD_SUBSYSTEM_FAILURE
;
; MessageText:
;
;  The kerberos protocol encountered an error while attempting to utilize the smartcard subsystem.
;
STATUS_SMARTCARD_SUBSYSTEM_FAILURE = 0xC0000321

;
; MessageId: STATUS_NO_KERB_KEY
;
; MessageText:
;
;  The target server does not have acceptable kerberos credentials.
;
STATUS_NO_KERB_KEY		 = 0xC0000322

;
; MessageId: STATUS_HOST_DOWN
;
; MessageText:
;
;  The transport determined that the remote system is down.
;
STATUS_HOST_DOWN		 = 0xC0000350

;
; MessageId: STATUS_UNSUPPORTED_PREAUTH
;
; MessageText:
;
;  An unsupported preauthentication mechanism was presented to the kerberos package.
;
STATUS_UNSUPPORTED_PREAUTH	 = 0xC0000351

;
; MessageId: STATUS_EFS_ALG_BLOB_TOO_BIG
;
; MessageText:
;
;  The encryption algorithm used on the source file needs a bigger key buffer than the one used on the destination file.
;
STATUS_EFS_ALG_BLOB_TOO_BIG	 = 0xC0000352

;
; MessageId: STATUS_PORT_NOT_SET
;
; MessageText:
;
;  An attempt to remove a processes DebugPort was made, but a port was not already associated with the process.
;
STATUS_PORT_NOT_SET		 = 0xC0000353

;
; MessageId: STATUS_DEBUGGER_INACTIVE
;
; MessageText:
;
;  An attempt to do an operation on a debug port failed because the port is in the process of being deleted.
;
STATUS_DEBUGGER_INACTIVE	 = 0xC0000354

;
; MessageId: STATUS_DS_VERSION_CHECK_FAILURE
;
; MessageText:
;
;  This version of Windows is not compatible with the behavior version of directory forest, domain or domain controller.
;
STATUS_DS_VERSION_CHECK_FAILURE  = 0xC0000355

;
; MessageId: STATUS_AUDITING_DISABLED
;
; MessageText:
;
;  The specified event is currently not being audited.
;
STATUS_AUDITING_DISABLED	 = 0xC0000356

;
; MessageId: STATUS_PRENT4_MACHINE_ACCOUNT
;
; MessageText:
;
;  The machine account was created pre-NT4.  The account needs to be recreated.
;
STATUS_PRENT4_MACHINE_ACCOUNT	 = 0xC0000357

;
; MessageId: STATUS_DS_AG_CANT_HAVE_UNIVERSAL_MEMBER
;
; MessageText:
;
;  A account group can not have a universal group as a member.
;
STATUS_DS_AG_CANT_HAVE_UNIVERSAL_MEMBER = 0xC0000358

;
; MessageId: STATUS_INVALID_IMAGE_WIN_32
;
; MessageText:
;
;  The specified image file did not have the correct format, it appears to be a 32-bit Windows image.
;
STATUS_INVALID_IMAGE_WIN_32	 = 0xC0000359

;
; MessageId: STATUS_INVALID_IMAGE_WIN_64
;
; MessageText:
;
;  The specified image file did not have the correct format, it appears to be a 64-bit Windows image.
;
STATUS_INVALID_IMAGE_WIN_64	 = 0xC000035A

;
; MessageId: STATUS_BAD_BINDINGS
;
; MessageText:
;
;  Client's supplied SSPI channel bindings were incorrect.
;
STATUS_BAD_BINDINGS		 = 0xC000035B

;
; MessageId: STATUS_NETWORK_SESSION_EXPIRED
;
; MessageText:
;
;  The client's session has expired, so the client must reauthenticate to continue accessing the remote resources.
;
STATUS_NETWORK_SESSION_EXPIRED	 = 0xC000035C

;
; MessageId: STATUS_APPHELP_BLOCK
;
; MessageText:
;
;  AppHelp dialog canceled thus preventing the application from starting.
;
STATUS_APPHELP_BLOCK		 = 0xC000035D

;
; MessageId: STATUS_ALL_SIDS_FILTERED
;
; MessageText:
;
;  The SID filtering operation removed all SIDs.
;
STATUS_ALL_SIDS_FILTERED	 = 0xC000035E

;
; MessageId: STATUS_NOT_SAFE_MODE_DRIVER
;
; MessageText:
;
;  The driver was not loaded because the system is booting into safe mode.
;
STATUS_NOT_SAFE_MODE_DRIVER	 = 0xC000035F

;
; MessageId: STATUS_ACCESS_DISABLED_BY_POLICY_DEFAULT
;
; MessageText:
;
;  Access to %1 has been restricted by your Administrator by the default software restriction policy level.
;
STATUS_ACCESS_DISABLED_BY_POLICY_DEFAULT = 0xC0000361

;
; MessageId: STATUS_ACCESS_DISABLED_BY_POLICY_PATH
;
; MessageText:
;
;  Access to %1 has been restricted by your Administrator by location with policy rule %2 placed on path %3
;
STATUS_ACCESS_DISABLED_BY_POLICY_PATH = 0xC0000362

;
; MessageId: STATUS_ACCESS_DISABLED_BY_POLICY_PUBLISHER
;
; MessageText:
;
;  Access to %1 has been restricted by your Administrator by software publisher policy.
;
STATUS_ACCESS_DISABLED_BY_POLICY_PUBLISHER = 0xC0000363

;
; MessageId: STATUS_ACCESS_DISABLED_BY_POLICY_OTHER
;
; MessageText:
;
;  Access to %1 has been restricted by your Administrator by policy rule %2.
;
STATUS_ACCESS_DISABLED_BY_POLICY_OTHER = 0xC0000364

;
; MessageId: STATUS_FAILED_DRIVER_ENTRY
;
; MessageText:
;
;  The driver was not loaded because it failed it's initialization call.
;
STATUS_FAILED_DRIVER_ENTRY	 = 0xC0000365

;
; MessageId: STATUS_DEVICE_ENUMERATION_ERROR
;
; MessageText:
;
;  The "%hs" encountered an error while applying power or reading the device configuration.
;  This may be caused by a failure of your hardware or by a poor connection.
;
STATUS_DEVICE_ENUMERATION_ERROR  = 0xC0000366

;
; MessageId: STATUS_WAIT_FOR_OPLOCK
;
; MessageText:
;
;  An operation is blocked waiting for an oplock.
;
STATUS_WAIT_FOR_OPLOCK		 = 0x00000367

;
; MessageId: STATUS_MOUNT_POINT_NOT_RESOLVED
;
; MessageText:
;
;  The create operation failed because the name contained at least one mount point which resolves to a volume to which the specified device object is not attached.
;
STATUS_MOUNT_POINT_NOT_RESOLVED  = 0xC0000368

;
; MessageId: STATUS_INVALID_DEVICE_OBJECT_PARAMETER
;
; MessageText:
;
;  The device object parameter is either not a valid device object or is not attached to the volume specified by the file name.
;
STATUS_INVALID_DEVICE_OBJECT_PARAMETER = 0xC0000369

;
; MessageId: STATUS_MCA_OCCURED
;
; MessageText:
;
;  A Machine Check Error has occured. Please check the system eventlog for additional information.
;
STATUS_MCA_OCCURED		 = 0xC000036A

;
; MessageId: STATUS_DRIVER_BLOCKED_CRITICAL
;
; MessageText:
;
;  Driver %2 has been blocked from loading.
;
STATUS_DRIVER_BLOCKED_CRITICAL	 = 0xC000036B

;
; MessageId: STATUS_DRIVER_BLOCKED
;
; MessageText:
;
;  Driver %2 has been blocked from loading.
;
STATUS_DRIVER_BLOCKED		 = 0xC000036C

;
; MessageId: STATUS_DRIVER_DATABASE_ERROR
;
; MessageText:
;
;  There was error [%2] processing the driver database.
;
STATUS_DRIVER_DATABASE_ERROR	 = 0xC000036D

;
; MessageId: STATUS_SYSTEM_HIVE_TOO_LARGE
;
; MessageText:
;
;  System hive size has exceeded its limit.
;
STATUS_SYSTEM_HIVE_TOO_LARGE	 = 0xC000036E

;
; MessageId: STATUS_INVALID_IMPORT_OF_NON_DLL
;
; MessageText:
;
;  A dynamic link library (DL referenced a module that was neither a DLL nor the process's executable image.
;
STATUS_INVALID_IMPORT_OF_NON_DLL = 0xC000036F

;
; MessageId: STATUS_DS_SHUTTING_DOWN
;
; MessageText:
;
;  The Directory Service is shuting down.
;
STATUS_DS_SHUTTING_DOWN 	 = 0x40000370

;
; MessageId: STATUS_SMARTCARD_WRONG_PIN
;
; MessageText:
;
;  An incorrect PIN was presented to the smart card
;
STATUS_SMARTCARD_WRONG_PIN	 = 0xC0000380

;
; MessageId: STATUS_SMARTCARD_CARD_BLOCKED
;
; MessageText:
;
;  The smart card is blocked
;
STATUS_SMARTCARD_CARD_BLOCKED	 = 0xC0000381

;
; MessageId: STATUS_SMARTCARD_CARD_NOT_AUTHENTICATED
;
; MessageText:
;
;  No PIN was presented to the smart card
;
STATUS_SMARTCARD_CARD_NOT_AUTHENTICATED = 0xC0000382

;
; MessageId: STATUS_SMARTCARD_NO_CARD
;
; MessageText:
;
;  No smart card available
;
STATUS_SMARTCARD_NO_CARD	 = 0xC0000383

;
; MessageId: STATUS_SMARTCARD_NO_KEY_CONTAINER
;
; MessageText:
;
;  The requested key container does not exist on the smart card
;
STATUS_SMARTCARD_NO_KEY_CONTAINER = 0xC0000384

;
; MessageId: STATUS_SMARTCARD_NO_CERTIFICATE
;
; MessageText:
;
;  The requested certificate does not exist on the smart card
;
STATUS_SMARTCARD_NO_CERTIFICATE  = 0xC0000385

;
; MessageId: STATUS_SMARTCARD_NO_KEYSET
;
; MessageText:
;
;  The requested keyset does not exist
;
STATUS_SMARTCARD_NO_KEYSET	 = 0xC0000386

;
; MessageId: STATUS_SMARTCARD_IO_ERROR
;
; MessageText:
;
;  A communication error with the smart card has been detected.
;
STATUS_SMARTCARD_IO_ERROR	 = 0xC0000387

;
; MessageId: STATUS_DOWNGRADE_DETECTED
;
; MessageText:
;
;  The system detected a possible attempt to compromise security. Please ensure that you can contact the server that authenticated you.
;
STATUS_DOWNGRADE_DETECTED	 = 0xC0000388

;
; MessageId: STATUS_SMARTCARD_CERT_REVOKED
;
; MessageText:
;
;  The smartcard certificate used for authentication has been revoked.
;  Please contact your system administrator.  There may be additional information in the
;  event log.
;
STATUS_SMARTCARD_CERT_REVOKED	 = 0xC0000389

;
; MessageId: STATUS_ISSUING_CA_UNTRUSTED
;
; MessageText:
;
;  An untrusted certificate authority was detected While processing the
;  smartcard certificate used for authentication.  Please contact your system
;  administrator.
;
STATUS_ISSUING_CA_UNTRUSTED	 = 0xC000038A

;
; MessageId: STATUS_REVOCATION_OFFLINE_C
;
; MessageText:
;
;  The revocation status of the smartcard certificate used for
;  authentication could not be determined. Please contact your system administrator.
;
STATUS_REVOCATION_OFFLINE_C	 = 0xC000038B

;
; MessageId: STATUS_PKINIT_CLIENT_FAILURE
;
; MessageText:
;
;  The smartcard certificate used for authentication was not trusted.  Please
;  contact your system administrator.
;
STATUS_PKINIT_CLIENT_FAILURE	 = 0xC000038C

;
; MessageId: STATUS_SMARTCARD_CERT_EXPIRED
;
; MessageText:
;
;  The smartcard certificate used for authentication has expired.  Please
;  contact your system administrator.
;
STATUS_SMARTCARD_CERT_EXPIRED	 = 0xC000038D

;
; MessageId: STATUS_DRIVER_FAILED_PRIOR_UNLOAD
;
; MessageText:
;
;  The driver could not be loaded because a previous version of the driver is still in memory.
;
STATUS_DRIVER_FAILED_PRIOR_UNLOAD = 0xC000038E

;
; MessageId: STATUS_WOW_ASSERTION
;
; MessageText:
;
;  WOW Assertion Error.
;
STATUS_WOW_ASSERTION		 = 0xC0009898

;
; MessageId: DBG_NO_STATE_CHANGE
;
; MessageText:
;
;  Debugger did not perform a state change.
;
DBG_NO_STATE_CHANGE		 = 0xC0010001

;
; MessageId: DBG_APP_NOT_IDLE
;
; MessageText:
;
;  Debugger has found the application is not idle.
;
DBG_APP_NOT_IDLE		 = 0xC0010002

;
; MessageId: RPC_NT_INVALID_STRING_BINDING
;
; MessageText:
;
;  The string binding is invalid.
;
RPC_NT_INVALID_STRING_BINDING	 = 0xC0020001

;
; MessageId: RPC_NT_WRONG_KIND_OF_BINDING
;
; MessageText:
;
;  The binding handle is not the correct type.
;
RPC_NT_WRONG_KIND_OF_BINDING	 = 0xC0020002

;
; MessageId: RPC_NT_INVALID_BINDING
;
; MessageText:
;
;  The binding handle is invalid.
;
RPC_NT_INVALID_BINDING		 = 0xC0020003

;
; MessageId: RPC_NT_PROTSEQ_NOT_SUPPORTED
;
; MessageText:
;
;  The RPC protocol sequence is not supported.
;
RPC_NT_PROTSEQ_NOT_SUPPORTED	 = 0xC0020004

;
; MessageId: RPC_NT_INVALID_RPC_PROTSEQ
;
; MessageText:
;
;  The RPC protocol sequence is invalid.
;
RPC_NT_INVALID_RPC_PROTSEQ	 = 0xC0020005

;
; MessageId: RPC_NT_INVALID_STRING_UUID
;
; MessageText:
;
;  The string UUID is invalid.
;
RPC_NT_INVALID_STRING_UUID	 = 0xC0020006

;
; MessageId: RPC_NT_INVALID_ENDPOINT_FORMAT
;
; MessageText:
;
;  The endpoint format is invalid.
;
RPC_NT_INVALID_ENDPOINT_FORMAT	 = 0xC0020007

;
; MessageId: RPC_NT_INVALID_NET_ADDR
;
; MessageText:
;
;  The network address is invalid.
;
RPC_NT_INVALID_NET_ADDR 	 = 0xC0020008

;
; MessageId: RPC_NT_NO_ENDPOINT_FOUND
;
; MessageText:
;
;  No endpoint was found.
;
RPC_NT_NO_ENDPOINT_FOUND	 = 0xC0020009

;
; MessageId: RPC_NT_INVALID_TIMEOUT
;
; MessageText:
;
;  The timeout value is invalid.
;
RPC_NT_INVALID_TIMEOUT		 = 0xC002000A

;
; MessageId: RPC_NT_OBJECT_NOT_FOUND
;
; MessageText:
;
;  The object UUID was not found.
;
RPC_NT_OBJECT_NOT_FOUND 	 = 0xC002000B

;
; MessageId: RPC_NT_ALREADY_REGISTERED
;
; MessageText:
;
;  The object UUID has already been registered.
;
RPC_NT_ALREADY_REGISTERED	 = 0xC002000C

;
; MessageId: RPC_NT_TYPE_ALREADY_REGISTERED
;
; MessageText:
;
;  The type UUID has already been registered.
;
RPC_NT_TYPE_ALREADY_REGISTERED	 = 0xC002000D

;
; MessageId: RPC_NT_ALREADY_LISTENING
;
; MessageText:
;
;  The RPC server is already listening.
;
RPC_NT_ALREADY_LISTENING	 = 0xC002000E

;
; MessageId: RPC_NT_NO_PROTSEQS_REGISTERED
;
; MessageText:
;
;  No protocol sequences have been registered.
;
RPC_NT_NO_PROTSEQS_REGISTERED	 = 0xC002000F

;
; MessageId: RPC_NT_NOT_LISTENING
;
; MessageText:
;
;  The RPC server is not listening.
;
RPC_NT_NOT_LISTENING		 = 0xC0020010

;
; MessageId: RPC_NT_UNKNOWN_MGR_TYPE
;
; MessageText:
;
;  The manager type is unknown.
;
RPC_NT_UNKNOWN_MGR_TYPE 	 = 0xC0020011

;
; MessageId: RPC_NT_UNKNOWN_IF
;
; MessageText:
;
;  The interface is unknown.
;
RPC_NT_UNKNOWN_IF		 = 0xC0020012

;
; MessageId: RPC_NT_NO_BINDINGS
;
; MessageText:
;
;  There are no bindings.
;
RPC_NT_NO_BINDINGS		 = 0xC0020013

;
; MessageId: RPC_NT_NO_PROTSEQS
;
; MessageText:
;
;  There are no protocol sequences.
;
RPC_NT_NO_PROTSEQS		 = 0xC0020014

;
; MessageId: RPC_NT_CANT_CREATE_ENDPOINT
;
; MessageText:
;
;  The endpoint cannot be created.
;
RPC_NT_CANT_CREATE_ENDPOINT	 = 0xC0020015

;
; MessageId: RPC_NT_OUT_OF_RESOURCES
;
; MessageText:
;
;  Not enough resources are available to complete this operation.
;
RPC_NT_OUT_OF_RESOURCES 	 = 0xC0020016

;
; MessageId: RPC_NT_SERVER_UNAVAILABLE
;
; MessageText:
;
;  The RPC server is unavailable.
;
RPC_NT_SERVER_UNAVAILABLE	 = 0xC0020017

;
; MessageId: RPC_NT_SERVER_TOO_BUSY
;
; MessageText:
;
;  The RPC server is too busy to complete this operation.
;
RPC_NT_SERVER_TOO_BUSY		 = 0xC0020018

;
; MessageId: RPC_NT_INVALID_NETWORK_OPTIONS
;
; MessageText:
;
;  The network options are invalid.
;
RPC_NT_INVALID_NETWORK_OPTIONS	 = 0xC0020019

;
; MessageId: RPC_NT_NO_CALL_ACTIVE
;
; MessageText:
;
;  There are no remote procedure calls active on this thread.
;
RPC_NT_NO_CALL_ACTIVE		 = 0xC002001A

;
; MessageId: RPC_NT_CALL_FAILED
;
; MessageText:
;
;  The remote procedure call failed.
;
RPC_NT_CALL_FAILED		 = 0xC002001B

;
; MessageId: RPC_NT_CALL_FAILED_DNE
;
; MessageText:
;
;  The remote procedure call failed and did not execute.
;
RPC_NT_CALL_FAILED_DNE		 = 0xC002001C

;
; MessageId: RPC_NT_PROTOCOL_ERROR
;
; MessageText:
;
;  An RPC protocol error occurred.
;
RPC_NT_PROTOCOL_ERROR		 = 0xC002001D

;
; MessageId: RPC_NT_UNSUPPORTED_TRANS_SYN
;
; MessageText:
;
;  The transfer syntax is not supported by the RPC server.
;
RPC_NT_UNSUPPORTED_TRANS_SYN	 = 0xC002001F

;
; MessageId: RPC_NT_UNSUPPORTED_TYPE
;
; MessageText:
;
;  The type UUID is not supported.
;
RPC_NT_UNSUPPORTED_TYPE 	 = 0xC0020021

;
; MessageId: RPC_NT_INVALID_TAG
;
; MessageText:
;
;  The tag is invalid.
;
RPC_NT_INVALID_TAG		 = 0xC0020022

;
; MessageId: RPC_NT_INVALID_BOUND
;
; MessageText:
;
;  The array bounds are invalid.
;
RPC_NT_INVALID_BOUND		 = 0xC0020023

;
; MessageId: RPC_NT_NO_ENTRY_NAME
;
; MessageText:
;
;  The binding does not contain an entry name.
;
RPC_NT_NO_ENTRY_NAME		 = 0xC0020024

;
; MessageId: RPC_NT_INVALID_NAME_SYNTAX
;
; MessageText:
;
;  The name syntax is invalid.
;
RPC_NT_INVALID_NAME_SYNTAX	 = 0xC0020025

;
; MessageId: RPC_NT_UNSUPPORTED_NAME_SYNTAX
;
; MessageText:
;
;  The name syntax is not supported.
;
RPC_NT_UNSUPPORTED_NAME_SYNTAX	 = 0xC0020026

;
; MessageId: RPC_NT_UUID_NO_ADDRESS
;
; MessageText:
;
;  No network address is available to use to construct a UUID.
;
RPC_NT_UUID_NO_ADDRESS		 = 0xC0020028

;
; MessageId: RPC_NT_DUPLICATE_ENDPOINT
;
; MessageText:
;
;  The endpoint is a duplicate.
;
RPC_NT_DUPLICATE_ENDPOINT	 = 0xC0020029

;
; MessageId: RPC_NT_UNKNOWN_AUTHN_TYPE
;
; MessageText:
;
;  The authentication type is unknown.
;
RPC_NT_UNKNOWN_AUTHN_TYPE	 = 0xC002002A

;
; MessageId: RPC_NT_MAX_CALLS_TOO_SMALL
;
; MessageText:
;
;  The maximum number of calls is too small.
;
RPC_NT_MAX_CALLS_TOO_SMALL	 = 0xC002002B

;
; MessageId: RPC_NT_STRING_TOO_LONG
;
; MessageText:
;
;  The string is too long.
;
RPC_NT_STRING_TOO_LONG		 = 0xC002002C

;
; MessageId: RPC_NT_PROTSEQ_NOT_FOUND
;
; MessageText:
;
;  The RPC protocol sequence was not found.
;
RPC_NT_PROTSEQ_NOT_FOUND	 = 0xC002002D

;
; MessageId: RPC_NT_PROCNUM_OUT_OF_RANGE
;
; MessageText:
;
;  The procedure number is out of range.
;
RPC_NT_PROCNUM_OUT_OF_RANGE	 = 0xC002002E

;
; MessageId: RPC_NT_BINDING_HAS_NO_AUTH
;
; MessageText:
;
;  The binding does not contain any authentication information.
;
RPC_NT_BINDING_HAS_NO_AUTH	 = 0xC002002F

;
; MessageId: RPC_NT_UNKNOWN_AUTHN_SERVICE
;
; MessageText:
;
;  The authentication service is unknown.
;
RPC_NT_UNKNOWN_AUTHN_SERVICE	 = 0xC0020030

;
; MessageId: RPC_NT_UNKNOWN_AUTHN_LEVEL
;
; MessageText:
;
;  The authentication level is unknown.
;
RPC_NT_UNKNOWN_AUTHN_LEVEL	 = 0xC0020031

;
; MessageId: RPC_NT_INVALID_AUTH_IDENTITY
;
; MessageText:
;
;  The security context is invalid.
;
RPC_NT_INVALID_AUTH_IDENTITY	 = 0xC0020032

;
; MessageId: RPC_NT_UNKNOWN_AUTHZ_SERVICE
;
; MessageText:
;
;  The authorization service is unknown.
;
RPC_NT_UNKNOWN_AUTHZ_SERVICE	 = 0xC0020033

;
; MessageId: EPT_NT_INVALID_ENTRY
;
; MessageText:
;
;  The entry is invalid.
;
EPT_NT_INVALID_ENTRY		 = 0xC0020034

;
; MessageId: EPT_NT_CANT_PERFORM_OP
;
; MessageText:
;
;  The operation cannot be performed.
;
EPT_NT_CANT_PERFORM_OP		 = 0xC0020035

;
; MessageId: EPT_NT_NOT_REGISTERED
;
; MessageText:
;
;  There are no more endpoints available from the endpoint mapper.
;
EPT_NT_NOT_REGISTERED		 = 0xC0020036

;
; MessageId: RPC_NT_NOTHING_TO_EXPORT
;
; MessageText:
;
;  No interfaces have been exported.
;
RPC_NT_NOTHING_TO_EXPORT	 = 0xC0020037

;
; MessageId: RPC_NT_INCOMPLETE_NAME
;
; MessageText:
;
;  The entry name is incomplete.
;
RPC_NT_INCOMPLETE_NAME		 = 0xC0020038

;
; MessageId: RPC_NT_INVALID_VERS_OPTION
;
; MessageText:
;
;  The version option is invalid.
;
RPC_NT_INVALID_VERS_OPTION	 = 0xC0020039

;
; MessageId: RPC_NT_NO_MORE_MEMBERS
;
; MessageText:
;
;  There are no more members.
;
RPC_NT_NO_MORE_MEMBERS		 = 0xC002003A

;
; MessageId: RPC_NT_NOT_ALL_OBJS_UNEXPORTED
;
; MessageText:
;
;  There is nothing to unexport.
;
RPC_NT_NOT_ALL_OBJS_UNEXPORTED	 = 0xC002003B

;
; MessageId: RPC_NT_INTERFACE_NOT_FOUND
;
; MessageText:
;
;  The interface was not found.
;
RPC_NT_INTERFACE_NOT_FOUND	 = 0xC002003C

;
; MessageId: RPC_NT_ENTRY_ALREADY_EXISTS
;
; MessageText:
;
;  The entry already exists.
;
RPC_NT_ENTRY_ALREADY_EXISTS	 = 0xC002003D

;
; MessageId: RPC_NT_ENTRY_NOT_FOUND
;
; MessageText:
;
;  The entry is not found.
;
RPC_NT_ENTRY_NOT_FOUND		 = 0xC002003E

;
; MessageId: RPC_NT_NAME_SERVICE_UNAVAILABLE
;
; MessageText:
;
;  The name service is unavailable.
;
RPC_NT_NAME_SERVICE_UNAVAILABLE  = 0xC002003F

;
; MessageId: RPC_NT_INVALID_NAF_ID
;
; MessageText:
;
;  The network address family is invalid.
;
RPC_NT_INVALID_NAF_ID		 = 0xC0020040

;
; MessageId: RPC_NT_CANNOT_SUPPORT
;
; MessageText:
;
;  The requested operation is not supported.
;
RPC_NT_CANNOT_SUPPORT		 = 0xC0020041

;
; MessageId: RPC_NT_NO_CONTEXT_AVAILABLE
;
; MessageText:
;
;  No security context is available to allow impersonation.
;
RPC_NT_NO_CONTEXT_AVAILABLE	 = 0xC0020042

;
; MessageId: RPC_NT_INTERNAL_ERROR
;
; MessageText:
;
;  An internal error occurred in RPC.
;
RPC_NT_INTERNAL_ERROR		 = 0xC0020043

;
; MessageId: RPC_NT_ZERO_DIVIDE
;
; MessageText:
;
;  The RPC server attempted an integer divide by zero.
;
RPC_NT_ZERO_DIVIDE		 = 0xC0020044

;
; MessageId: RPC_NT_ADDRESS_ERROR
;
; MessageText:
;
;  An addressing error occurred in the RPC server.
;
RPC_NT_ADDRESS_ERROR		 = 0xC0020045

;
; MessageId: RPC_NT_FP_DIV_ZERO
;
; MessageText:
;
;  A floating point operation at the RPC server caused a divide by zero.
;
RPC_NT_FP_DIV_ZERO		 = 0xC0020046

;
; MessageId: RPC_NT_FP_UNDERFLOW
;
; MessageText:
;
;  A floating point underflow occurred at the RPC server.
;
RPC_NT_FP_UNDERFLOW		 = 0xC0020047

;
; MessageId: RPC_NT_FP_OVERFLOW
;
; MessageText:
;
;  A floating point overflow occurred at the RPC server.
;
RPC_NT_FP_OVERFLOW		 = 0xC0020048

;
; MessageId: RPC_NT_NO_MORE_ENTRIES
;
; MessageText:
;
;  The list of RPC servers available for auto-handle binding has been exhausted.
;
RPC_NT_NO_MORE_ENTRIES		 = 0xC0030001

;
; MessageId: RPC_NT_SS_CHAR_TRANS_OPEN_FAIL
;
; MessageText:
;
;  The file designated by DCERPCCHARTRANS cannot be opened.
;
RPC_NT_SS_CHAR_TRANS_OPEN_FAIL	 = 0xC0030002

;
; MessageId: RPC_NT_SS_CHAR_TRANS_SHORT_FILE
;
; MessageText:
;
;  The file containing the character translation table has fewer than 512 bytes.
;
RPC_NT_SS_CHAR_TRANS_SHORT_FILE  = 0xC0030003

;
; MessageId: RPC_NT_SS_IN_NULL_CONTEXT
;
; MessageText:
;
;  A null context handle is passed as an [in] parameter.
;
RPC_NT_SS_IN_NULL_CONTEXT	 = 0xC0030004

;
; MessageId: RPC_NT_SS_CONTEXT_MISMATCH
;
; MessageText:
;
;  The context handle does not match any known context handles.
;
RPC_NT_SS_CONTEXT_MISMATCH	 = 0xC0030005

;
; MessageId: RPC_NT_SS_CONTEXT_DAMAGED
;
; MessageText:
;
;  The context handle changed during a call.
;
RPC_NT_SS_CONTEXT_DAMAGED	 = 0xC0030006

;
; MessageId: RPC_NT_SS_HANDLES_MISMATCH
;
; MessageText:
;
;  The binding handles passed to a remote procedure call do not match.
;
RPC_NT_SS_HANDLES_MISMATCH	 = 0xC0030007

;
; MessageId: RPC_NT_SS_CANNOT_GET_CALL_HANDLE
;
; MessageText:
;
;  The stub is unable to get the call handle.
;
RPC_NT_SS_CANNOT_GET_CALL_HANDLE = 0xC0030008

;
; MessageId: RPC_NT_NULL_REF_POINTER
;
; MessageText:
;
;  A null reference pointer was passed to the stub.
;
RPC_NT_NULL_REF_POINTER 	 = 0xC0030009

;
; MessageId: RPC_NT_ENUM_VALUE_OUT_OF_RANGE
;
; MessageText:
;
;  The enumeration value is out of range.
;
RPC_NT_ENUM_VALUE_OUT_OF_RANGE	 = 0xC003000A

;
; MessageId: RPC_NT_BYTE_COUNT_TOO_SMALL
;
; MessageText:
;
;  The byte count is too small.
;
RPC_NT_BYTE_COUNT_TOO_SMALL	 = 0xC003000B

;
; MessageId: RPC_NT_BAD_STUB_DATA
;
; MessageText:
;
;  The stub received bad data.
;
RPC_NT_BAD_STUB_DATA		 = 0xC003000C

;
; MessageId: RPC_NT_CALL_IN_PROGRESS
;
; MessageText:
;
;  A remote procedure call is already in progress for this thread.
;
RPC_NT_CALL_IN_PROGRESS 	 = 0xC0020049

;
; MessageId: RPC_NT_NO_MORE_BINDINGS
;
; MessageText:
;
;  There are no more bindings.
;
RPC_NT_NO_MORE_BINDINGS 	 = 0xC002004A

;
; MessageId: RPC_NT_GROUP_MEMBER_NOT_FOUND
;
; MessageText:
;
;  The group member was not found.
;
RPC_NT_GROUP_MEMBER_NOT_FOUND	 = 0xC002004B

;
; MessageId: EPT_NT_CANT_CREATE
;
; MessageText:
;
;  The endpoint mapper database entry could not be created.
;
EPT_NT_CANT_CREATE		 = 0xC002004C

;
; MessageId: RPC_NT_INVALID_OBJECT
;
; MessageText:
;
;  The object UUID is the nil UUID.
;
RPC_NT_INVALID_OBJECT		 = 0xC002004D

;
; MessageId: RPC_NT_NO_INTERFACES
;
; MessageText:
;
;  No interfaces have been registered.
;
RPC_NT_NO_INTERFACES		 = 0xC002004F

;
; MessageId: RPC_NT_CALL_CANCELLED
;
; MessageText:
;
;  The remote procedure call was cancelled.
;
RPC_NT_CALL_CANCELLED		 = 0xC0020050

;
; MessageId: RPC_NT_BINDING_INCOMPLETE
;
; MessageText:
;
;  The binding handle does not contain all required information.
;
RPC_NT_BINDING_INCOMPLETE	 = 0xC0020051

;
; MessageId: RPC_NT_COMM_FAILURE
;
; MessageText:
;
;  A communications failure occurred during a remote procedure call.
;
RPC_NT_COMM_FAILURE		 = 0xC0020052

;
; MessageId: RPC_NT_UNSUPPORTED_AUTHN_LEVEL
;
; MessageText:
;
;  The requested authentication level is not supported.
;
RPC_NT_UNSUPPORTED_AUTHN_LEVEL	 = 0xC0020053

;
; MessageId: RPC_NT_NO_PRINC_NAME
;
; MessageText:
;
;  No principal name registered.
;
RPC_NT_NO_PRINC_NAME		 = 0xC0020054

;
; MessageId: RPC_NT_NOT_RPC_ERROR
;
; MessageText:
;
;  The error specified is not a valid Windows RPC error code.
;
RPC_NT_NOT_RPC_ERROR		 = 0xC0020055

;
; MessageId: RPC_NT_UUID_LOCAL_ONLY
;
; MessageText:
;
;  A UUID that is valid only on this computer has been allocated.
;
RPC_NT_UUID_LOCAL_ONLY		 = 0x40020056

;
; MessageId: RPC_NT_SEC_PKG_ERROR
;
; MessageText:
;
;  A security package specific error occurred.
;
RPC_NT_SEC_PKG_ERROR		 = 0xC0020057

;
; MessageId: RPC_NT_NOT_CANCELLED
;
; MessageText:
;
;  Thread is not cancelled.
;
RPC_NT_NOT_CANCELLED		 = 0xC0020058

;
; MessageId: RPC_NT_INVALID_ES_ACTION
;
; MessageText:
;
;  Invalid operation on the encoding/decoding handle.
;
RPC_NT_INVALID_ES_ACTION	 = 0xC0030059

;
; MessageId: RPC_NT_WRONG_ES_VERSION
;
; MessageText:
;
;  Incompatible version of the serializing package.
;
RPC_NT_WRONG_ES_VERSION 	 = 0xC003005A

;
; MessageId: RPC_NT_WRONG_STUB_VERSION
;
; MessageText:
;
;  Incompatible version of the RPC stub.
;
RPC_NT_WRONG_STUB_VERSION	 = 0xC003005B

;
; MessageId: RPC_NT_INVALID_PIPE_OBJECT
;
; MessageText:
;
;  The RPC pipe object is invalid or corrupted.
;
RPC_NT_INVALID_PIPE_OBJECT	 = 0xC003005C

;
; MessageId: RPC_NT_INVALID_PIPE_OPERATION
;
; MessageText:
;
;  An invalid operation was attempted on an RPC pipe object.
;
RPC_NT_INVALID_PIPE_OPERATION	 = 0xC003005D

;
; MessageId: RPC_NT_WRONG_PIPE_VERSION
;
; MessageText:
;
;  Unsupported RPC pipe version.
;
RPC_NT_WRONG_PIPE_VERSION	 = 0xC003005E

;
; MessageId: RPC_NT_PIPE_CLOSED
;
; MessageText:
;
;  The RPC pipe object has already been closed.
;
RPC_NT_PIPE_CLOSED		 = 0xC003005F

;
; MessageId: RPC_NT_PIPE_DISCIPLINE_ERROR
;
; MessageText:
;
;  The RPC call completed before all pipes were processed.
;
RPC_NT_PIPE_DISCIPLINE_ERROR	 = 0xC0030060

;
; MessageId: RPC_NT_PIPE_EMPTY
;
; MessageText:
;
;  No more data is available from the RPC pipe.
;
RPC_NT_PIPE_EMPTY		 = 0xC0030061

;
; MessageId: RPC_NT_INVALID_ASYNC_HANDLE
;
; MessageText:
;
;  Invalid asynchronous remote procedure call handle.
;
RPC_NT_INVALID_ASYNC_HANDLE	 = 0xC0020062

;
; MessageId: RPC_NT_INVALID_ASYNC_CALL
;
; MessageText:
;
;  Invalid asynchronous RPC call handle for this operation.
;
RPC_NT_INVALID_ASYNC_CALL	 = 0xC0020063

;
; MessageId: RPC_NT_SEND_INCOMPLETE
;
; MessageText:
;
;  Some data remains to be sent in the request buffer.
;
RPC_NT_SEND_INCOMPLETE		 = 0x400200AF

;
; MessageId: STATUS_ACPI_INVALID_OPCODE
;
; MessageText:
;
;  An attempt was made to run an invalid AML opcode
;
STATUS_ACPI_INVALID_OPCODE	 = 0xC0140001

;
; MessageId: STATUS_ACPI_STACK_OVERFLOW
;
; MessageText:
;
;  The AML Interpreter Stack has overflowed
;
STATUS_ACPI_STACK_OVERFLOW	 = 0xC0140002

;
; MessageId: STATUS_ACPI_ASSERT_FAILED
;
; MessageText:
;
;  An inconsistent state has occurred
;
STATUS_ACPI_ASSERT_FAILED	 = 0xC0140003

;
; MessageId: STATUS_ACPI_INVALID_INDEX
;
; MessageText:
;
;  An attempt was made to access an array outside of its bounds
;
STATUS_ACPI_INVALID_INDEX	 = 0xC0140004

;
; MessageId: STATUS_ACPI_INVALID_ARGUMENT
;
; MessageText:
;
;  A required argument was not specified
;
STATUS_ACPI_INVALID_ARGUMENT	 = 0xC0140005

;
; MessageId: STATUS_ACPI_FATAL
;
; MessageText:
;
;  A fatal error has occurred
;
STATUS_ACPI_FATAL		 = 0xC0140006

;
; MessageId: STATUS_ACPI_INVALID_SUPERNAME
;
; MessageText:
;
;  An invalid SuperName was specified
;
STATUS_ACPI_INVALID_SUPERNAME	 = 0xC0140007

;
; MessageId: STATUS_ACPI_INVALID_ARGTYPE
;
; MessageText:
;
;  An argument with an incorrect type was specified
;
STATUS_ACPI_INVALID_ARGTYPE	 = 0xC0140008

;
; MessageId: STATUS_ACPI_INVALID_OBJTYPE
;
; MessageText:
;
;  An object with an incorrect type was specified
;
STATUS_ACPI_INVALID_OBJTYPE	 = 0xC0140009

;
; MessageId: STATUS_ACPI_INVALID_TARGETTYPE
;
; MessageText:
;
;  A target with an incorrect type was specified
;
STATUS_ACPI_INVALID_TARGETTYPE	 = 0xC014000A

;
; MessageId: STATUS_ACPI_INCORRECT_ARGUMENT_COUNT
;
; MessageText:
;
;  An incorrect number of arguments were specified
;
STATUS_ACPI_INCORRECT_ARGUMENT_COUNT = 0xC014000B

;
; MessageId: STATUS_ACPI_ADDRESS_NOT_MAPPED
;
; MessageText:
;
;  An address failed to translate
;
STATUS_ACPI_ADDRESS_NOT_MAPPED	 = 0xC014000C

;
; MessageId: STATUS_ACPI_INVALID_EVENTTYPE
;
; MessageText:
;
;  An incorrect event type was specified
;
STATUS_ACPI_INVALID_EVENTTYPE	 = 0xC014000D

;
; MessageId: STATUS_ACPI_HANDLER_COLLISION
;
; MessageText:
;
;  A handler for the target already exists
;
STATUS_ACPI_HANDLER_COLLISION	 = 0xC014000E

;
; MessageId: STATUS_ACPI_INVALID_DATA
;
; MessageText:
;
;  Invalid data for the target was specified
;
STATUS_ACPI_INVALID_DATA	 = 0xC014000F

;
; MessageId: STATUS_ACPI_INVALID_REGION
;
; MessageText:
;
;  An invalid region for the target was specified
;
STATUS_ACPI_INVALID_REGION	 = 0xC0140010

;
; MessageId: STATUS_ACPI_INVALID_ACCESS_SIZE
;
; MessageText:
;
;  An attempt was made to access a field outside of the defined range
;
STATUS_ACPI_INVALID_ACCESS_SIZE  = 0xC0140011

;
; MessageId: STATUS_ACPI_ACQUIRE_GLOBAL_LOCK
;
; MessageText:
;
;  The Global system lock could not be acquired
;
STATUS_ACPI_ACQUIRE_GLOBAL_LOCK  = 0xC0140012

;
; MessageId: STATUS_ACPI_ALREADY_INITIALIZED
;
; MessageText:
;
;  An attempt was made to reinitialize the ACPI subsystem
;
STATUS_ACPI_ALREADY_INITIALIZED  = 0xC0140013

;
; MessageId: STATUS_ACPI_NOT_INITIALIZED
;
; MessageText:
;
;  The ACPI subsystem has not been initialized
;
STATUS_ACPI_NOT_INITIALIZED	 = 0xC0140014

;
; MessageId: STATUS_ACPI_INVALID_MUTEX_LEVEL
;
; MessageText:
;
;  An incorrect mutex was specified
;
STATUS_ACPI_INVALID_MUTEX_LEVEL  = 0xC0140015

;
; MessageId: STATUS_ACPI_MUTEX_NOT_OWNED
;
; MessageText:
;
;  The mutex is not currently owned
;
STATUS_ACPI_MUTEX_NOT_OWNED	 = 0xC0140016

;
; MessageId: STATUS_ACPI_MUTEX_NOT_OWNER
;
; MessageText:
;
;  An attempt was made to access the mutex by a process that was not the owner
;
STATUS_ACPI_MUTEX_NOT_OWNER	 = 0xC0140017

;
; MessageId: STATUS_ACPI_RS_ACCESS
;
; MessageText:
;
;  An error occurred during an access to Region Space
;
STATUS_ACPI_RS_ACCESS		 = 0xC0140018

;
; MessageId: STATUS_ACPI_INVALID_TABLE
;
; MessageText:
;
;  An attempt was made to use an incorrect table
;
STATUS_ACPI_INVALID_TABLE	 = 0xC0140019

;
; MessageId: STATUS_ACPI_REG_HANDLER_FAILED
;
; MessageText:
;
;  The registration of an ACPI event failed
;
STATUS_ACPI_REG_HANDLER_FAILED	 = 0xC0140020

;
; MessageId: STATUS_ACPI_POWER_REQUEST_FAILED
;
; MessageText:
;
;  An ACPI Power Object failed to transition state
;
STATUS_ACPI_POWER_REQUEST_FAILED = 0xC0140021

;
; Terminal Server specific Errors
;
;
; MessageId: STATUS_CTX_WINSTATION_NAME_INVALID
;
; MessageText:
;
;  Session name %1 is invalid.
;
STATUS_CTX_WINSTATION_NAME_INVALID = 0xC00A0001

;
; MessageId: STATUS_CTX_INVALID_PD
;
; MessageText:
;
;  The protocol driver %1 is invalid.
;
STATUS_CTX_INVALID_PD		 = 0xC00A0002

;
; MessageId: STATUS_CTX_PD_NOT_FOUND
;
; MessageText:
;
;  The protocol driver %1 was not found in the system path.
;
STATUS_CTX_PD_NOT_FOUND 	 = 0xC00A0003

;
; MessageId: STATUS_CTX_CDM_CONNECT
;
; MessageText:
;
;  The Client Drive Mapping Service Has Connected on Terminal Connection.
;
STATUS_CTX_CDM_CONNECT		 = 0x400A0004

;
; MessageId: STATUS_CTX_CDM_DISCONNECT
;
; MessageText:
;
;  The Client Drive Mapping Service Has Disconnected on Terminal Connection.
;
STATUS_CTX_CDM_DISCONNECT	 = 0x400A0005

;
; MessageId: STATUS_CTX_CLOSE_PENDING
;
; MessageText:
;
;  A close operation is pending on the Terminal Connection.
;
STATUS_CTX_CLOSE_PENDING	 = 0xC00A0006

;
; MessageId: STATUS_CTX_NO_OUTBUF
;
; MessageText:
;
;  There are no free output buffers available.
;
STATUS_CTX_NO_OUTBUF		 = 0xC00A0007

;
; MessageId: STATUS_CTX_MODEM_INF_NOT_FOUND
;
; MessageText:
;
;  The MODEM.INF file was not found.
;
STATUS_CTX_MODEM_INF_NOT_FOUND	 = 0xC00A0008

;
; MessageId: STATUS_CTX_INVALID_MODEMNAME
;
; MessageText:
;
;  The modem (%1) was not found in MODEM.INF.
;
STATUS_CTX_INVALID_MODEMNAME	 = 0xC00A0009

;
; MessageId: STATUS_CTX_RESPONSE_ERROR
;
; MessageText:
;
;  The modem did not accept the command sent to it.
;  Verify the configured modem name matches the attached modem.
;
STATUS_CTX_RESPONSE_ERROR	 = 0xC00A000A

;
; MessageId: STATUS_CTX_MODEM_RESPONSE_TIMEOUT
;
; MessageText:
;
;  The modem did not respond to the command sent to it.
;  Verify the modem is properly cabled and powered on.
;
STATUS_CTX_MODEM_RESPONSE_TIMEOUT = 0xC00A000B

;
; MessageId: STATUS_CTX_MODEM_RESPONSE_NO_CARRIER
;
; MessageText:
;
;  Carrier detect has failed or carrier has been dropped due to disconnect.
;
STATUS_CTX_MODEM_RESPONSE_NO_CARRIER = 0xC00A000C

;
; MessageId: STATUS_CTX_MODEM_RESPONSE_NO_DIALTONE
;
; MessageText:
;
;  Dial tone not detected within required time.
;  Verify phone cable is properly attached and functional.
;
STATUS_CTX_MODEM_RESPONSE_NO_DIALTONE = 0xC00A000D

;
; MessageId: STATUS_CTX_MODEM_RESPONSE_BUSY
;
; MessageText:
;
;  Busy signal detected at remote site on callback.
;
STATUS_CTX_MODEM_RESPONSE_BUSY	 = 0xC00A000E

;
; MessageId: STATUS_CTX_MODEM_RESPONSE_VOICE
;
; MessageText:
;
;  Voice detected at remote site on callback.
;
STATUS_CTX_MODEM_RESPONSE_VOICE  = 0xC00A000F

;
; MessageId: STATUS_CTX_TD_ERROR
;
; MessageText:
;
;  Transport driver error
;
STATUS_CTX_TD_ERROR		 = 0xC00A0010

;
; MessageId: STATUS_CTX_LICENSE_CLIENT_INVALID
;
; MessageText:
;
;  The client you are using is not licensed to use this system. Your logon request is denied.
;
STATUS_CTX_LICENSE_CLIENT_INVALID = 0xC00A0012

;
; MessageId: STATUS_CTX_LICENSE_NOT_AVAILABLE
;
; MessageText:
;
;  The system has reached its licensed logon limit.
;  Please try again later.
;
STATUS_CTX_LICENSE_NOT_AVAILABLE = 0xC00A0013

;
; MessageId: STATUS_CTX_LICENSE_EXPIRED
;
; MessageText:
;
;  The system license has expired. Your logon request is denied.
;
STATUS_CTX_LICENSE_EXPIRED	 = 0xC00A0014

;
; MessageId: STATUS_CTX_WINSTATION_NOT_FOUND
;
; MessageText:
;
;  The specified session cannot be found.
;
STATUS_CTX_WINSTATION_NOT_FOUND  = 0xC00A0015

;
; MessageId: STATUS_CTX_WINSTATION_NAME_COLLISION
;
; MessageText:
;
;  The specified session name is already in use.
;
STATUS_CTX_WINSTATION_NAME_COLLISION = 0xC00A0016

;
; MessageId: STATUS_CTX_WINSTATION_BUSY
;
; MessageText:
;
;  The requested operation cannot be completed because the Terminal Connection is currently busy processing a connect, disconnect, reset, or delete operation.
;
STATUS_CTX_WINSTATION_BUSY	 = 0xC00A0017

;
; MessageId: STATUS_CTX_BAD_VIDEO_MODE
;
; MessageText:
;
;  An attempt has been made to connect to a session whose video mode is not supported by the current client.
;
STATUS_CTX_BAD_VIDEO_MODE	 = 0xC00A0018

;
; MessageId: STATUS_CTX_GRAPHICS_INVALID
;
; MessageText:
;
;  The application attempted to enable DOS graphics mode.
;  DOS graphics mode is not supported.
;
STATUS_CTX_GRAPHICS_INVALID	 = 0xC00A0022

;
; MessageId: STATUS_CTX_NOT_CONSOLE
;
; MessageText:
;
;  The requested operation can be performed only on the system console.
;  This is most often the result of a driver or system DLL requiring direct console access.
;
STATUS_CTX_NOT_CONSOLE		 = 0xC00A0024

;
; MessageId: STATUS_CTX_CLIENT_QUERY_TIMEOUT
;
; MessageText:
;
;  The client failed to respond to the server connect message.
;
STATUS_CTX_CLIENT_QUERY_TIMEOUT  = 0xC00A0026

;
; MessageId: STATUS_CTX_CONSOLE_DISCONNECT
;
; MessageText:
;
;  Disconnecting the console session is not supported.
;
STATUS_CTX_CONSOLE_DISCONNECT	 = 0xC00A0027

;
; MessageId: STATUS_CTX_CONSOLE_CONNECT
;
; MessageText:
;
;  Reconnecting a disconnected session to the console is not supported.
;
STATUS_CTX_CONSOLE_CONNECT	 = 0xC00A0028

;
; MessageId: STATUS_CTX_SHADOW_DENIED
;
; MessageText:
;
;  The request to control another session remotely was denied.
;
STATUS_CTX_SHADOW_DENIED	 = 0xC00A002A

;
; MessageId: STATUS_CTX_WINSTATION_ACCESS_DENIED
;
; MessageText:
;
;  A process has requested access to a session, but has not been granted those access rights.
;
STATUS_CTX_WINSTATION_ACCESS_DENIED = 0xC00A002B

;
; MessageId: STATUS_CTX_INVALID_WD
;
; MessageText:
;
;  The Terminal Connection driver %1 is invalid.
;
STATUS_CTX_INVALID_WD		 = 0xC00A002E

;
; MessageId: STATUS_CTX_WD_NOT_FOUND
;
; MessageText:
;
;  The Terminal Connection driver %1 was not found in the system path.
;
STATUS_CTX_WD_NOT_FOUND 	 = 0xC00A002F

;
; MessageId: STATUS_CTX_SHADOW_INVALID
;
; MessageText:
;
;  The requested session cannot be controlled remotely.
;  You cannot control your own session, a session that is trying to control your session,
;  a session that has no user logged on, nor control other sessions from the console.
;
STATUS_CTX_SHADOW_INVALID	 = 0xC00A0030

;
; MessageId: STATUS_CTX_SHADOW_DISABLED
;
; MessageText:
;
;  The requested session is not configured to allow remote control.
;
STATUS_CTX_SHADOW_DISABLED	 = 0xC00A0031

;
; MessageId: STATUS_RDP_PROTOCOL_ERROR
;
; MessageText:
;
;  The RDP protocol component %2 detected an error in the protocol stream and has disconnected the client.
;
STATUS_RDP_PROTOCOL_ERROR	 = 0xC00A0032

;
; MessageId: STATUS_CTX_CLIENT_LICENSE_NOT_SET
;
; MessageText:
;
;  Your request to connect to this Terminal server has been rejected.
;  Your Terminal Server Client license number has not been entered for this copy of the Terminal Client.
;  Please call your system administrator for help in entering a valid, unique license number for this Terminal Server Client.
;  Click OK to continue.
;
STATUS_CTX_CLIENT_LICENSE_NOT_SET = 0xC00A0033

;
; MessageId: STATUS_CTX_CLIENT_LICENSE_IN_USE
;
; MessageText:
;
;  Your request to connect to this Terminal server has been rejected.
;  Your Terminal Server Client license number is currently being used by another user.
;  Please call your system administrator to obtain a new copy of the Terminal Server Client with a valid, unique license number.
;  Click OK to continue.
;
STATUS_CTX_CLIENT_LICENSE_IN_USE = 0xC00A0034

;
; MessageId: STATUS_CTX_SHADOW_ENDED_BY_MODE_CHANGE
;
; MessageText:
;
;  The remote control of the console was terminated because the display mode was changed. Changing the display mode in a remote control session is not supported.
;
STATUS_CTX_SHADOW_ENDED_BY_MODE_CHANGE = 0xC00A0035

;
; MessageId: STATUS_CTX_SHADOW_NOT_RUNNING
;
; MessageText:
;
;  Remote control could not be terminated because the specified session is not currently being remotely controlled.
;
STATUS_CTX_SHADOW_NOT_RUNNING	 = 0xC00A0036

;
; MessageId: STATUS_PNP_BAD_MPS_TABLE
;
; MessageText:
;
;  A device is missing in the system BIOS MPS table. This device will not be used.
;  Please contact your system vendor for system BIOS update.
;
STATUS_PNP_BAD_MPS_TABLE	 = 0xC0040035

;
; MessageId: STATUS_PNP_TRANSLATION_FAILED
;
; MessageText:
;
;  A translator failed to translate resources.
;
STATUS_PNP_TRANSLATION_FAILED	 = 0xC0040036

;
; MessageId: STATUS_PNP_IRQ_TRANSLATION_FAILED
;
; MessageText:
;
;  A IRQ translator failed to translate resources.
;
STATUS_PNP_IRQ_TRANSLATION_FAILED = 0xC0040037

;
; MessageId: STATUS_SXS_SECTION_NOT_FOUND
;
; MessageText:
;
;  The requested section is not present in the activation context.
;
STATUS_SXS_SECTION_NOT_FOUND	 = 0xC0150001

;
; MessageId: STATUS_SXS_CANT_GEN_ACTCTX
;
; MessageText:
;
;  Windows was not able to process the application binding information.
;  Please refer to your System Event Log for further information.
;
STATUS_SXS_CANT_GEN_ACTCTX	 = 0xC0150002

;
; MessageId: STATUS_SXS_INVALID_ACTCTXDATA_FORMAT
;
; MessageText:
;
;  The application binding data format is invalid.
;
STATUS_SXS_INVALID_ACTCTXDATA_FORMAT = 0xC0150003

;
; MessageId: STATUS_SXS_ASSEMBLY_NOT_FOUND
;
; MessageText:
;
;  The referenced assembly is not installed on your system.
;
STATUS_SXS_ASSEMBLY_NOT_FOUND	 = 0xC0150004

;
; MessageId: STATUS_SXS_MANIFEST_FORMAT_ERROR
;
; MessageText:
;
;  The manifest file does not begin with the required tag and format information.
;
STATUS_SXS_MANIFEST_FORMAT_ERROR = 0xC0150005

;
; MessageId: STATUS_SXS_MANIFEST_PARSE_ERROR
;
; MessageText:
;
;  The manifest file contains one or more syntax errors.
;
STATUS_SXS_MANIFEST_PARSE_ERROR  = 0xC0150006

;
; MessageId: STATUS_SXS_ACTIVATION_CONTEXT_DISABLED
;
; MessageText:
;
;  The application attempted to activate a disabled activation context.
;
STATUS_SXS_ACTIVATION_CONTEXT_DISABLED = 0xC0150007

;
; MessageId: STATUS_SXS_KEY_NOT_FOUND
;
; MessageText:
;
;  The requested lookup key was not found in any active activation context.
;
STATUS_SXS_KEY_NOT_FOUND	 = 0xC0150008

;
; MessageId: STATUS_SXS_VERSION_CONFLICT
;
; MessageText:
;
;  A component version required by the application conflicts with another component version already active.
;
STATUS_SXS_VERSION_CONFLICT	 = 0xC0150009

;
; MessageId: STATUS_SXS_WRONG_SECTION_TYPE
;
; MessageText:
;
;  The type requested activation context section does not match the query API used.
;
STATUS_SXS_WRONG_SECTION_TYPE	 = 0xC015000A

;
; MessageId: STATUS_SXS_THREAD_QUERIES_DISABLED
;
; MessageText:
;
;  Lack of system resources has required isolated activation to be disabled for the current thread of execution.
;
STATUS_SXS_THREAD_QUERIES_DISABLED = 0xC015000B

;
; MessageId: STATUS_SXS_ASSEMBLY_MISSING
;
; MessageText:
;
;  The referenced assembly could not be found.
;
STATUS_SXS_ASSEMBLY_MISSING	 = 0xC015000C

;
; MessageId: STATUS_SXS_RELEASE_ACTIVATION_CONTEXT
;
; MessageText:
;
;  A kernel mode component is releasing a reference on an activation context.
;
STATUS_SXS_RELEASE_ACTIVATION_CONTEXT = 0x4015000D

;
; MessageId: STATUS_SXS_PROCESS_DEFAULT_ALREADY_SET
;
; MessageText:
;
;  An attempt to set the process default activation context failed because the process default activation context was already set.
;
STATUS_SXS_PROCESS_DEFAULT_ALREADY_SET = 0xC015000E

;
; MessageId: STATUS_SXS_EARLY_DEACTIVATION
;
; MessageText:
;
;  The activation context being deactivated is not the most recently activated one.
;
STATUS_SXS_EARLY_DEACTIVATION	 = 0xC015000F	 ; winnt

;
; MessageId: STATUS_SXS_INVALID_DEACTIVATION
;
; MessageText:
;
;  The activation context being deactivated is not active for the current thread of execution.
;
STATUS_SXS_INVALID_DEACTIVATION  = 0xC0150010	 ; winnt

;
; MessageId: STATUS_SXS_MULTIPLE_DEACTIVATION
;
; MessageText:
;
;  The activation context being deactivated has already been deactivated.
;
STATUS_SXS_MULTIPLE_DEACTIVATION = 0xC0150011

;
; MessageId: STATUS_SXS_SYSTEM_DEFAULT_ACTIVATION_CONTEXT_EMPTY
;
; MessageText:
;
;  The activation context of system default assembly could not be generated.
;
STATUS_SXS_SYSTEM_DEFAULT_ACTIVATION_CONTEXT_EMPTY = 0xC0150012

;
; MessageId: STATUS_SXS_PROCESS_TERMINATION_REQUESTED
;
; MessageText:
;
;  A component used by the isolation facility has requested to terminate the process.
;
STATUS_SXS_PROCESS_TERMINATION_REQUESTED = 0xC0150013

;
; MessageId: STATUS_CLUSTER_INVALID_NODE
;
; MessageText:
;
;  The cluster node is not valid.
;
STATUS_CLUSTER_INVALID_NODE	 = 0xC0130001

;
; MessageId: STATUS_CLUSTER_NODE_EXISTS
;
; MessageText:
;
;  The cluster node already exists.
;
STATUS_CLUSTER_NODE_EXISTS	 = 0xC0130002

;
; MessageId: STATUS_CLUSTER_JOIN_IN_PROGRESS
;
; MessageText:
;
;  A node is in the process of joining the cluster.
;
STATUS_CLUSTER_JOIN_IN_PROGRESS  = 0xC0130003

;
; MessageId: STATUS_CLUSTER_NODE_NOT_FOUND
;
; MessageText:
;
;  The cluster node was not found.
;
STATUS_CLUSTER_NODE_NOT_FOUND	 = 0xC0130004

;
; MessageId: STATUS_CLUSTER_LOCAL_NODE_NOT_FOUND
;
; MessageText:
;
;  The cluster local node information was not found.
;
STATUS_CLUSTER_LOCAL_NODE_NOT_FOUND = 0xC0130005

;
; MessageId: STATUS_CLUSTER_NETWORK_EXISTS
;
; MessageText:
;
;  The cluster network already exists.
;
STATUS_CLUSTER_NETWORK_EXISTS	 = 0xC0130006

;
; MessageId: STATUS_CLUSTER_NETWORK_NOT_FOUND
;
; MessageText:
;
;  The cluster network was not found.
;
STATUS_CLUSTER_NETWORK_NOT_FOUND = 0xC0130007

;
; MessageId: STATUS_CLUSTER_NETINTERFACE_EXISTS
;
; MessageText:
;
;  The cluster network interface already exists.
;
STATUS_CLUSTER_NETINTERFACE_EXISTS = 0xC0130008

;
; MessageId: STATUS_CLUSTER_NETINTERFACE_NOT_FOUND
;
; MessageText:
;
;  The cluster network interface was not found.
;
STATUS_CLUSTER_NETINTERFACE_NOT_FOUND = 0xC0130009

;
; MessageId: STATUS_CLUSTER_INVALID_REQUEST
;
; MessageText:
;
;  The cluster request is not valid for this object.
;
STATUS_CLUSTER_INVALID_REQUEST	 = 0xC013000A

;
; MessageId: STATUS_CLUSTER_INVALID_NETWORK_PROVIDER
;
; MessageText:
;
;  The cluster network provider is not valid.
;
STATUS_CLUSTER_INVALID_NETWORK_PROVIDER = 0xC013000B

;
; MessageId: STATUS_CLUSTER_NODE_DOWN
;
; MessageText:
;
;  The cluster node is down.
;
STATUS_CLUSTER_NODE_DOWN	 = 0xC013000C

;
; MessageId: STATUS_CLUSTER_NODE_UNREACHABLE
;
; MessageText:
;
;  The cluster node is not reachable.
;
STATUS_CLUSTER_NODE_UNREACHABLE  = 0xC013000D

;
; MessageId: STATUS_CLUSTER_NODE_NOT_MEMBER
;
; MessageText:
;
;  The cluster node is not a member of the cluster.
;
STATUS_CLUSTER_NODE_NOT_MEMBER	 = 0xC013000E

;
; MessageId: STATUS_CLUSTER_JOIN_NOT_IN_PROGRESS
;
; MessageText:
;
;  A cluster join operation is not in progress.
;
STATUS_CLUSTER_JOIN_NOT_IN_PROGRESS = 0xC013000F

;
; MessageId: STATUS_CLUSTER_INVALID_NETWORK
;
; MessageText:
;
;  The cluster network is not valid.
;
STATUS_CLUSTER_INVALID_NETWORK	 = 0xC0130010

;
; MessageId: STATUS_CLUSTER_NO_NET_ADAPTERS
;
; MessageText:
;
;  No network adapters are available.
;
STATUS_CLUSTER_NO_NET_ADAPTERS	 = 0xC0130011

;
; MessageId: STATUS_CLUSTER_NODE_UP
;
; MessageText:
;
;  The cluster node is up.
;
STATUS_CLUSTER_NODE_UP		 = 0xC0130012

;
; MessageId: STATUS_CLUSTER_NODE_PAUSED
;
; MessageText:
;
;  The cluster node is paused.
;
STATUS_CLUSTER_NODE_PAUSED	 = 0xC0130013

;
; MessageId: STATUS_CLUSTER_NODE_NOT_PAUSED
;
; MessageText:
;
;  The cluster node is not paused.
;
STATUS_CLUSTER_NODE_NOT_PAUSED	 = 0xC0130014

;
; MessageId: STATUS_CLUSTER_NO_SECURITY_CONTEXT
;
; MessageText:
;
;  No cluster security context is available.
;
STATUS_CLUSTER_NO_SECURITY_CONTEXT = 0xC0130015

;
; MessageId: STATUS_CLUSTER_NETWORK_NOT_INTERNAL
;
; MessageText:
;
;  The cluster network is not configured for internal cluster communication.
;
STATUS_CLUSTER_NETWORK_NOT_INTERNAL = 0xC0130016

;
; MessageId: STATUS_CLUSTER_POISONED
;
; MessageText:
;
;  The cluster node has been poisoned.
;
STATUS_CLUSTER_POISONED 	 = 0xC0130017

