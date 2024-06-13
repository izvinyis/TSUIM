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
                   ; �������� �������� X, Y, Z � ��������
    mov ax, [X]
    mov bx, [Y]
    mov cx, [Z]

                   ; ���� ������ ������
exchange_loop:
                   ; ����� ������ � X
    mov dx, ax
    rol dx, 8
    mov ax, dx
 
                   ; ����� ������ � Y
    mov dx, bx
    rol dx, 8
    mov bx, dx
     
                   ; ����� ������ � Z
    mov dx, cx
    rol dx, 8
    mov cx, dx
  
                       ; �������� ������� ���������� �����
    cmp ax, [X]
    jne exchange_loop

                    ; ���������� M
    add ax, bx
    sub ax, cx
                   ;sub ax, 7DFAh
                   ; ��������� � 012Bh
    cmp ax, 012Bh
    jge _label1    ; ���� M >= 012�, ������� � �/� 1

                   ; ���� M < 012�, ������� � �/� 2

_label2:
    add ax, 388Ah
    

    jmp _check_sign

_label1:
    sar ax, 1 ; ������� �� 2 �� ������
    sub ax, 0012h ; �������� 0012h
      
    jmp _check_sign

_check_sign:
    test ax, 8000h    ; �������� �� ���� �����
    jz _positive    ; ���� �������������, ������� � ���1
    jmp _negative    ; ���� �������������, ������� � ���2

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
