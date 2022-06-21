section .data
    msg_hello_text   db "Trying to alocate memory",0xa
    msg_hello_size equ $-msg_hello_text
        
    msg_sucess_text  db "Alocated 127 bytes sucessufully",0xa
    msg_sucess_size equ $-msg_sucess_text
    
    msg_failure_text  db "Failed to alocate memory",0xa
    msg_failure_size equ $-msg_failure_text

section .text
    global _start
    
_start:
    ;   sys_write() 
    mov eax, 0x4
    mov ebx, 0x1
    mov ecx, msg_hello_text
    mov edx, msg_hello_size
    int 0x80

    ;   sys_brk(0) - Gets the current location of data break
    mov eax, 45;
    xor ebx, ebx;
    int 0x80

    ;   sys_brk(127)
    add eax, 127;
    mov ebx, eax;
    mov eax, 45;
    int 0x80
    
    ; Checks the return code of sys_brk
    ; so it exits if the code is less than zero
    cmp eax, 0x0
    jl _failure
    
    ; sys_write
    mov eax, 0x4
    mov ebx, 0x1
    mov ecx, msg_sucess_text
    mov edx, msg_sucess_size
    int 0x80
    jmp _exit
_failure:
    mov eax, 0x4
    mov ebx, 0x1
    mov ecx, msg_failure_text
    mov edx, msg_failure_size
_exit:
    ;   sys_exit
    mov eax, 0x1
    mov ebx, 0x0
    int 0x80
