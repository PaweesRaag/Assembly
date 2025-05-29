;Arithematic.asm
extern scanf
extern printf

section .bss
    num1   resd 1
    num2   resd 1
    result resd 1
    op     resd 1
    
section .data
    msg1    db "Enter 1st no.",10,0
    msg2    db "Enter 2nd no.",10,0
    msg3    db "Enter the opertation (+-/*)",10,0
    fmt_in  db "%d",0
    fmt_op  db " %c",0
    fmt_out db "Result= %d",10,0
    
section .text
    global main
main:
    push rbp
    mov  rbp,rsp
    sub  rsp,16
    
    mov  rdi,msg1
    xor  rax,rax
    call printf
    
    mov  rdi,fmt_in
    mov  rsi,num1
    xor  rax,rax
    call scanf
    
    mov  rdi,msg2
    xor  rax,rax
    call printf
    
    mov  rdi,fmt_in
    mov  rsi,num2
    xor  rax,rax
    call scanf
    
    mov  rdi,msg3
    xor  rax,rax
    call printf
    
    mov  rdi,fmt_op
    lea  rsi,[rel op] ;let's assume op is a box doing <mov rsi,op> would be like "Get what's inside the box." but <lea rsi,[rel op]> means "Give me the location of the box.". This is because Scanf needs to know where to put something, not what’s already in the box. 
    xor  rax,rax
    call scanf        ;scanf(" %c", &op);
    
    mov  eax,[num1]
    mov  ebx,[num2]
    mov  cl ,[op]
    
    cmp  cl ,'+'
    je   do_add
    cmp  cl ,'-'
    je   do_sub
    cmp  cl ,'/'
    je   do_div
    cmp  cl ,'*'
    je   do_mul
    
    jmp  exit
    
do_add:
    add  eax,ebx   ;eax+ebx -> eax
    jmp  in_result
    
do_sub:
    sub  eax,ebx
    jmp  in_result
    
do_mul:
    imul  eax,ebx
    jmp  in_result
    
do_div:
    ;Handles div by zero
    cmp  ebx,0
    je   exit
    xor  edx,edx   ;Clears edx. This is important because idiv (signed division) uses both edx:eax as the full numerator.full numerator = edx:eax  (edx is the high part, eax is the low part)
    idiv ebx
    jmp  in_result
    
in_result:
    mov  [result],eax
    
    ;Print result
    mov  eax,[result]
    mov  esi,eax
    mov  rdi,fmt_out
    xor  rax,rax
    call printf
    
exit:
    leave
    ret
    
    
    
