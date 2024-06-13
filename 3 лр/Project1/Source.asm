.686
.model flat, stdcall
.stack 100h

.data
    array DWORD 1, 2, 3, 4, 5, 6, 7, 8, 9, 14, 24, 23, 61, 22, 61, 22, 33, 44   ;������
    array_length = ($ - array) / 4 ;  ����� �������
    target_mask DWORD 1101b ; �������� ����� ��� ���������

.code
ExitProcess PROTO STDCALL :DWORD

Start:
    xor ecx, ecx            ; �������
    xor eax, eax            ; ��� ����� ��������� �����

sum_loop:
    cmp ecx, array_length  ; �������� �� ����� �������
    jge done

    mov edx, DWORD PTR [array + ecx*4] ; �������� ������� ������� � ������� edx

    and edx, [target_mask] ; ���� �� � ���� �������� ���������� 1101
    cmp edx, [target_mask]
    jne skip_add_to_sum

    add eax, DWORD PTR [array + ecx*4] ; ��������� ������� ������� � ����� ���� ��

    fld dword ptr [array + ecx*4]  ; 
    faddp st(1), st(0)

skip_add_to_sum:
    inc ecx                 ;��������� ������� ������� + ������� ��� �������� ����� 
    jmp sum_loop

done:
    push  eax    ;ecx - ���-�� ��������� � ������� �� ��������\ array_length - ���-�� ��������� �������\ eax - ����� ������ ��������� �������        
    call ExitProcess       
    ret                    

end Start
