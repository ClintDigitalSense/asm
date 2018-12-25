SEGMENT DATA16 USE16

PMODEPAGEORGBASE EQU 40000h
LONGPAGEORGBASE EQU 70000h


; --------------------------------------- Messages ---------------------------------------
rm1 db "Real mode test, OK",0dh,0ah,"$"
pm1 db "Protected mode test, OK",0dh,0ah,"$"

; --------------------------------------- GDT ---------------------------------------
gdt_start dw gdt_size
gdt_ptr dd 0
dummy_descriptor   GDT_STR 0,0,0,0,0,0
code32_descriptor  GDT_STR 0ffffh,0,0,9ah,0cfh,0 ; 4GB 32-bit code , 9ah = 10011010b = Present, DPL 00,No System, Code Exec/Read. 0cfh access = 11001111b = Big,32bit,<resvd 0>,1111 more size
data32_descriptor  GDT_STR 0ffffh,0,0,92h,0cfh,0 ; 4GB 32-bit data,   92h = 10010010b = Presetn , DPL 00, No System, Data Read/Write
stack32_descriptor GDT_STR 0ffffh,0,0,92h,0cfh,0 ; 4GB 32-bit stack
code16_descriptor  GDT_STR 0ffffh,0,0,9ah,0,0    ; 64k 16-bit code
data16_descriptor  GDT_STR 0ffffh,0,0,92h,0,0    ; 64k 16-bit data
stack16_descriptor GDT_STR 0ffffh,0,0,92h,0,0    ; 64k 16-bit data
ldt_descriptor     GDT_STR ldt_size,0,0,82h,0,0  ; pointer to LDT,  82h = 10000010b = Present, DPL 00, System , Type "0010b" = LDT entry
code64_descriptor  GDT_STR 0ffffh,0,0,9ah,0afh,0 ; 16TB 64-bit code, 08cfh access = 01001111b = Big,64bit (0), 1111 more size
page32_descriptor  GDT_STR 0ffffh,0,0,92h,0cfh,0 ; 4GB 32-bit data,   92h = 10010010b = Presetn , DPL 00, No System, Data Read/Write
page64_descriptor  GDT_STR 0ffffh,0,0,92h,0cfh,0 ; 4GB 32-bit data,   92h = 10010010b = Presetn , DPL 00, No System, Data Read/Write
absd32_descriptor  GDT_STR 0ffffh,0,0,92h,0cfh,0 ; 4GB 32-bit data,   92h = 10010010b = Presetn , DPL 00, No System, Data Read/Write
data64_descriptor  GDT_STR 0ffffh,0,0,92h,0afh,0 ; 16TB 64-bit data, 08cfh access = 10001111b = Big,64bit (0), 1111 more size
absd64_descriptor  GDT_STR 0ffffh,0,0,92h,0afh,0 ; 16TB 64-bit data, 08cfh access = 10001111b = Big,64bit (0), 1111 more size
tssd32_descriptor  GDT_STR 0h,0,0,89h,040h,0 ; TSS segment in GDT
vmx32_descriptor   GDT_STR 0ffffh,0,0,9ah,0cfh,0 ; 4GB 32-bit code , 9ah = 10011010b = Present, DPL 00,No System, Code Exec/Read. 0cfh access = 11001111b = Big,32bit,<resvd 0>,1111 more size
gdt_size = $-(dummy_descriptor)

dummy_idx       = 0h    ; dummy selector
code32_idx      =       08h             ; offset of 32-bit code  segment in GDT
data32_idx      =       10h             ; offset of 32-bit data  segment in GDT
stack32_idx     =       18h             ; offset of 32-bit stack segment in GDT
code16_idx      =       20h             ; offset of 16-bit code segment in GDT
data16_idx      =       28h             ; offset of 16-bit data segment in GDT
stack16_idx     =       30h             ; offset of 16-bit stack segment in GDT
ldt_idx         =       38h             ; offset of LDT in GDT
code64_idx      =       40h             ; offset of 64-bit code segment in GDT
page32_idx      =       48h             ; offset of 32-bit data segment in GDT
page64_idx      =       50h             ; offset of 64-bit data segment in GDT
absd32_idx      =       58h             ; offset of 32-bit data  segment in GDT
data64_idx      =       60h             ; offset of 64-bit data segment in GDT
absd64_idx      =       68h             ; offset of 64-bit data segment in GDT
tssd32_idx      =       70h             ; TSS descriptor
vmx32_idx       =       78h             ; offset of 32-bit code  segment in GDT
data32_ldt_idx  =       04h             ; offset of 32-bit data  segment in LDT



; --------------------------------------- IDT ---------------------------------------

idt_RM_start      dw 0
idt_RM_ptr dd 0

idt_PM_start      dw             idt_size
idt_PM_ptr dd 0
interruptsall rb 256*8
;interruptsall IDT_STR 0,0,0,0,0
; rb 256 * 8
idt_size=$-(interruptsall)



; --------------------------------------- PAGE ---------------------------------------
PhysicalPagingOffset32 dd 0
PhysicalPagingOffset64 dd 0