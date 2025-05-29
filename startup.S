.section .text.boot
.global _start
.type _start, %function

_start:
    ldr     x0, =__stack_top     // 스택 포인터 초기화
    mov     sp, x0

    bl      main                 // main 함수 호출

hang:
    wfi
    b hang