;Pattern.asm
extern scanf
extern printf

section .bss
    n resd 1
        
section .data
    fmt_in   db "%d",0
    msg      db "Enter a no.",10,0
    fmt_out  db "%d ",0
    newline  db 10,0
    
section .text
    global main
main:
    push rbp        ;stack initialization
    mov  rbp,rsp
    sub  rbp,16
    
    mov  rdi,msg    ;Message printing
    xor  rax,rax
    call printf
                       
    mov  rdi,fmt_in ;Taking the degree as n
    mov  rsi,n
    xor  rax,rax
    call scanf
    
    mov  ecx,1      ;outer loop counter i set to 1
    
    ;Outer loop for(i=1;i<n;i++)
loop_out:
    mov  eax,[n]
    cmp  ecx,eax
    jg   exit       ;if i>n exit
    
    ;j=1
    mov  edx,1      ;inner loop counter j
    
    ;Inner loop for (j=1;j<i;j++)
loop_in:
    cmp  edx,ecx
    jg   enter     ;if j>i print newline
    
    ;print j
 
    mov  esi,edx
    mov  rdi,fmt_out
    xor  rax,rax
    call printf
    
    inc  edx
    
    jmp  loop_in
    
enter:
    mov  rdi,newline
    xor  rax,rax
    call printf
    
    
    inc  ecx
    jmp  loop_out
    
exit:
    leave
    ret
