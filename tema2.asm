extern puts
extern printf
extern strlen

%define BAD_ARG_EXIT_CODE -1

section .data
filename: db "./input0.dat", 0
inputlen: dd 2263

fmtstr:            db "Key: %d",0xa, 0
usage:             db "Usage: %s <task-no> (task-no can be 1,2,3,4,5,6)", 10, 0
error_no_file:     db "Error: No input file %s", 10, 0
error_cannot_read: db "Error: Cannot read input file %s", 10, 0

section .text
global main

xor_strings:
	; TODO TASK 1
    push ebp
    mov ebp, esp
    xor edi, edi
    mov ecx, dword [esp + 8] ;se pastreaza tot sirul (cuvantul si cheia)
    
loop_1:
    mov al, byte [ecx + edi] 
    inc edi 
    cmp al, 0                   ;cand se ajunge la cheie se opreste
    jne loop_1
    je iesire
    
iesire:
    mov eax, ecx                
    add eax, edi                ;in eax se pastreaza cheia
    xor edi, edi
    xor ebx, ebx
    xor edx, edx
    
loop_2:
    mov bl, byte [ecx + edi]            ;se ia fiecare byte al cuvantului
    mov dl, byte [eax + edi]            ;se ia fiecare byte al cheii
    xor bl, dl                          ;se face xor intre cheie si fiecare octet
    mov byte [ecx + edi], bl            ;se codifica si se modifica ecx 
    inc edi                             ;trecem la urmatorul octet
    cmp byte [ecx + edi], 0             ;daca s-a terminat cuvantul se iese din bucla
    jne loop_2
    
    mov byte [ecx + edi] , 0            ;pe ultima pozitie se pune "\n"
    
    leave
    ret


rolling_xor:
   push ebp
   mov ebp, esp
   xor edi, edi
   mov ecx, dword [esp + 8]             ;in ecx se pastreaza cuvantul codificat
   mov bl, byte [ecx]                   ;se pastreaza in bl, primul octet al codificarii
   inc edi                              ;pasul de inaintre
   
loop_3:
    mov al, bl                          ;se pastreaza in al, primul byte al codificarii
    mov dl, byte [ecx + edi]            ;se trece la urmatorul byte, salvat in dl
    xor al, dl                          ;se face xor intre primul byte si al doilea
    mov bl, dl                          ;primul byte cu care se face codificarea devine 
    mov byte [ecx + edi], al            ;se schimba byte-ul initial cu cel decodificat cu xor
    inc edi                             
    cmp byte [ecx + edi], 0             ;daca se termina cuvantul codificat se iese din functie
    jne loop_3
    
    leave
    ret

xor_hex_strings:
	; TODO TASK 3
	ret

base32decode:
	; TODO TASK 4
    push ebp
    mov ebp,esp
    mov ecx, dword [esp + 8]                ;se salveaza cuvantul codificat in ecx 
    xor esi, esi
    xor edi, edi
    xor eax, eax
    xor ebx, ebx
    xor edx, edx
    mov edi, -1                             ;pasul de crestere
 
 loop11:
    inc edi
    mov dh, byte [ecx + edi]                ;se extrage in dh fiecare byte al codificarii
    cmp dh, 'A'                             ;se verifica daca este litera
    jl numar                                ;daca este mai mic este numar
    sub dh, 'A'                             ;daca este litera se scade valoarea lui 'A' pentru
                                            ;a gasi echivalentul byte-ului in binar
back:
    shl dh, 3                               
    mov byte [ecx + esi] , dh
    
    xor dx, dx
    inc edi
    mov dh, byte [ecx + edi]
    cmp dh, 'A'
    jl numar1
    sub dh, 'A'
back1:
    shr dx, 2
    or byte [ecx + esi], dh
    inc esi
    
    inc edi
    mov dh, byte [ecx + edi]
    cmp dh, 'A'
    jl numar2
    sub dh, 'A'
back2:
    shl dh, 1
    or dl, dh
    
    inc edi
    mov dh, byte [ecx + edi]
    cmp dh, 'A'
    jl numar3
    sub dh, 'A'
back3:
    xor bx, bx
    mov bl, dh
    shl bx, 4
    or dl, bh
    mov byte [ecx + esi], dl
    inc esi
    
    xor dx, dx
    inc edi
    mov dh, byte [ecx + edi]
    cmp dh, 'A'
    jl numar4
    sub dh, 'A'
back4: 
    shr dx, 1
    or bl, dh
    mov byte [ecx + esi], bl
    inc esi
    
    inc edi
    xor bx,bx
    mov dh, byte [ecx + edi]
    cmp dh, 'A'
    jl numar5
    sub dh, 'A'
back5:
    shl dh, 2
    or dl, dh
    
    inc edi
    mov dh, byte [ecx + edi]
    cmp dh, 'A'
    jl numar6
    sub dh, 'A'
back6:
    mov bl, dh
    shr bl, 3
    or dl, bl
    mov byte [ecx + esi], dl
    inc esi
    xor dl, dl
    shr dx, 3
    inc edi
    mov dh, byte [ecx + edi]
    cmp dh, 'A'
    jl numar7
    sub dh, 'A'
back7:
    or dl, dh
    mov byte [ecx + esi], dl
    inc esi
    jmp loop11

numar: 
    cmp dh, '='
    je final
    jne creare_num
numar1: 
    cmp dh, '='
    je final
    jne creare_num1
numar2:
    cmp dh, '='
    je final
    jne creare_num2
    
numar3: 
    cmp dh, '='
    je final
    jne creare_num3
numar4: 
    cmp dh, '='
    je final
    jne creare_num4
numar5: 
    cmp dh, '='
    je final
    jne creare_num5
numar6: 
    cmp dh, '='
    je final
    jne creare_num6
numar7: 
    cmp dh, '='
    je final
    jne creare_num7
    
creare_num: 
    sub dh, '2'
    add dh, 26
    jmp back
creare_num1: 
    sub dh, '2'
    add dh, 26
    jmp back1
creare_num2: 
    sub dh, '2'
    add dh, 26
    jmp back2
creare_num3: 
    sub dh, '2'
    add dh, 26
    jmp back3
creare_num4: 
    sub dh, '2'
    add dh, 26
    jmp back4
creare_num5: 
    sub dh, '2'
    add dh, 26
    jmp back5
creare_num6: 
    sub dh, '2'
    add dh, 26
    jmp back6
creare_num7: 
    sub dh, '2'
    add dh, 26
    jmp back7

final:
   mov byte [ecx + esi], 0
   leave
   ret

bruteforce_singlebyte_xor:
    push ebp
    mov ebp, esp
    mov ecx, dword [esp + 8]                ;codificarea se gaseste in ecx
    
    xor ebx, ebx
    mov ebx, eax                            ;se pastreaza cheia in ebx
    xor eax, eax
    xor edi, edi
    
decriptare:
    mov al, byte [ecx + edi]                ;se ia pe rand fiecare byte al codificarii
    xor al, bl                              ;se face xor cu cheia salvata in ebx 
    mov byte [ecx + edi], al                ;se suprascrie in ecx byte-ul decodificat dupa operatia xor
    inc edi                                 
    cmp byte [ecx + edi] , 0                ;se verifica daca s-a terminat textul codificat
    jne decriptare                          ;daca nu s-a terminat se trece la urmatorul byte
    
    
    mov byte [ecx + edi], 0                 ;la finalul cuvantului se pune caracterul "\n"
    mov eax, ebx
    
    leave
    ret
    
find_key:
    xor edx, edx
    mov edx, ecx
    xor eax, eax
    
    xor ebx, ebx                        ; se va pastra in ebx cheia (bl)
    xor edi,edi 
    
creeaza_cheie:
    mov al, byte [edx + edi]           ;fiecare byte al codificarii se salveaza in al
    mov bl, al                         ;bl salveaza fiecare byte al codificarii
    xor bl, 'f'                        ;se face xor intre fiecare byte si 'f' pentru a gasi cheia
    inc edi
    jmp verificare                     ;presupunem ca cheia este in bl
    cmp byte [edx + edi], 0            ;daca se termina codificarea se iese din bucla
    jne creeaza_cheie
 
verificare:
    mov al, byte [edx + edi]           ;se va pastra in al urmatorul byte din codificare
    xor al, bl                         ;se face xor intre cheie si byte-ul din codificare
                                       ; (a xor b )xor b = a
    cmp al, 'o'                        ;dupa aceasta regula se verifica daca este 'o'
    jne creeaza_cheie                  ;daca nu se verifica se trece la urmatorul byte din codificare
    inc edi
    mov al, byte [edx + edi]
    xor al, bl
    cmp al, 'r'                        ;se verifica pentru tot cuvantul "force"
    jne creeaza_cheie
    inc edi
    mov al, byte [edx + edi]
    xor al, bl
    cmp al, 'c'
    jne creeaza_cheie
    inc edi
    mov al, byte [edx + edi]
    xor al, bl
    cmp al, 'e'
    jne creeaza_cheie
    je fin

fin:  

    xor eax, eax
    mov eax, ebx

   ret

decode_vigenere:
	; TODO TASK 6
    push ebp
    mov ebp, esp
    mov ecx, dword [esp + 8]            ;in ecx se pastreaza codificarea
    mov eax, dword [esp + 12]           ;in eax se pastreaza cheia
    
    xor edi, edi                        ;pasul pentru ecx
    xor ebx, ebx
    xor edx, edx
    xor esi, esi                        ;pasul pentru eax
    
rotatie:
    mov bl, byte [ ecx + edi]           ;se pastreaza fiecare byte al codificarii in registrul bl
    mov dl, byte [ eax + esi]           ;se pastreaza fiecare byte al cheii in registrul dl
    cmp bl, 'a'                         ;se verifica daca byte-ul din bl se afla intre 'a' si 'z'
    jl sari_peste                       ;daca este altceva in afara de litera se sare la urmatorul byte
    cmp bl, 'z'
    jg sari_peste
    sub dl, 'a'                         ;se scade din cheie 'a' pentru a gasi cu cate pozitii este mai departe in alfabet
    sub bl, dl                          ;din registrul bl, in care se afla un byte din codificare
                                        ;se scade numarul de pozitii fata de 'a' al cheii (dl)
    cmp bl, 'a'                         ;daca rezultatul din bl nu este tot o litera trebuie sa adunam 
                                        ;26 (numarul de litere din alfabet)
    jl adunare
    mov byte [ecx + edi], bl            ;se rescrie in ecx byte-ul decodificat
    inc edi                             ;se creste pasul de incrementare al cuvantului si 
                                        ;al cheii
    inc esi 
      
inapoi:
    cmp byte [ecx + edi], 0             ;daca s-a terminat cuvantul ne oprim
    je final1
    cmp byte [eax + esi] , 0            ;daca s-a terminat cheia, se recontituie
    je reconst
    jne rotatie
     
reconst:
    xor esi, esi                        ;se ia cheia de la inceput
    jmp rotatie                         ;se reapeleaza "rotatie" pentru a se decodifica in continurare
    
adunare: 
    add bl, 26 
    mov byte [ecx + edi], bl
    inc edi
    inc esi
    jmp inapoi
    
sari_peste:
    inc edi
    jmp rotatie

final1:   
   mov byte [ecx + edi], 0
   
   leave
	ret

main:
	push ebp
	mov ebp, esp
	sub esp, 2300

	; test argc
	mov eax, [ebp + 8]
	cmp eax, 2
	jne exit_bad_arg

	; get task no
	mov ebx, [ebp + 12]
	mov eax, [ebx + 4]
	xor ebx, ebx
	mov bl, [eax]
	sub ebx, '0'
	push ebx

	; verify if task no is in range
	cmp ebx, 1
	jb exit_bad_arg
	cmp ebx, 6
	ja exit_bad_arg

	; create the filename
	lea ecx, [filename + 7]
	add bl, '0'
	mov byte [ecx], bl

	; fd = open("./input{i}.dat", O_RDONLY):
	mov eax, 5
	mov ebx, filename
	xor ecx, ecx
	xor edx, edx
	int 0x80
	cmp eax, 0
	jl exit_no_input

	; read(fd, ebp - 2300, inputlen):
	mov ebx, eax
	mov eax, 3
	lea ecx, [ebp-2300]
	mov edx, [inputlen]
	int 0x80
	cmp eax, 0
	jl exit_cannot_read

	; close(fd):
	mov eax, 6
	int 0x80

	; all input{i}.dat contents are now in ecx (address on stack)
	pop eax
	cmp eax, 1
	je task1
	cmp eax, 2
	je task2
	cmp eax, 3
	je task3
	cmp eax, 4
	je task4
	cmp eax, 5
	je task5
	cmp eax, 6
	je task6
	jmp task_done

task1:
	; TASK 1: Simple XOR between two byte streams

    push ecx
    call xor_strings
    add esp, 4
    
	; TODO TASK 1: find the address for the string and the key
	; TODO TASK 1: call the xor_strings function

	push ecx
	call puts                   ;print resulting string
	add esp, 4

	jmp task_done

task2:
	; TASK 2: Rolling XOR

	; TODO TASK 2: call the rolling_xor function
   push ecx
   call rolling_xor
   add esp, 4
   
	push ecx
	call puts
	add esp, 4

	jmp task_done

task3:
	; TASK 3: XORing strings represented as hex strings

	; TODO TASK 1: find the addresses of both strings
	; TODO TASK 1: call the xor_hex_strings function

	push ecx                     ;print resulting string
	call puts
	add esp, 4

	jmp task_done

task4:
	; TASK 4: decoding a base32-encoded string

	; TODO TASK 4: call the base32decode function
	push ecx
   call base32decode
   add esp, 4 
    
	push ecx
	call puts                    ;print resulting string
	pop ecx
	
	jmp task_done

task5:
	; TASK 5: Find the single-byte key used in a XOR encoding
    push ecx
    call find_key
    add esp,4

    push ecx
    call bruteforce_singlebyte_xor
    add esp,4 
    
   push eax   
	push ecx                    ;print resulting string
	call puts
	pop ecx
                 ;eax = key value
	push fmtstr
	call printf                 ;print key value
	add esp, 8

	jmp task_done

task6:
	; TASK 6: decode Vignere cipher

	; TODO TASK 6: find the addresses for the input string and key
	; TODO TASK 6: call the decode_vigenere function

	push ecx
	call strlen
	pop ecx

	add eax, ecx
	inc eax

	push eax
	push ecx                   ;ecx = address of input string 
	call decode_vigenere
	pop ecx
	add esp, 4

	push ecx
	call puts
	add esp, 4

task_done:
	xor eax, eax
	jmp exit

exit_bad_arg:
	mov ebx, [ebp + 12]
	mov ecx , [ebx]
	push ecx
	push usage
	call printf
	add esp, 8
	jmp exit

exit_no_input:
	push filename
	push error_no_file
	call printf
	add esp, 8
	jmp exit

exit_cannot_read:
	push filename
	push error_cannot_read
	call printf
	add esp, 8
	jmp exit

exit:
	mov esp, ebp
	pop ebp
	ret