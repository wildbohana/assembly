# assembly

.section .data
  prompt: .ascii "all i wanna do is get high by the beach\0"
  prompt_l = .- prompt
.section .text
.globl main

main:
  movl $4, %eax
  movl $1, %ebx
  movl $prompt, %ecx
  movl $primpt_l, %edx
  int $0x80
kraj:
  movl $1, %eax
  movl $0, %ebx
  int $0x80
