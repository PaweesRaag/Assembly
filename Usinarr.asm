;usinarr.asm
extern printf
extern scanf

section .bss
    n     resd 1   ;variable to store array size
    array resd 100 ;arrays with 100 integers max like arr[MAX]
    i     resd 1   ;loop counter
    
section .data
    msg1    db "Enter the size of Array",10,0
    fmt_in  db "%d",0
    msg2    db "Enter element %d: ",0
    fmt_out db "You entered: %d",10,0
    
section .text
    global main
main:
    push rbp
    mov  rbp,rsp
    sub  rbp,16
    
    mov  rdi,msg1  ;Print -> Enter the size 
    xor  rax,rax
    call printf
    
    mov  rdi,fmt_in ;Accepts the size
    mov  rsi,n
    xor  rax,rax
    call scanf
    
    mov  dword[i],0 ;set i=0
    
read_loop:
    mov  eax,[i]
    mov  ebx,[n]
    cmp  eax,ebx   
    jge  print_loop;when i>=n exits to print
    
    mov  rdi,msg2  ;print "Enter no. %d"
    mov  esi,eax
    xor  rax,rax
    call printf
    
    mov  eax,[i]
    lea  rsi,[array + rax*4]
    mov  rdi,fmt_in;takes the elements of array
    xor  rax,rax
    call scanf     ;scanf("%d", &array[i]);
    
    inc  dword[i]  ;i++
    jmp  read_loop
    
print_loop:
    mov  dword[i],0
    
print_each:
    mov  eax,[i]   ;Re-initializing the loop
    mov  ebx,[n] 
    cmp  eax,ebx
    jge  exit
    
    mov  eax,[i]   ;loading the array
    mov  esi,[array + rax*4]
    mov  rdi,fmt_out
    xor  rax,rax
    call printf
    
    inc  dword[i]
    jmp  print_each
    
exit:
    leave
    ret
    
    
