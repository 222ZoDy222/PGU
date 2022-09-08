; DDK defines for Win64
;
; Converted to Native syntax for FASM by rpy3uH
;
; This file dont full and dont very accuracy!
;
; LAST UPDATE:            22.07.2010
;
; E-mail :    gruzino.abhaz[a]gmail.com


struc ANSI_STRING
 {
   .Length	   dw ?
   .MaximumLength  dw ?
      .unnamedraw  dd ?
   .Buffer	   dq ?
 }

struc UNICODE_STRING   ;size 8
 {
   .Length	  dw ?
   .MaximumLength dw ?
     .unnamedraw  dd ?
   .Buffer	  dq ?
 }

struc _UNICODE_STRING _Length, _MaximumLength, _Buffer ;size 8
 {
   .Length	  dw _Length
   .MaximumLength dw _MaximumLength
     .unnamedraw  dd ?
   .Buffer	  dq _Buffer
 }

KernelMode  = 0
UserMode    = 1
MaximumMode = 2

;
; Valid values for the Attributes field
;

OBJ_INHERIT		= 0x00000002
OBJ_PERMANENT		= 0x00000010
OBJ_EXCLUSIVE		= 0x00000020
OBJ_CASE_INSENSITIVE	= 0x00000040
OBJ_OPENIF		= 0x00000080
OBJ_OPENLINK		= 0x00000100
OBJ_KERNEL_HANDLE	= 0x00000200
OBJ_FORCE_ACCESS_CHECK	= 0x00000400
OBJ_VALID_ATTRIBUTES	= 0x000007F2



;
; Event Specific Access Rights.
;

EVENT_QUERY_STATE	= 0x0001
EVENT_MODIFY_STATE	= 0x0002  ; winnt
EVENT_ALL_ACCESS	= (STANDARD_RIGHTS_REQUIRED or SYNCHRONIZE or 0x3) ; winnt

;
; Semaphore Specific Access Rights.
;

SEMAPHORE_QUERY_STATE	= 0x0001
SEMAPHORE_MODIFY_STATE	= 0x0002  ; winnt
SEMAPHORE_ALL_ACCESS	= (STANDARD_RIGHTS_REQUIRED or SYNCHRONIZE or 0x3) ; winnt



; --------------------------[ POOL_TYPE ]-----------------------------------------

    NonPagedPool		       = 0
    PagedPool			       = 1
    NonPagedPoolMustSucceed	       = 2
    DontUseThisType		       = 3
    NonPagedPoolCacheAligned	       = 4
    PagedPoolCacheAligned	       = 5
    NonPagedPoolCacheAlignedMustS      = 6
    MaxPoolType 		       = 7

    ;
    ; Note these per session types are carefully chosen so that the appropriate
    ; masking still applies as well as MaxPoolType above.
    ;

    NonPagedPoolSession 		    = 32
    PagedPoolSession			    = NonPagedPoolSession + 1
    NonPagedPoolMustSucceedSession	    = PagedPoolSession + 1
    DontUseThisTypeSession		    = NonPagedPoolMustSucceedSession + 1
    NonPagedPoolCacheAlignedSession	    = DontUseThisTypeSession + 1
    PagedPoolCacheAlignedSession	    = NonPagedPoolCacheAlignedSession + 1
    NonPagedPoolCacheAlignedMustSSession    = PagedPoolCacheAlignedSession + 1



;
; Kernel Mutex Level Numbers (must be globallly assigned within executive)
; The third token in the name is the sub-component name that defines and
; uses the level number.
;

;
; Used by Vdm for protecting io simulation structures
;

MUTEX_LEVEL_VDM_IO		    = 0x00000001

MUTEX_LEVEL_EX_PROFILE		    = 0x00000040

;
; The LANMAN Redirector uses the file system major function, but defines
; it's own mutex levels.  We can do this safely because we know that the
; local filesystem will never call the remote filesystem and vice versa.
;

MUTEX_LEVEL_RDR_FILESYS_DATABASE    = 0x10100000
MUTEX_LEVEL_RDR_FILESYS_SECURITY    = 0x10100001

;
; File System levels.
;

MUTEX_LEVEL_FILESYSTEM_RAW_VCB	    = 0x11000006

;
; In the NT STREAMS environment, a mutex is used to serialize open, close
; and Scheduler threads executing in a subsystem-parallelized stack.
;

MUTEX_LEVEL_STREAMS_SUBSYS	    = 0x11001001

;
; Mutex level used by LDT support on x86
;

MUTEX_LEVEL_PS_LDT		    = 0x1F000000




MDL_MAPPED_TO_SYSTEM_VA     = 0x0001
MDL_PAGES_LOCKED	    = 0x0002
MDL_SOURCE_IS_NONPAGED_POOL = 0x0004
MDL_ALLOCATED_FIXED_SIZE    = 0x0008
MDL_PARTIAL		    = 0x0010
MDL_PARTIAL_HAS_BEEN_MAPPED = 0x0020
MDL_IO_PAGE_READ	    = 0x0040
MDL_WRITE_OPERATION	    = 0x0080
MDL_PARENT_MAPPED_SYSTEM_VA = 0x0100
MDL_FREE_EXTRA_PTES	    = 0x0200
MDL_IO_SPACE		    = 0x0800
MDL_NETWORK_HEADER	    = 0x1000
MDL_MAPPING_CAN_FAIL	    = 0x2000
MDL_ALLOCATED_MUST_SUCCEED  = 0x4000


;MDL_SYSTEM_VA = ???

MDL_MAPPING_FLAGS  = (MDL_MAPPED_TO_SYSTEM_VA	  + \
		      MDL_PAGES_LOCKED		  + \
		      MDL_SOURCE_IS_NONPAGED_POOL + \
		      MDL_PARTIAL_HAS_BEEN_MAPPED + \
		      MDL_PARENT_MAPPED_SYSTEM_VA + \
		      MDL_IO_SPACE)


;
; Size of kernel mode stack.
;

KERNEL_STACK_SIZE = 0x5000

;
; Define size of large kernel mode stack for callbacks.
;

KERNEL_LARGE_STACK_SIZE = 0xf000

;
; Define number of pages to initialize in a large kernel stack.
;

KERNEL_LARGE_STACK_COMMIT = 0x5000

;
; Define the size of the stack used for processing an MCA exception.
;

KERNEL_MCA_EXCEPTION_STACK_SIZE = 0x2000


;
; The following flags control the contents of the CONTEXT structure.
;

CONTEXT_i386	= 0x00010000	; this assumes that i386 and
CONTEXT_i486	= 0x00010000	; i486 have identical context records

CONTEXT_CONTROL 	= (CONTEXT_i386 + 0x00000001) ; SS:SP, CS:IP, FLAGS, BP
CONTEXT_INTEGER 	= (CONTEXT_i386 + 0x00000002) ; AX, BX, CX, DX, SI, DI
CONTEXT_SEGMENTS	= (CONTEXT_i386 + 0x00000004) ; DS, ES, FS, GS
CONTEXT_FLOATING_POINT	= (CONTEXT_i386 + 0x00000008) ; 387 state
CONTEXT_DEBUG_REGISTERS = (CONTEXT_i386 + 0x00000010) ; DB 0-3,6,7
CONTEXT_EXTENDED_REGISTERS = (CONTEXT_i386 + 0x00000020) ; cpu specific extensions

CONTEXT_FULL = (CONTEXT_CONTROL + CONTEXT_INTEGER + CONTEXT_SEGMENTS)


;
;  The following are masks for the predefined standard access types
;

DELETE				 = 0x00010000
READ_CONTROL			 = 0x00020000
WRITE_DAC			 = 0x00040000
WRITE_OWNER			 = 0x00080000
SYNCHRONIZE			 = 0x00100000

STANDARD_RIGHTS_REQUIRED	 = 0x000F0000

STANDARD_RIGHTS_READ		 = READ_CONTROL
STANDARD_RIGHTS_WRITE		 = READ_CONTROL
STANDARD_RIGHTS_EXECUTE 	 = READ_CONTROL

STANDARD_RIGHTS_ALL		 = 0x001F0000

SPECIFIC_RIGHTS_ALL		 = 0x0000FFFF

;
; AccessSystemAcl access type
;

ACCESS_SYSTEM_SECURITY		 = 0x01000000

;
; MaximumAllowed access type
;

MAXIMUM_ALLOWED 		 = 0x02000000

;
;  These are the generic rights.
;

GENERIC_READ			 = 0x80000000
GENERIC_WRITE			 = 0x40000000
GENERIC_EXECUTE 		 = 0x20000000
GENERIC_ALL			 = 0x10000000

;
; Current security descriptor revision value
;

SECURITY_DESCRIPTOR_REVISION	 = 1
SECURITY_DESCRIPTOR_REVISION1	 = 1

;
; Privilege attributes
;

SE_PRIVILEGE_ENABLED_BY_DEFAULT = 0x00000001
SE_PRIVILEGE_ENABLED		= 0x00000002
SE_PRIVILEGE_USED_FOR_ACCESS	= 0x80000000

;
; Privilege Set Control flags
;

PRIVILEGE_SET_ALL_NECESSARY	= 1

;
; Define the various device type values.  Note that values used by Microsoft
; Corporation are in the range 0-32767, and 32768-65535 are reserved for use
; by customers.
;

FILE_DEVICE_BEEP		= 0x00000001
FILE_DEVICE_CD_ROM		= 0x00000002
FILE_DEVICE_CD_ROM_FILE_SYSTEM	= 0x00000003
FILE_DEVICE_CONTROLLER		= 0x00000004
FILE_DEVICE_DATALINK		= 0x00000005
FILE_DEVICE_DFS 		= 0x00000006
FILE_DEVICE_DISK		= 0x00000007
FILE_DEVICE_DISK_FILE_SYSTEM	= 0x00000008
FILE_DEVICE_FILE_SYSTEM 	= 0x00000009
FILE_DEVICE_INPORT_PORT 	= 0x0000000a
FILE_DEVICE_KEYBOARD		= 0x0000000b
FILE_DEVICE_MAILSLOT		= 0x0000000c
FILE_DEVICE_MIDI_IN		= 0x0000000d
FILE_DEVICE_MIDI_OUT		= 0x0000000e
FILE_DEVICE_MOUSE		= 0x0000000f
FILE_DEVICE_MULTI_UNC_PROVIDER	= 0x00000010
FILE_DEVICE_NAMED_PIPE		= 0x00000011
FILE_DEVICE_NETWORK		= 0x00000012
FILE_DEVICE_NETWORK_BROWSER	= 0x00000013
FILE_DEVICE_NETWORK_FILE_SYSTEM = 0x00000014
FILE_DEVICE_NULL		= 0x00000015
FILE_DEVICE_PARALLEL_PORT	= 0x00000016
FILE_DEVICE_PHYSICAL_NETCARD	= 0x00000017
FILE_DEVICE_PRINTER		= 0x00000018
FILE_DEVICE_SCANNER		= 0x00000019
FILE_DEVICE_SERIAL_MOUSE_PORT	= 0x0000001a
FILE_DEVICE_SERIAL_PORT 	= 0x0000001b
FILE_DEVICE_SCREEN		= 0x0000001c
FILE_DEVICE_SOUND		= 0x0000001d
FILE_DEVICE_STREAMS		= 0x0000001e
FILE_DEVICE_TAPE		= 0x0000001f
FILE_DEVICE_TAPE_FILE_SYSTEM	= 0x00000020
FILE_DEVICE_TRANSPORT		= 0x00000021
FILE_DEVICE_UNKNOWN		= 0x00000022
FILE_DEVICE_VIDEO		= 0x00000023
FILE_DEVICE_VIRTUAL_DISK	= 0x00000024
FILE_DEVICE_WAVE_IN		= 0x00000025
FILE_DEVICE_WAVE_OUT		= 0x00000026
FILE_DEVICE_8042_PORT		= 0x00000027
FILE_DEVICE_NETWORK_REDIRECTOR	= 0x00000028
FILE_DEVICE_BATTERY		= 0x00000029
FILE_DEVICE_BUS_EXTENDER	= 0x0000002a
FILE_DEVICE_MODEM		= 0x0000002b
FILE_DEVICE_VDM 		= 0x0000002c
FILE_DEVICE_MASS_STORAGE	= 0x0000002d
FILE_DEVICE_SMB 		= 0x0000002e
FILE_DEVICE_KS			= 0x0000002f
FILE_DEVICE_CHANGER		= 0x00000030
FILE_DEVICE_SMARTCARD		= 0x00000031
FILE_DEVICE_ACPI		= 0x00000032
FILE_DEVICE_DVD 		= 0x00000033
FILE_DEVICE_FULLSCREEN_VIDEO	= 0x00000034
FILE_DEVICE_DFS_FILE_SYSTEM	= 0x00000035
FILE_DEVICE_DFS_VOLUME		= 0x00000036
FILE_DEVICE_SERENUM		= 0x00000037
FILE_DEVICE_TERMSRV		= 0x00000038
FILE_DEVICE_KSEC		= 0x00000039
FILE_DEVICE_FIPS		= 0x0000003A

;
; Define the method codes for how buffers are passed for I/O and FS controls
;

METHOD_BUFFERED 		= 0
METHOD_IN_DIRECT		= 1
METHOD_OUT_DIRECT		= 2
METHOD_NEITHER			= 3

;
; Define the access check value for any access
;
;
; The FILE_READ_ACCESS and FILE_WRITE_ACCESS constants are also defined in
; ntioapi.h as FILE_READ_DATA and FILE_WRITE_DATA. The values for these
; constants *MUST* always be in sync.
;
;
; FILE_SPECIAL_ACCESS is checked by the NT I/O system the same as FILE_ANY_ACCESS.
; The file systems, however, may add additional access checks for I/O and FS controls
; that use this value.
;


FILE_ANY_ACCESS 	       = 0
FILE_SPECIAL_ACCESS    = FILE_ANY_ACCESS
FILE_READ_ACCESS	  = 0x0001	; file & pipe
FILE_WRITE_ACCESS	  = 0x0002	; file & pipe

; begin_winnt

;
; Define access rights to files and directories
;

;
; The FILE_READ_DATA and FILE_WRITE_DATA constants are also defined in
; devioctl.h as FILE_READ_ACCESS and FILE_WRITE_ACCESS. The values for these
; constants *MUST* always be in sync.
; The values are redefined in devioctl.h because they must be available to
; both DOS and NT.
;

FILE_READ_DATA		  = 0x0001	; file & pipe
FILE_LIST_DIRECTORY	  = 0x0001	; directory

FILE_WRITE_DATA 	  = 0x0002	; file & pipe
FILE_ADD_FILE		  = 0x0002	; directory

FILE_APPEND_DATA	  = 0x0004	; file
FILE_ADD_SUBDIRECTORY	  = 0x0004	; directory
FILE_CREATE_PIPE_INSTANCE = 0x0004	; named pipe


FILE_READ_EA		  = 0x0008	; file & directory

FILE_WRITE_EA		  = 0x0010	; file & directory

FILE_EXECUTE		  = 0x0020	; file
FILE_TRAVERSE		  = 0x0020	; directory

FILE_DELETE_CHILD	  = 0x0040	; directory

FILE_READ_ATTRIBUTES	  = 0x0080	; all

FILE_WRITE_ATTRIBUTES	  = 0x0100	; all

FILE_ALL_ACCESS = (STANDARD_RIGHTS_REQUIRED + SYNCHRONIZE + 0x1FF)

FILE_GENERIC_READ	  = (STANDARD_RIGHTS_READ     +\
				   FILE_READ_DATA	    +\
				   FILE_READ_ATTRIBUTES     +\
				   FILE_READ_EA 	    +\
				   SYNCHRONIZE)


FILE_GENERIC_WRITE	  = (STANDARD_RIGHTS_WRITE    +\
				   FILE_WRITE_DATA	    +\
				   FILE_WRITE_ATTRIBUTES    +\
				   FILE_WRITE_EA	    +\
				   FILE_APPEND_DATA	    +\
				   SYNCHRONIZE)


FILE_GENERIC_EXECUTE	  = (STANDARD_RIGHTS_EXECUTE  +\
				   FILE_READ_ATTRIBUTES     +\
				   FILE_EXECUTE 	    +\
				   SYNCHRONIZE)

; end_winnt


;
; Define share access rights to files and directories
;

FILE_SHARE_READ 		= 0x00000001  ; winnt
FILE_SHARE_WRITE		= 0x00000002  ; winnt
FILE_SHARE_DELETE		= 0x00000004  ; winnt
FILE_SHARE_VALID_FLAGS		= 0x00000007

;
; Define the file attributes values
;
; Note:  0x00000008 is reserved for use for the old DOS VOLID (volume ID)
;        and is therefore not considered valid in NT.
;
; Note:  0x00000010 is reserved for use for the old DOS SUBDIRECTORY flag
;        and is therefore not considered valid in NT.  This flag has
;        been disassociated with file attributes since the other flags are
;        protected with READ_ and WRITE_ATTRIBUTES access to the file.
;
; Note:  Note also that the order of these flags is set to allow both the
;        FAT and the Pinball File Systems to directly set the attributes
;        flags in attributes words without having to pick each flag out
;        individually.  The order of these flags should not be changed!
;

FILE_ATTRIBUTE_READONLY 	    = 0x00000001  ; winnt
FILE_ATTRIBUTE_HIDDEN		    = 0x00000002  ; winnt
FILE_ATTRIBUTE_SYSTEM		    = 0x00000004  ; winnt
;OLD DOS VOLID                             = 0x00000008

FILE_ATTRIBUTE_DIRECTORY	    = 0x00000010  ; winnt
FILE_ATTRIBUTE_ARCHIVE		    = 0x00000020  ; winnt
FILE_ATTRIBUTE_DEVICE		    = 0x00000040  ; winnt
FILE_ATTRIBUTE_NORMAL		    = 0x00000080  ; winnt

FILE_ATTRIBUTE_TEMPORARY	    = 0x00000100  ; winnt
FILE_ATTRIBUTE_SPARSE_FILE	    = 0x00000200  ; winnt
FILE_ATTRIBUTE_REPARSE_POINT	    = 0x00000400  ; winnt
FILE_ATTRIBUTE_COMPRESSED	    = 0x00000800  ; winnt

FILE_ATTRIBUTE_OFFLINE		    = 0x00001000  ; winnt
FILE_ATTRIBUTE_NOT_CONTENT_INDEXED  = 0x00002000  ; winnt
FILE_ATTRIBUTE_ENCRYPTED	    = 0x00004000  ; winnt

FILE_ATTRIBUTE_VALID_FLAGS	    = 0x00007fb7
FILE_ATTRIBUTE_VALID_SET_FLAGS	    = 0x000031a7

;
; Define the create disposition values
;

FILE_SUPERSEDE		       = 0x00000000
FILE_OPEN		       = 0x00000001
FILE_CREATE		       = 0x00000002
FILE_OPEN_IF		       = 0x00000003
FILE_OVERWRITE		       = 0x00000004
FILE_OVERWRITE_IF	       = 0x00000005
FILE_MAXIMUM_DISPOSITION       = 0x00000005

;
; Define the create/open option flags
;

FILE_DIRECTORY_FILE		       = 0x00000001
FILE_WRITE_THROUGH		       = 0x00000002
FILE_SEQUENTIAL_ONLY		       = 0x00000004
FILE_NO_INTERMEDIATE_BUFFERING	       = 0x00000008

FILE_SYNCHRONOUS_IO_ALERT	       = 0x00000010
FILE_SYNCHRONOUS_IO_NONALERT	       = 0x00000020
FILE_NON_DIRECTORY_FILE 	       = 0x00000040
FILE_CREATE_TREE_CONNECTION	       = 0x00000080

FILE_COMPLETE_IF_OPLOCKED	       = 0x00000100
FILE_NO_EA_KNOWLEDGE		       = 0x00000200
FILE_OPEN_FOR_RECOVERY		       = 0x00000400
FILE_RANDOM_ACCESS		       = 0x00000800

FILE_DELETE_ON_CLOSE		       = 0x00001000
FILE_OPEN_BY_FILE_ID		       = 0x00002000
FILE_OPEN_FOR_BACKUP_INTENT	       = 0x00004000
FILE_NO_COMPRESSION		       = 0x00008000

FILE_RESERVE_OPFILTER		       = 0x00100000
FILE_OPEN_REPARSE_POINT 	       = 0x00200000
FILE_OPEN_NO_RECALL		       = 0x00400000
FILE_OPEN_FOR_FREE_SPACE_QUERY	       = 0x00800000

FILE_COPY_STRUCTURED_STORAGE	       = 0x00000041
FILE_STRUCTURED_STORAGE 	       = 0x00000441

FILE_VALID_OPTION_FLAGS 	       = 0x00ffffff
FILE_VALID_PIPE_OPTION_FLAGS	       = 0x00000032
FILE_VALID_MAILSLOT_OPTION_FLAGS       = 0x00000032
FILE_VALID_SET_FLAGS		       = 0x00000036

;
; Define the I/O status information return values for NtCreateFile/NtOpenFile
;

FILE_SUPERSEDED 	       = 0x00000000
FILE_OPENED		       = 0x00000001
FILE_CREATED		       = 0x00000002
FILE_OVERWRITTEN	       = 0x00000003
FILE_EXISTS		       = 0x00000004
FILE_DOES_NOT_EXIST	       = 0x00000005

;
; Define special ByteOffset parameters for read and write operations
;

FILE_WRITE_TO_END_OF_FILE      = 0xffffffff
FILE_USE_FILE_POINTER_POSITION = 0xfffffffe

;
; Define alignment requirement values
;

FILE_BYTE_ALIGNMENT	       = 0x00000000
FILE_WORD_ALIGNMENT	       = 0x00000001
FILE_LONG_ALIGNMENT	       = 0x00000003
FILE_QUAD_ALIGNMENT	       = 0x00000007
FILE_OCTA_ALIGNMENT	       = 0x0000000f
FILE_32_BYTE_ALIGNMENT	       = 0x0000001f
FILE_64_BYTE_ALIGNMENT	       = 0x0000003f
FILE_128_BYTE_ALIGNMENT        = 0x0000007f
FILE_256_BYTE_ALIGNMENT        = 0x000000ff
FILE_512_BYTE_ALIGNMENT        = 0x000001ff

;
; Define the maximum length of a filename string
;

MAXIMUM_FILENAME_LENGTH        = 256

;
; Define the various device characteristics flags
;

FILE_REMOVABLE_MEDIA	       = 0x00000001
FILE_READ_ONLY_DEVICE	       = 0x00000002
FILE_FLOPPY_DISKETTE	       = 0x00000004
FILE_WRITE_ONCE_MEDIA	       = 0x00000008
FILE_REMOTE_DEVICE	       = 0x00000010
FILE_DEVICE_IS_MOUNTED	       = 0x00000020
FILE_VIRTUAL_VOLUME	       = 0x00000040
FILE_AUTOGENERATED_DEVICE_NAME = 0x00000080
FILE_DEVICE_SECURE_OPEN        = 0x00000100

; end_wdm

;
; The FILE_EXPECT flags will only exist for WinXP. After that they will be
; ignored and an IRP will be sent in their place.
;
FILE_CHARACTERISTICS_EXPECT_ORDERLY_REMOVAL    = 0x00000200
FILE_CHARACTERISTICS_EXPECT_SURPRISE_REMOVAL   = 0x00000300
FILE_CHARACTERISTICS_REMOVAL_POLICY_MASK       = 0x00000300

;
; flags specified here will be propagated up and down a device stack
; after FDO and all filter devices are added, but before the device
; stack is started
;

FILE_CHARACTERISTICS_PROPAGATED = (   FILE_REMOVABLE_MEDIA   + \
					    FILE_READ_ONLY_DEVICE  + \
					    FILE_FLOPPY_DISKETTE   + \
					    FILE_WRITE_ONCE_MEDIA  + \
					    FILE_DEVICE_SECURE_OPEN  )

;
; Define I/O system data structure type codes.  Each major data structure in
; the I/O system has a type code  The type field in each structure is at the
; same offset.  The following values can be used to determine which type of
; data structure a pointer refers to.
;

IO_TYPE_ADAPTER 		= 0x00000001
IO_TYPE_CONTROLLER		= 0x00000002
IO_TYPE_DEVICE			= 0x00000003
IO_TYPE_DRIVER			= 0x00000004
IO_TYPE_FILE			= 0x00000005
IO_TYPE_IRP			= 0x00000006
IO_TYPE_MASTER_ADAPTER		= 0x00000007
IO_TYPE_OPEN_PACKET		= 0x00000008
IO_TYPE_TIMER			= 0x00000009
IO_TYPE_VPB			= 0x0000000a
IO_TYPE_ERROR_LOG		= 0x0000000b
IO_TYPE_ERROR_MESSAGE		= 0x0000000c
IO_TYPE_DEVICE_OBJECT_EXTENSION = 0x0000000d


;
; Define the major function codes for IRPs.
;


IRP_MJ_CREATE			= 0x00
IRP_MJ_CREATE_NAMED_PIPE	= 0x01
IRP_MJ_CLOSE			= 0x02
IRP_MJ_READ			= 0x03
IRP_MJ_WRITE			= 0x04
IRP_MJ_QUERY_INFORMATION	= 0x05
IRP_MJ_SET_INFORMATION		= 0x06
IRP_MJ_QUERY_EA 		= 0x07
IRP_MJ_SET_EA			= 0x08
IRP_MJ_FLUSH_BUFFERS		= 0x09
IRP_MJ_QUERY_VOLUME_INFORMATION = 0x0a
IRP_MJ_SET_VOLUME_INFORMATION	= 0x0b
IRP_MJ_DIRECTORY_CONTROL	= 0x0c
IRP_MJ_FILE_SYSTEM_CONTROL	= 0x0d
IRP_MJ_DEVICE_CONTROL		= 0x0e
IRP_MJ_INTERNAL_DEVICE_CONTROL	= 0x0f
IRP_MJ_SHUTDOWN 		= 0x10
IRP_MJ_LOCK_CONTROL		= 0x11
IRP_MJ_CLEANUP			= 0x12
IRP_MJ_CREATE_MAILSLOT		= 0x13
IRP_MJ_QUERY_SECURITY		= 0x14
IRP_MJ_SET_SECURITY		= 0x15
IRP_MJ_POWER			= 0x16
IRP_MJ_SYSTEM_CONTROL		= 0x17
IRP_MJ_DEVICE_CHANGE		= 0x18
IRP_MJ_QUERY_QUOTA		= 0x19
IRP_MJ_SET_QUOTA		= 0x1a
IRP_MJ_PNP			= 0x1b
IRP_MJ_PNP_POWER		= IRP_MJ_PNP	  ; Obsolete....
IRP_MJ_MAXIMUM_FUNCTION 	= 0x1b

;
; Make the Scsi major code the same as internal device control.
;

IRP_MJ_SCSI			= IRP_MJ_INTERNAL_DEVICE_CONTROL

;
; Define the minor function codes for IRPs.  The lower 128 codes, from = 0x00 to
; = 0x7f are reserved to Microsoft.  The upper 128 codes, from = 0x80 to = 0xff, are
; reserved to customers of Microsoft.
;

; end_wdm end_ntndis
;
; Directory control minor function codes
;

IRP_MN_QUERY_DIRECTORY		= 0x01
IRP_MN_NOTIFY_CHANGE_DIRECTORY	= 0x02

;
; File system control minor function codes.  Note that "user request" is
; assumed to be zero by both the I/O system and file systems.  Do not change
; this value.
;

IRP_MN_USER_FS_REQUEST		= 0x00
IRP_MN_MOUNT_VOLUME		= 0x01
IRP_MN_VERIFY_VOLUME		= 0x02
IRP_MN_LOAD_FILE_SYSTEM 	= 0x03
IRP_MN_TRACK_LINK		= 0x04	  ; To be obsoleted soon
IRP_MN_KERNEL_CALL		= 0x04

;
; Lock control minor function codes
;

IRP_MN_LOCK			= 0x01
IRP_MN_UNLOCK_SINGLE		= 0x02
IRP_MN_UNLOCK_ALL		= 0x03
IRP_MN_UNLOCK_ALL_BY_KEY	= 0x04

;
; Read and Write minor function codes for file systems supporting Lan Manager
; software.  All of these subfunction codes are invalid if the file has been
; opened with FO_NO_INTERMEDIATE_BUFFERING.  They are also invalid in combi-
; nation with synchronous calls (Irp Flag or file open option).
;
; Note that "normal" is assumed to be zero by both the I/O system and file
; systems.  Do not change this value.
;

IRP_MN_NORMAL			= 0x00
IRP_MN_DPC			= 0x01
IRP_MN_MDL			= 0x02
IRP_MN_COMPLETE 		= 0x04
IRP_MN_COMPRESSED		= 0x08

IRP_MN_MDL_DPC			= (IRP_MN_MDL + IRP_MN_DPC)
IRP_MN_COMPLETE_MDL		= (IRP_MN_COMPLETE + IRP_MN_MDL)
IRP_MN_COMPLETE_MDL_DPC 	= (IRP_MN_COMPLETE_MDL + IRP_MN_DPC)

; begin_wdm
;
; Device Control Request minor function codes for SCSI support. Note that
; user requests are assumed to be zero.
;

IRP_MN_SCSI_CLASS		= 0x01

;
; PNP minor function codes.
;

IRP_MN_START_DEVICE		    = 0x00
IRP_MN_QUERY_REMOVE_DEVICE	    = 0x01
IRP_MN_REMOVE_DEVICE		    = 0x02
IRP_MN_CANCEL_REMOVE_DEVICE	    = 0x03
IRP_MN_STOP_DEVICE		    = 0x04
IRP_MN_QUERY_STOP_DEVICE	    = 0x05
IRP_MN_CANCEL_STOP_DEVICE	    = 0x06

IRP_MN_QUERY_DEVICE_RELATIONS	    = 0x07
IRP_MN_QUERY_INTERFACE		    = 0x08
IRP_MN_QUERY_CAPABILITIES	    = 0x09
IRP_MN_QUERY_RESOURCES		    = 0x0A
IRP_MN_QUERY_RESOURCE_REQUIREMENTS  = 0x0B
IRP_MN_QUERY_DEVICE_TEXT	    = 0x0C
IRP_MN_FILTER_RESOURCE_REQUIREMENTS = 0x0D

IRP_MN_READ_CONFIG		    = 0x0F
IRP_MN_WRITE_CONFIG		    = 0x10
IRP_MN_EJECT			    = 0x11
IRP_MN_SET_LOCK 		    = 0x12
IRP_MN_QUERY_ID 		    = 0x13
IRP_MN_QUERY_PNP_DEVICE_STATE	    = 0x14
IRP_MN_QUERY_BUS_INFORMATION	    = 0x15
IRP_MN_DEVICE_USAGE_NOTIFICATION    = 0x16
IRP_MN_SURPRISE_REMOVAL 	    = 0x17
; end_wdm
IRP_MN_QUERY_LEGACY_BUS_INFORMATION = 0x18
; begin_wdm

;
; POWER minor function codes
;
IRP_MN_WAIT_WAKE		    = 0x00
IRP_MN_POWER_SEQUENCE		    = 0x01
IRP_MN_SET_POWER		    = 0x02
IRP_MN_QUERY_POWER		    = 0x03

; begin_ntminiport
;
; WMI minor function codes under IRP_MJ_SYSTEM_CONTROL
;

IRP_MN_QUERY_ALL_DATA		    = 0x00
IRP_MN_QUERY_SINGLE_INSTANCE	    = 0x01
IRP_MN_CHANGE_SINGLE_INSTANCE	    = 0x02
IRP_MN_CHANGE_SINGLE_ITEM	    = 0x03
IRP_MN_ENABLE_EVENTS		    = 0x04
IRP_MN_DISABLE_EVENTS		    = 0x05
IRP_MN_ENABLE_COLLECTION	    = 0x06
IRP_MN_DISABLE_COLLECTION	    = 0x07
IRP_MN_REGINFO			    = 0x08
IRP_MN_EXECUTE_METHOD		    = 0x09
; Minor code = 0x0a is reserved
IRP_MN_REGINFO_EX		    = 0x0b

; end_ntminiport

;
; Define option flags for IoCreateFile.  Note that these values must be
; exactly the same as the SL_... flags for a create function.  Note also
; that there are flags that may be passed to IoCreateFile that are not
; placed in the stack location for the create IRP.  These flags start in
; the next byte.
;

IO_FORCE_ACCESS_CHECK		= 0x0001
IO_NO_PARAMETER_CHECKING	= 0x0100

;
; Define Information fields for whether or not a REPARSE or a REMOUNT has
; occurred in the file system.
;

IO_REPARSE			= 0x0
IO_REMOUNT			= 0x1


struc KDEVICE_QUEUE_ENTRY    ; size 19
 {
    .DeviceListEntry LIST_ENTRY ; 16
    .SortKey	    dd ?	; 4
    .Inserted	    db ?	; 1      ; BOOLEAN
 }



struc DRIVER_OBJECT
 {
    .Type	      dw ?
    .Size	      dw ?
                           .padding_raw1 dd ?

    ;
    ; The following links all of the devices created by a single driver
    ; together on a list, and the Flags word provides an extensible flag
    ; location for driver objects.
    ;

    .DeviceObject      dq ?
    .Flags	      dd ?
                           .padding_raw2 dd ?
    ;
    ; The following section describes where the driver is loaded.  The count
    ; field is used to count the number of times the driver has had its
    ; registered reinitialization routine invoked.
    ;

    .DriverStart       dq ?
    .DriverSize        dq ?
    .DriverSection     dq ?
    .DriverExtension   dq ?    ; 28

    ;
    ; The driver name field is used by the error log thread
    ; determine the name of the driver that an I/O request is/was bound.
    ;

    .DriverName       UNICODE_STRING

    ;
    ; The following section is for registry support.  Thise is a pointer
    ; to the path to the hardware information in the registry
    ;

    .HardwareDatabase  dq ?

    ;
    ; The following section contains the optional pointer to an array of
    ; alternate entry points to a driver for "fast I/O" support.  Fast I/O
    ; is performed by invoking the driver routine directly with separate
    ; parameters, rather than using the standard IRP call mechanism.  Note
    ; that these functions may only be used for synchronous I/O, and when
    ; the file is cached.
    ;

    .FastIoDispatch    dq ?

    ;
    ; The following section describes the entry points to this particular
    ; driver.  Note that the major function dispatch table must be the last
    ; field in the object so that it remains extensible.
    ;

    .DriverInit        dq ?
    .DriverStartIo     dq ?
    .DriverUnload      dq ?
    .MajorFunction     dq (IRP_MJ_MAXIMUM_FUNCTION + 1) dup (?)

} ; DRIVER_OBJECT



;
; Priority increment definitions.  The comment for each definition gives
; the names of the system services that use the definition when satisfying
; a wait.
;

;
; Priority increment used when satisfying a wait on an executive event
; (NtPulseEvent and NtSetEvent)
;

EVENT_INCREMENT 		= 1

;
; Priority increment when no I/O has been done.  This is used by device
; and file system drivers when completing an IRP (IoCompleteRequest).
;

IO_NO_INCREMENT 		= 0


;
; Priority increment for completing CD-ROM I/O.  This is used by CD-ROM device
; and file system drivers when completing an IRP (IoCompleteRequest)
;

IO_CD_ROM_INCREMENT		= 1

;
; Priority increment for completing disk I/O.  This is used by disk device
; and file system drivers when completing an IRP (IoCompleteRequest)
;

IO_DISK_INCREMENT		= 1

; end_ntifs

;
; Priority increment for completing keyboard I/O.  This is used by keyboard
; device drivers when completing an IRP (IoCompleteRequest)
;

IO_KEYBOARD_INCREMENT		= 6

; begin_ntifs
;
; Priority increment for completing mailslot I/O.  This is used by the mail-
; slot file system driver when completing an IRP (IoCompleteRequest).
;

IO_MAILSLOT_INCREMENT		= 2

; end_ntifs
;
; Priority increment for completing mouse I/O.  This is used by mouse device
; drivers when completing an IRP (IoCompleteRequest)
;

IO_MOUSE_INCREMENT		= 6

; begin_ntifs
;
; Priority increment for completing named pipe I/O.  This is used by the
; named pipe file system driver when completing an IRP (IoCompleteRequest).
;

IO_NAMED_PIPE_INCREMENT 	= 2

;
; Priority increment for completing network I/O.  This is used by network
; device and network file system drivers when completing an IRP
; (IoCompleteRequest).
;

IO_NETWORK_INCREMENT		= 2

; end_ntifs
;
; Priority increment for completing parallel I/O.  This is used by parallel
; device drivers when completing an IRP (IoCompleteRequest)
;

IO_PARALLEL_INCREMENT		= 1

;
; Priority increment for completing serial I/O.  This is used by serial device
; drivers when completing an IRP (IoCompleteRequest)
;

IO_SERIAL_INCREMENT		= 2

;
; Priority increment for completing sound I/O.  This is used by sound device
; drivers when completing an IRP (IoCompleteRequest)
;

IO_SOUND_INCREMENT		= 8

;
; Priority increment for completing video I/O.  This is used by video device
; drivers when completing an IRP (IoCompleteRequest)
;

IO_VIDEO_INCREMENT		= 1

;
; Priority increment used when satisfying a wait on an executive semaphore
; (NtReleaseSemaphore)
;

SEMAPHORE_INCREMENT		= 1

;
;  Indicates the system may do I/O to physical addresses above 4 GB.


struc IO_STATUS_BLOCK
 {
    .Status  dd ?
    label .Pointer dword at .Status
                             .padding_raw dd ?
    .Information dq ?
 }


;
;   don't 
;
struc KAPC		      ; size 83
 {
    .Type   dw ?	      ;  2
    .Size   dw ?	      ;  2
    .Spare0 dd ?	      ;  4
    .Thread dq ?	      ;  8
    .ApcListEntry LIST_ENTRY  ;  16
    .KernelRoutine  dq ?      ;  8
    .RundownRoutine dq ?      ;  8
    .NormalRoutine  dq ?      ;  8
    .NormalContext  dq ?      ;  8

    ;
    ; N.B. The following two members MUST be together.
    ;

    .SystemArgument1 dq ?     ;  8
    .SystemArgument2 dq ?     ;  8
    .ApcStateIndex   db ?     ;  1
    .ApcMode	    db ?      ;  1
    .Inserted	    db ?      ;  1
 }

;
; I/O Request Packet (IRP) definition
;

struc __TAIL
{
     .__tail db 83 dup (?)

     virtual at .__tail

      .Overlay.DriverContext dq 4 dup (?)		 ;32
       virtual at .Overlay.DriverContext
	.Overlay.DeviceQueueEntry KDEVICE_QUEUE_ENTRY    ; 19
       end virtual

       .Overlay.Thread dq ?				 ; 8
       .Overlay.AuxiliaryBuffer dq ?			 ; 8

       .___ db 24 dup (?)                                ;24 
	virtual at .___
	  .Overlay.ListEntry LIST_ENTRY       ; 16
	  .Overlay.CurrentStackLocation dq ?  ;8
	  label .Overlay.PacketType dword at .Overlay.CurrentStackLocation
	end virtual                                    
       .OriginalFileObject dq ?                          ; 8
     end virtual

     virtual at .__tail
      .Apc KAPC 				    ;83
     end virtual

     virtual at .__tail
      .CompletionKey dq ?			    ; 8
     end virtual
}

struc IRP
 {
    .Type dw ?
    .Size dw ?
                       .padding_raw1 dd ?
    .MdlAddress dq ?

    .Flags dq ?

    .AssociatedIrp.MasterIrp	  dq ?
    label .AssociatedIrp.IrpCount dword at .AssociatedIrp.MasterIrp
    label .AssociatedIrp.SystemBuffer qword at .AssociatedIrp.MasterIrp

    .ThreadListEntry LIST_ENTRY

    .IoStatus IO_STATUS_BLOCK

    .RequestorMode db ?

    .PendingReturned db ?

    .StackCount       db ?
    .CurrentLocation  db ?

    .Cancel db ?

    .CancelIrql db ?

    .ApcEnvironment db ?
    
    .AllocationFlags db ?

    .UserIosb dq ?
    .UserEvent dq ?

    .Overlay dq 2 dup (?)
    virtual at .Overlay
     .Overlay.AllocationSize LARGE_INTEGER
    end virtual

    virtual at .Overlay
     .Overlay.AsynchronousParameters.UserApcRoutine dq ?
     .Overlay.AsynchronousParameters.UserApcContext dq ?
    end virtual

    .CancelRoutine dq ?

    .UserBuffer dq ?

    ;union
    .Tail __TAIL   

 }  ; IRP

struc __IO_STACK_LOCATION_PARAMS
{
     	.__params db 32 dup (?)
	;
	; Parameters for IRP_MJ_CREATE
	;
	virtual at .__params
	    .Create.SecurityContext dq ?
	    .Create.Options	     dd ?
                                          .padding_raw1 dd ?  
	    .Create.FileAttributes  dw ?
	    .Create.ShareAccess     dw ?
                                          .padding_raw2 dd ? 
	    .Create.EaLength	     dq ?
	end virtual
	;
	; Parameters for IRP_MJ_READ and IRP_MJ_WRITE
	;
	virtual at .__params
	    .Read.Length	     dd ?
                                          .padding_raw3 dd ?       
	    .Read.Key	     dq ?
	    .Read.ByteOffset      LARGE_INTEGER
	end virtual
	virtual at .__params
	    .Write.Length	     dd ?
					  .padding_raw4 dd ?
	    .Write.Key	     dq ?
	    .Write.ByteOffset      LARGE_INTEGER
	end virtual

	;
	; Parameters for IRP_MJ_QUERY_INFORMATION
	;
	virtual at .__params
	   .QueryFile.Length		dd ?
                                          .padding_raw5 dd ?
	   .QueryFile.FileInformationClass01 dq ?				; ????????????????????????????????
	end virtual
	;
	; Parameters for IRP_MJ_DEVICE_CONTROL and IRP_MJ_INTERNAL_DEVICE_CONTROL
	;
	virtual at .__params
	    .DeviceIoControl.OutputBufferLength dd ?
                                                     .padding_raw6 dd ?
	    .DeviceIoControl.InputBufferLength	dd ?
                                                     .padding_raw7 dd ?
	    .DeviceIoControl.IoControlCode	dd ?
                                                     .padding_raw8 dd ?
	    .DeviceIoControl.Type3InputBuffer	dq ?
	end virtual
}


struc IO_STACK_LOCATION
 {
  .MajorFunction db ?
  .MinorFunction db ?
  .Flags	 db ?
  .Control	 db ?
             .padding_raw dd ?

  .Parameters __IO_STACK_LOCATION_PARAMS

  .DeviceObject   dq ?
  .FileObject	  dq ?
  .CompletionRoutine dq ? ;
  .Context        dq ?
 }
