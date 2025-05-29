;Conditions.asm
extern scanf
extern printf
section .bss
    num1 resq 1
    num2 resq 1
section .data
    msg     db "Enter 2 no.s for comparison: ",0         ;0 means null terminator
    fmt_in  db "%ld %ld",0                            ;10 means newline and 0 means null    
    fmt_je  db "== Equal (JE)",10,0
    fmt_jne db "!= Not Equal (JNE)",10,0
    fmt_jg  db "> Greater (JG)",10,0
    fmt_jge db ">= Greater or Equal (JGE)",10,0
    fmt_jl  db "< Less (JL)",10,0
    fmt_jle db "<= Less or Equal (JLE)",10,0
    fmt_ja  db "> Unsigned Greater (JA)",10,0
    fmt_jae db ">= Unsigned Greater or Equal (JAE)",10,0
    fmt_jb  db "< Unsigned Less (JB)",10,0
    fmt_jbe db "<= Unsigned Less or Equal (JBE)",10,0
section .text
    global main
main:
    push rbp        ;essential don't forget initializing the stack else may cause seg_fault
    mov  rbp, rsp
    sub  rsp, 16 
    
    mov  rdi,msg    ;First argument is always put in rdi according to SystemV AMD64 Calling Convention
    xor  rax,rax  
    call printf
    
    mov  rdi,fmt_in ;Similarly first argument
    mov  rsi,num1   ;Second argument store num1 address
    mov  rdx,num2   ;Third argument 4th->rcx 5th->r8 6th->r9
    xor  rax,rax    ;scanf needs rax=0 to indicate no xmm registers are used
    call scanf      ;call scanf("%ld %ld", &num1, &num2)
    
    mov  rax,[num1] ;Stores the value at the address num1 ie: the user input no
    mov  rbx,[num2] ;similar to above
    
    cmp  rax,rbx    ;compares the two numbers
    je   do_je      ;Equals
    
    cmp  rax,rbx
    jne  do_jne     ;Not equals
    
    cmp rax,rbx
    jg  do_jg       ;Greater than
    
    cmp rax,rbx  
    jge do_jge      ;Greater than equals
    
    cmp rax,rbx
    jl  do_jl       ;Less than
    
    cmp rax,rbx
    jle do_jle      ;Less than equals
    
    cmp rax,rbx
    ja  do_ja       ;Greater than unsigned
    
    cmp rax,rbx
    jae do_jae      ;Greater than equals unsigned
    
    cmp rax,rbx
    jb  do_jb       ;Less than unsigned
    
    cmp rax,rbx
    jbe do_jbe      ;less than equals unsigned
    
do_je:
    mov  rdi,fmt_je  ;inserts message of Equals to
    xor  rax,rax     ;necessary step to indicate no floating values are used
    call printf
    ;jmp  exit
    
do_jne:
    mov  rdi,fmt_jne ;inserts message of Not Equals to
    xor  rax,rax     ;necessary step to indicate no floating values are used
    call printf
    ;jmp  exit
    
do_jg:
    mov  rdi,fmt_jg
    xor  rax,rax
    call printf
    jmp  exit
    
do_jge:
    mov  rdi,fmt_jge
    xor  rax,rax
    call printf
    ;jmp  exit
    
do_jl:
    mov  rdi,fmt_jl
    xor  rax,rax
    call printf
    jmp  exit
    
do_jle:
    mov  rdi,fmt_jle
    xor  rax,rax
    call printf
    jmp  exit
    
do_ja:
    mov  rdi,fmt_ja
    xor  rax,rax
    call printf
    jmp  exit
    
do_jae:
    mov  rdi,fmt_jae
    xor  rax,rax
    call printf
    jmp  exit
    
do_jb:
    mov  rdi,fmt_jb
    xor  rax,rax
    call printf
    jmp  exit
    
do_jbe:
    mov  rdi,fmt_jbe
    xor  rax,rax
    call printf
    jmp  exit
    
exit:
    leave
    ret
