num equ 5

jmp read0
db 0x90
db "libcarst"
dw 512
db 1
dw 1
db 2
dw 224
dw 2880
db 0xf0
dw 9
dw 18
dw 2
dd 0
dd 2880
db 0,0,0x29
dd 0xffffffff
db "libcarst   "
db "gsfsr   "
resb 18

read0:
mov ax,0
mov ss,ax
mov sp,0x7c00
mov ds,ax

mov ax,512
mov es,ax
mov ch,0
mov dh,0
mov cl,2
jmp read1

read0r:
mov si,0
jmp iplends

read1:
mov al,num
mov dl,0
mov ah,0x02
int 13h
jnc iplends
add si,1
cmp si,3
jae fins
mov dl,0
mov ah,0
int 13h
jmp read1

iplends:
mov ax,es
add ax,0x20
mov es,ax
add ch,1
cmp ch,num
jb read0r
je really

really:
mov si,0
mov di,0
mov [0x0ff0],ch
jmp start

fins:
hlt
jmp fins

times  510-($-$$) db 0
db 0x55,0xaa

start:
mov edx,0
mov eax,0
mov esp,10000
mov di,0
mov si,0
mov ax,0
mov gs,ax
mov fs,ax
mov al,"T"
call p
mov al,"-"
call p
mov al,"O"
call p
mov al,"S"
call p
mov al,"!"
call p
call e

main:
mov al,"Z"
call p
mov al,":"
call p
mov al,">"
call p
jmp input

input:
call j
cmp al,"a"
je a
cmp al,"f"
je files
cmp al,"c"
je check
cmp al,"n"
je ned
cmp al,"l"
je last
cmp al,"r"
je rens
cmp al,"d"
je dels
cmp al,"e"
je efs
cmp al,"0"
je ass
cmp al,0x0d
je end
cmp al,"g"
je gctr
jne error

gctr:
call j
cmp al,"c"
jne error
call j
cmp al,"t"
jne error
call j
cmp al,"r"
jne error
call j
cmp al," "
jne error
call j
mov dl,al
call k
call e
mov si,0
jmp g1

g1:
cmp byte[si],dl
je g2
add si,1
jmp g1

g2:
add si,1
cmp byte[si],0x07
je g3
jne g1

g3:
add si,1
mov al,byte[si]
cmp al,27
je g4
call p
jmp g3

g4:
sub di,1
jmp g5

g5:
call k
mov byte[di],al
cmp al,27
je endsss
call p
add di,1
jmp g4

files:
call j
cmp al,"i"
jne error
call j
cmp al,"l"
jne error
call j
cmp al,"e"
jne error
call j
cmp al,"s"
jne error
call j
cmp al," "
jne error
call j
mov byte[di],al
add di,1
mov byte[di],0x07
add di,1
call k
call e
jmp filesr

filesr:
call k
mov byte[di],al
cmp al,27
je f2
cmp al,0x0d
je f4
cmp al,08
je f5
call p
add di,1
cmp di,31
je f3
jmp filesr

f4:
mov al,0ah
add di,1
cmp di,31
je f3
mov byte[di],al
call p
mov al,0dh
add di,1
cmp di,31
je f3
mov byte[di],al
call p
add di,1
jmp filesr

f3:
add di,101
jmp filesr

f2:
add di,1
jmp end

f5:
mov al,08
cmp di,31
je f6
jmp f5r

f5r:
sub di,1
mov byte[di],al
call p
jmp f7

f7:
mov al," "
mov byte[di],al
call p
jmp f8

f8:
mov al,08
mov byte[di],al
call p
jmp filesr

f6:
sub di,100
jmp f5r

ass:
call k
call e
jmp sss1
 
sss1:
mov si,0
jmp sss2

sss2:
mov al,byte[gs:si]
call p
add si,1
cmp si,101
je endsss
jmp sss2

efs:
call j
cmp al,"f"
jne error
call j
cmp al,"s"
jne error
call j
cmp al," "
jne error
call j
mov dl,al
call k
call e
mov si,0
jmp s1

s1:
cmp byte[si],dl
je s2
add si,1
cmp si,1060
je endsss
jmp s1

s2:
add si,1
cmp byte[si],0x07
je s3
jne s1

s3:
add si,1
mov al,byte[si]
cmp al,"|"
je s4
cmp al,"b"
je s6
cmp al,"v"
je s7
cmp al,"6"
je s8
cmp al,"i"
je s12
cmp al,"}"
je s22
cmp al,"f"
je s26
cmp al,"r"
je s30
cmp al,"d"
je s34
cmp al,"w"
je s41
cmp al,"@"
je s43
cmp al,"c"
je s46
cmp al,"a"
je s51
cmp al,"0"
je endsss
cmp al,27
je endsss
jmp s3

s4:
add si,1
cmp si,31
je s5
mov al,byte[si]
cmp al,"|"
je s3
call p
jmp s4

s5:
add si,101
jmp s4

s6:
mov al,07h
call p
jmp s3

s7:
add si,1
mov al,byte[si]
mov byte[gs:eax],al
add si,1
add eax,1
mov al,byte[si]
mov byte[gs:eax],al
add eax,1
jmp s3

s8:
mov edx,0
jmp s8r

s8r:
add si,1
jmp s8rr

s8rr:
mov al,byte[si]
cmp byte[gs:edx],al
je s11
add edx,1
jmp s8rr

s11:
add edx,1
mov al,byte[gs:edx]
call p
mov edx,0
jmp s3

s12:
add si,1
mov al,byte[si]
jmp s13

s13:
cmp byte[edx],al
je s14
add edx,1
jmp s13

s14:
add edx,1
mov dl,byte[gs:edx]
jmp s15

s15:
add si,1
mov ch,byte[si]
jmp s18

s18:
add si,1
cmp byte[si],"0"
je s19
cmp byte[si],"1"
je s23
cmp byte[si],"2"
je s24
cmp byte[si],"3"
je s25

s19:
cmp dl,ch
je s20
jne s21

s20:
jmp s3

s21:
add si,1
cmp byte[si],"}"
je s3
jmp s21

s22:
jmp s3

s23:
cmp dl,ch
jb s20
jne s21

s24:
cmp dl,ch
jne s20
je s21
jb s21
ja s21

s25:
cmp dl,ch
ja s20
jne s21

s26:
add si,1
mov al,byte[si]
mov byte[di],al
add di,1
mov byte[di],0x07
add di,1
jmp s27

s27:
add si,1
mov al,byte[si]
cmp al,"$"
je s29
mov byte[di],al
add di,1
cmp di,31
je s28
jmp s27

s28:
add di,101
jmp s27

s29:
mov byte[di],27
add di,1
jmp s3

s30:
add si,1
mov dl,byte[si]
add si,1
mov ch,byte[si]
mov esp,0
jmp s31

s31:
cmp byte[esp],dl
je s32
add esp,1
jmp s31

s32:
add esp,1
cmp byte[esp],0x07
je s33
jne s31

s33:
sub esp,1
mov byte[esp],ch
mov esp,0
jmp s3

s34:
mov sp,si
add si,1
mov dl,byte[si]
mov si,0
jmp s35

s35:
cmp byte[si],dl
je s36
add si,1
jmp s35

s36:
add si,1
cmp byte[si],0x07
je s37
jne s35

s37:
sub si,2
mov byte[si],0
add si,1
mov byte[si],0
jmp s38

s38:
add si,1
cmp byte[si],27
je s39
mov byte[si],0
cmp si,31
je s40
jmp s38

s40:
add si,101
jmp s38

s39:
mov byte[esp],0
sub si,ax
sub di,si
sub di,2
mov si,sp
mov sp,0
add si,1
jmp s3

s41:
add si,1
mov dl,byte[si]
mov ch,0
jmp s42

s42:
add si,1
jmp s3

s43:
add ch,1
cmp ch,dl
je s461
jmp s44

s461:
mov dl,0
mov ch,0
jmp s3

s44:
sub si,1
cmp byte[si],"@"
je s45
jmp s44

s45:
jmp s3

s46:
add si,1
mov dl,byte[si]
mov esp,0
jmp s47

s47:
cmp byte[esp],dl
je s48
add esp,1
jmp s47

s48:
add esp,1
cmp byte[esp],0x07
je s49
jne s47

s49:
add esp,1
mov al,byte[esp]
cmp al,27
je s3
call p
cmp esp,31
je s50
jmp s49

s50:
add esp,101
jmp s49

s51:
mov edx,0
add si,1
mov al,byte[si]
jmp s51r

s51r:
cmp byte[gs:edx],al
je s52
add edx,1
jmp s51r

s52:
add edx,1
add si,1
mov al,byte[si]
mov byte[gs:edx],al
mov edx,0
jmp s3

dels:
call j
cmp al,"e"
jne error
call j
cmp al,"l"
jne error
call j
cmp al," "
jne error
call j
mov dl,al
call k
call e
mov si,0
jmp d1

d1:
cmp byte[si],dl
je d2
add si,1
cmp si,1060
je endsss
jmp d1

d2:
add si,1
cmp byte[si],0x07
je d3r
jne d1

d3r:
mov ax,si
sub si,2
mov byte[si],0
add si,1
mov byte[si],0
jmp d3

d3:
add si,1
cmp byte[si],27
je d4
mov byte[si],0
cmp si,31
je d5
jmp d3

d4:
mov byte[si],0
sub si,ax
sub di,si
sub di,2
mov ax,0
jmp endsss

d5:
add si,101
jmp d3

rens:
call j
cmp al,"e"
jne error
call j
cmp al,"n"
jne error
call j
cmp al," "
jne error
call j
mov dl,al
call j
cmp al," "
jne error
call j
mov ch,al
call k
call e
mov si,0
jmp r1

r1:
cmp byte[si],dl
je r2
add si,1
cmp si,1060
je endsss
jmp r1

r2:
add si,1
cmp byte[si],0x07
je r3
jne r1

r3:
sub si,1
mov byte[si],ch
jmp endsss

last:
call j
cmp al,"a"
jne error
call j
cmp al,"s"
jne error
call j
cmp al,"t"
jne error
call k
call e
mov si,0
jmp last1

last1:
mov al,byte[si]
call p
add si,1
cmp si,205
je endsss
jmp last1

ned:
call j
cmp al,"e"
jne error
call j
cmp al,"d"
jne error
call k
call e

mov si,0
jmp n1

n1:
cmp byte[si],0x07
je n2
add si,1
cmp si,1060
je endssss
jmp n1

endssss:
mov si,0
jmp main

n2:
sub si,1
mov al,byte[si]
call p
call tab
mov al,"<"
call p
mov al,"N"
call p
mov al,"E"
call p
mov al,"D"
call p
mov al,">"
call p
call tab
mov al,"."
call p
mov al,"I"
call p
mov al,"C"
call p
mov al,"T"
call p
call e
add si,2
jmp n1

check:
call j
cmp al,"h"
jne error
call j
cmp al,"e"
jne error
call j
cmp al,"c"
jne error
call j
cmp al,"k"
jne error
call j
cmp al," "
jne error
call j
mov dl,al
call k
call e
jmp c1

c1:
mov si,0
jmp c2

c2:
cmp byte[si],dl
je c3
add si,1
cmp si,2000000
je endsss
jmp c2

c3:
add si,1
cmp byte[si],0x07
je c4
jne c2

c4:
add si,1
cmp si,31
je c5
mov al,byte[si]
cmp al,27
je endsss
call p
jmp c4

c5:
add si,101
jmp c4

a:
call k
call e

mov al,"A"
call p
jmp end

error:
call k
call e

mov al,"?"
call p
jmp end

endsss:
mov si,0
jmp end

p:
mov ah,0x0e
int 10h
ret

j:
mov ah,0
int 16h
mov ah,0x0e
int 10h
ret

k:
mov ah,0
int 16h
ret

end:
call e
jmp main

e:
mov al,0ah
call p
mov al,0dh
call p
ret

tab:
mov al," "
call p
mov al," "
call p
mov al," "
call p
mov al," "
call p
ret

b:
mov al,08h
call p
mov al,20h
call p
mov al,08h
call p
ret

bios:
times  1474560-($-$$) db 0
