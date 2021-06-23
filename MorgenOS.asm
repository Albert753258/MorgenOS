use16
org 0x7c00
start:
  jmp 0x0000:entry              ;
entry:
  mov ax, cs
  mov ds, ax
 

  mov ax, 0x0003
  int 0x10
 

  in  al, 0x92
  or  al, 2
  out 0x92, al
 

  lgdt  [gdtr]

  cli

  in  al, 0x70
  or  al, 0x80
  out 0x70, al
 

  mov  eax, cr0
  or   al, 1
  mov  cr0, eax
 

  O32 jmp 00001000b:pm_entry
 

use32

pm_entry:
  mov  ax, cs
  mov  ds, ax
  mov  es, ax
 
  mov  edi, 0xB8000
  mov  esi, msg
  cld
.loop
  lodsb
  test al, al
  jz   .exit
  stosb
  mov  al, 7
  stosb
  jmp  .loop
.exit
 
  jmp  $
 
msg:
  db  'First beta MorgenOS release', 0
 
gdt:
  db  0x00, 0x00, 0x00, 0x00, 0x00,      0x00,      0x00, 0x00 
  db  0xFF, 0xFF, 0x00, 0x00, 0x00, 10011010b, 11001111b, 0x00
gdt_size  equ $ - gdt

gdtr:
  dw  gdt_size - 1
  dd  gdt
 
finish:
times 0x1FE-finish+start db 0
db   0x55, 0xAA
