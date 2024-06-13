.686
.model flat, stdcall
.stack 100h

.data
    array DWORD 1, 2, 3, 4, 5, 6, 7, 8, 9, 14, 24, 23, 61, 22, 61, 22, 33, 44   ;массив
    array_length = ($ - array) / 4 ;  длина массива
    target_mask DWORD 1101b ; бинарная маска для сравнения

.code
ExitProcess PROTO STDCALL :DWORD

Start:
    xor ecx, ecx            ; счетчик
    xor eax, eax            ; тут будет храниться сумма

sum_loop:
    cmp ecx, array_length  ; достигли ли конца массива
    jge done

    mov edx, DWORD PTR [array + ecx*4] ; Зтекущий элемент массива в регистр edx

    and edx, [target_mask] ; есть ли в этом элементе комбинация 1101
    cmp edx, [target_mask]
    jne skip_add_to_sum

    add eax, DWORD PTR [array + ecx*4] ; добавляем текущий элемент к сумме если да

    fld dword ptr [array + ecx*4]  ; 
    faddp st(1), st(0)

skip_add_to_sum:
    inc ecx                 ;следующий элемент массива + счетчик для подсчета длины 
    jmp sum_loop

done:
    push  eax    ;ecx - кол-во элементов в массиве по счетчику\ array_length - кол-во элементов массива\ eax - сумма нужных элементов массива        
    call ExitProcess       
    ret                    

end Start
