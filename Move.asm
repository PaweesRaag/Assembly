; move.asm
section .data
    bNum  db 123
    wNum  dw 12345
    dNum  dd 1234567890
    qNum1 dq 1234567890123456789
    qNum2 dq 123456
    qNum3 dq 3.14
section .bss
section .text
    global main
main:
    push rbp              ;Function prologue
    mov  rbp,rsp          ;Function prologue
    mov  rax,-1           ;Fills the rax with 1s
    mov  al,byte[bNum]    ;Does NOT clear the upper bits of rax
    xor  rax,rax          ;Clears the rax
    mov  al,byte[bNum]    ;Now rax has correct value
    
    mov  rax,-1           ;Fills the rax with 1s
    mov  ax,word[wNum]    ;Does NOT clear the upper bits of rax
    xor  rax,rax          ;Clears the rax
    mov  ax,word[wNum]    ;Now rax has correct value
    
    mov  rax,-1           ;Fills the rax with 1s
    mov  rax,qword[qNum1] ;Does clear the upper bits of rax
    mov  [qNum2],rax      ;One operand always a register
    mov  rax,123456       ;Source operand an immediate value
    
    movsd  xmm0,[qNum3]     ;Instruction for floating point
    
    mov rsp,rbp           ;Function epilogue
    pop rbp               ;Funciton epilogue
    
    ret
    
