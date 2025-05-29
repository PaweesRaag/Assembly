;Loop.asm
extern scanf
extern printf

section .bss
    num resd 1 ;Reserve 4 bytes 
    n   resd 1
    
section .data
    msg     db "Enter a No.",0
    fmt_in  db "%d",0
    fmt_out db "%d",10,0
    
section .text
    global main
main:
    push rbp
    mov  rbp, rsp
    sub  rsp, 16 

    ;print prompt
    mov  rdi,msg
    xor  rax,rax
    call printf
    
    ;read integer
    mov  rdi,fmt_in
    mov  rsi,num
    xor  rax,rax
    call scanf
    
    ;initialize counter n=1
    mov  dword[n],1
    
start_loop:

    ;load counter n and num
    mov  eax,[n]
    mov  ebx,[num]
    
    ;compare counter n > num
    cmp eax,ebx
    jg  loop_end
    
    ;print current value
    mov  esi,eax
    mov  rdi,fmt_out
    xor  rax,rax
    call printf
    
    ;counter n++
    inc  dword[n]
    
    ;repeat loop
    jmp  start_loop
    
loop_end:
    leave
    ret
    
    
