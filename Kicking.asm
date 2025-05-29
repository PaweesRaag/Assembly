;kicking 
section .data
        msg1 db "Hello World!",10,0      ; String with NL and 0
        lenmsg1 equ $-msg1-1             ; Length of string in msg1
        msg2 db "Kicking and Alive",10,0 ; String with NL and 0
        lenmsg2 equ $-msg2-1             ; Length of string in msg2
        radius dq 357                    ; no string, not displayable?
        pi dq 3.14                       ; no string, not displayable?
        
section .bss
section .text
        global main
main:
    push rbp            ; function prologue
    mov rbp,rsp        ; function prologue
    mov rax,1           ; 1 = write
    mov rdi,1           ; 1 = to stdout
    mov rsi,msg1        ; string to display
    mov rdx,lenmsg1     ; length of string of msg1
    syscall             ; String displayed
    mov rax,1           ; 1 = write this is set because syscall cleared everything
    mov rdi,1           ; 1 = to stdout same reason
    mov rsi,msg2        ; string to display
    mov rdx,lenmsg2     ; length of the string of msg2
    syscall             ; string displayed
    mov rsp,rbp         ; function epilogue
    pop rbp             ; function epilogue
    mov rax,60          ; 60 = exit
    mov rdi,0           ; 0
    syscall
