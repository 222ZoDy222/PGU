;   Created by ahilles     
;                           01.01.2007
;    E-Mail:    Ahilles1806@rambler.ru


BASE_FUNCTION equ 800h

macro IOCTL_DEFINE _NAME, _Device, _Access, _Function, _Method
  {
     _NAME equ (_Device shl 16) or (_Access shl 14) or ((_Function+BASE_FUNCTION) shl 2) or (_Method)
   } 
   
macro IOCTL_DEFINE_EX _NAME, _Access, _Function, _Method
  {
    if _Function<=07FFh
    IOCTL_DEFINE _NAME, 00000022h, _Access, _Function, _Method
    else
    end if
  }   
  
macro Init_OA _STRUCT_NAME, _Size, _Name, _Attr, _Seq_Attr, _Root_Dir
  {
    mov [_STRUCT_NAME#.Length], _Size
    mov [_STRUCT_NAME#.RootDirectory], _Root_Dir
    mov [_STRUCT_NAME#.Attributes], _Attr
    mov [_STRUCT_NAME#.ObjectName], _Name
    mov [_STRUCT_NAME#.SecurityDescriptor], _Seq_Attr
    mov [_STRUCT_NAME#.SecurityQualityOfService], 0h

  }

macro Init_OA_EX _STRUCT_NAME, _Name, _Attr
  {
    Init_OA _STRUCT_NAME, 18h, _Name, _Attr, 0h,0h
  }  