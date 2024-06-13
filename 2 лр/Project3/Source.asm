.686
.model flat,stdcall
.stack 100h

.data
  X dw 99C5h
  Y dw 2A6Ch
  Z dw 80CFh
  R dw ?
  G dw ?


.code
ExitProcess PROTO STDCALL :DWORD
Start:

    xor Eax,Eax 
	xor Edx,Edx
	xor Ecx,Ecx
	xor Ebx,Ebx;

_start:
                   ; Загрузка значений X, Y, Z в регистры
    mov ax, [X]
    mov bx, [Y]
    mov cx, [Z]

                   ; Цикл обмена байтов
exchange_loop:
                   ; Обмен байтов в X
    mov dx, ax
    rol dx, 8
    mov ax, dx
 
                   ; Обмен байтов в Y
    mov dx, bx
    rol dx, 8
    mov bx, dx
     
                   ; Обмен байтов в Z
    mov dx, cx
    rol dx, 8
    mov cx, dx
  
                       ; Проверка условия завершения цикла
    cmp ax, [X]
    jne exchange_loop

                    ; Вычисление M
    add ax, bx
    sub ax, cx
                   ;sub ax, 7DFAh
                   ; Сравнение с 012Bh
    cmp ax, 012Bh
    jge _label1    ; Если M >= 012В, переход к п/п 1

                   ; Если M < 012В, переход к п/п 2

_label2:
    add ax, 388Ah
    

    jmp _check_sign

_label1:
    sar ax, 1 ; деление на 2 со знаком
    sub ax, 0012h ; вычитаем 0012h
      
    jmp _check_sign

_check_sign:
    test ax, 8000h    ; Проверка на знак числа
    jz _positive    ; Если положительное, переход к АДР1
    jmp _negative    ; Если отрицательное, переход к АДР2

_positive:
    or ax, 0FF0h    ; R = R or 0FF0h
    jmp _end

_negative:
    xor ax, 5555h    ; R = -R xor 5555h
                       ; neg ax
                       ; mov G, ax
     jmp _end

_end:
mov R,ax

exit:
Invoke ExitProcess,R
End Start
