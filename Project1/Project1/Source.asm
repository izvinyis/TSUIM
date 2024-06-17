.686
.model flat,stdcall

.stack 100h

.data;
x dd 87
y dd 60
z dd -2
sdvy dd ?
M dd ?
vich dd ?
slzh dd ?
ymn dd ?
.code
ExitProcess PROTO STDCALL :DWORD
Start:

mov eax, y
mov sdvy, eax
ror sdvy, 2

ror x, 2

mov eax, x
sub eax, y
mov vich, eax

mov eax, z
and eax, sdvy
mov ymn, eax

 mov eax, vich
 add eax, ymn
 mov M, eax



exit:
Invoke ExitProcess,M
End Start