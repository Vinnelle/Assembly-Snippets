section .data
    buffer db 256  ; Buffer to store the memory contents
    filename db "dump.bin", 0  ; Output file name

section .text
    global _start

_start:
    ; Open the output file
    mov eax, 5  ; sys_open system call
    mov ebx, filename
    mov ecx, 2  ; O_WRONLY flag
    int 0x80

    ; Check if file opened successfully
    cmp eax, -1
    je exit

    ; Read memory contents into the buffer
    mov eax, 3  ; sys_read system call
    mov ebx, 0  ; STDIN_FILENO
    mov ecx, buffer
    mov edx, 256
    int 0x80

    ; Write memory contents to the output file
    mov eax, 4  ; sys_write system call
    mov ebx, eax  ; Use the file descriptor returned by sys_open
    mov ecx, buffer
    mov edx, 256
    int 0x80

    ; Close the output file
    mov eax, 6  ; sys_close system call
    mov ebx, eax  ; Use the file descriptor returned by sys_open
    int 0x80

exit:
    ; Exit the program
    mov eax, 1  ; sys_exit system call
    xor ebx, ebx  ; Exit status 0
    int 0x80
