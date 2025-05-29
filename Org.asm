;Org.asm
extern printf
extern scanf
extern exit

section .bss
    n       resd 1   ;size of array
    array   resd 100 ;array variable like arr[MAX] MAX=100
    i       resd 1   ;loop counter
    choice  resd 1   ;take the choice from user
    temp    resd 1   ;stores the temp value of i during sorting
    target  resd 1   ;the item to be searched
        
section .data
    msg1      db "Enter the no. of Elements",10,0
    msg2      db "Enter element %d:",0
    msg_menu  db "1. Sort Ascending", 10, "2. Sort Descending", 10
              db "3. Search Element", 10, "4. Print Even Numbers", 10
              db "5. Exit", 10, "Enter choice: ", 0
    msg_found db "Element found at position %d",10,0
    msg_nf    db "Element not found",10,0
    fmt_in    db "%d",0
    fmt_out   db "%d",0
    newline   db 10,0
    
section .text
    global main 
              
main:
    push rbp                  ;stack initialization
    mov  rbp,rsp
                              ;array size
    mov  rdi,msg1
    xor  rax,rax
    call printf
    
    mov  rdi,fmt_in
    mov  rsi,n
    xor  rax,rax
    call scanf
                               ;i=0
    mov  dword[i],0
    
read_loop:
    mov  eax,[i]               ;for(i=0; i<n; i++)
    mov  ebx,[n]
    cmp  eax,ebx
    jge  menu
    
    mov  rdi,msg2
    mov  esi,eax
    xor  rax,rax
    call printf
    
    mov  eax,[i]
    lea  rsi,[array + rax*4]
    mov  rdi,fmt_in
    xor  rax,rax
    call scanf                  ;scanf("%d", &array[i]);
    
    inc  dword[i]               ;i++
    jmp  read_loop
    
menu:
                                ;show menu
menu_loop:
    mov  rdi,msg_menu           ;displays the menu window
    xor  rax,rax
    call printf
    
    mov  rdi,fmt_in             ;Inputs the users choice
    mov  rsi,choice
    xor  rax,rax
    call scanf
    
    mov  eax,[choice]           ;do-while loop which continues back to the menu until 5 is pressed
    cmp  eax,1
    je   sort_asc               ;directs to sort in Ascending Order
    cmp  eax,2
    je   sort_desc              ;directs to sort in Descending order
    cmp  eax,3
    je   search                 ;directs to searching
    cmp  eax,4
    je   even                   ;directs to even printing
    cmp  eax,5
    je   end_prog               ;only way to break the loop and end program
    jmp  menu_loop
    
; ---------- Sorting Ascending ----------------
sort_asc:                                                             
    mov  dword[i],0
                                 ;for(i=0; i<n, i++)
outer_asc:
    mov  eax,[i]       
    mov  ebx,[n]
    dec  ebx
    cmp  eax,ebx
    jge  done_sort_asc
    
    mov  dword[temp],eax
    inc  dword[i]
               		         ;for(j=0; j<n-1; j++)
inner_asc:
    mov  eax,[temp]
    mov  ebx,[n]
    dec  ebx
    cmp  eax,ebx
    jge  outer_asc
    
    mov  ecx,[array + rax*4]     ;ecx = arr[j]
    mov  edx,[array + rax*4 + 4] ;edx = arr[j+1]
    cmp  ecx,edx                 ;arr[i] < arr[j+1] because ascending order   
    jle  no_swapa
    
                                 ; swap array[i] and array[i+1]
    mov  [array + rax*4],edx
    mov  [array + rax*4 +4],ecx
    
no_swapa:
    inc  dword[temp]
    jmp  inner_asc
    
done_sort_asc:
    jmp  print_all
    
; ---------- Sorting Descending ----------
sort_desc:
    mov  dword[i],0
    
outer_desc:                      ;for(i=0; i<n ;i++)
    mov  eax,[i]
    mov  ebx,[n]
    dec  ebx
    cmp  eax,ebx
    jge  done_sort_desc
    
    mov  dword[temp],eax
    inc  dword[i]   
                                 ;for(j=0; j<n-1 ;j++)
inner_desc:
    mov  eax,[temp]
    mov  ebx,[n]
    dec  ebx
    cmp  eax,ebx
    jge  outer_desc
    
    mov  ecx,[array + rax*4]     ;ecx = arr[j]
    mov  edx,[array + rax*4 + 4] ;edx = arr[j+1]  
    cmp  ecx,edx		 ;arr[j] > arr[j+1] because descending order
    jge  no_swapd
    
    ;swap array[i] and array[i+1]
    mov  [array + rax*4],edx
    mov  [array + rax*4 + 4],ecx
    
no_swapd:
    inc  dword[temp]
    jmp  inner_desc
        
done_sort_desc:
    jmp  print_all
    
; ---------- Search ----------
search:
    mov  rdi,fmt_in
    mov  rsi,target
    xor  rax,rax
    call scanf
    
    mov  dword[i],0
                                 ;for(i=0; i<n; i++) 
search_loop:
    mov  eax,[i]
    mov  ebx,[n]
    cmp  eax,ebx
    jge  not_found
    
    mov  ecx,[array + rax*4]     
    cmp  ecx,[target]
    je   found
    
    inc  dword[i]
    jmp  search_loop
    
found:
    mov  rdi,msg_found
    mov  esi,[i]
    xor  rax,rax
    call printf
    mov  rdi,newline            ;for better visibility a newline
    xor  rax,rax
    call printf
    jmp  menu_loop
    
not_found:
    mov  rdi,msg_nf
    xor  rax,rax
    call printf
    jmp  menu_loop
    
; ---------- Even Numbers ----------    
even:
    mov  dword[i],0
    
even_loop:
    mov  eax,[i]
    mov  ebx,[n]
    cmp  eax,ebx
    jge  menu_loop
    
    mov  ebx,[array + rax*4]
    test bl,1                   ;checks the lsb bit with 1 and triggers ZF
    jnz  not_even
    
    mov  rdi,fmt_out
    mov  esi,ebx
    xor  rax,rax
    call printf
    mov  rdi,newline
    xor  rax,rax
    call printf
    
not_even:
    inc  dword[i]
    jmp  even_loop
    
; ---------- Print All --------------
print_all:
    mov  dword[i],0
    
print_loop:
    mov  eax,[i]
    mov  ebx,[n]
    cmp  eax,ebx
    jge  menu_loop
    
    mov  esi,[array + rax*4]
    mov  rdi,fmt_out
    xor  rax,rax
    call printf
    mov  rdi,newline
    xor  rax,rax
    call printf    
    
    inc  dword[i]
    jmp  print_loop
    
; ------------ Exit ------------------
end_prog:
    mov  rdi,0
    call exit  
    
