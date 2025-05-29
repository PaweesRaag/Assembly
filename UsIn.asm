;UsIn.asm
section .bss
    input resb 100        ;stores 100 bytes for user input
section .data
    msg db "Enter a no. " ;message to display
    len equ $-msg-1       ;length of the message
section .text
    global main
main:
    mov rax, 1           ;1 = write
    mov rdi, 1           ;1 = sysout
    mov rsi, msg         ;puts the message to display
    mov rdx, len         ;shifts the rdi by the length of the message
    syscall              ;the message is displayed
    
    mov rax, 0           ;0 = read to read the user input
    mov rdi, 0           ;0 = sysin
    mov rsi, input       ;"input" to store input
    mov rdx, 100         ;no. of bytes to read
    syscall              ;to successfully read the user input
    
    mov rdx, rax         ;puts the bytes read and held by rax in rdx
    
    mov rax, 1           ;1 = write
    mov rdi, 1           ;1 = sysout
    mov rsi, input       ;"input" to print
    syscall              ;printed
    
    mov rax, 60          ;60 = sys_exit
    xor rdi, rdi         ;rdi cleared
    syscall
