/* Petre Alexandra Elena 325CB */

(*) TASK1
    -in functia xor_strings parcurg fiecare byte al codificarii pana
    ajung la cheie
    -salvez cheia in eax si cuvantul in ecx
    -voi pastra in registrii bl si dl fiecare byte al cuvantului respectiv al cheii
    -se va face xor intre bl si dl si se obtine decodificare
    -se rescrie in ecx octetul decodificat

(*) TASK2
    -se pastreaza in registrul bl primul octet din codificare
    -in al salvam ce se afla in bl
    -se va citi din codificare urmatorul byte in registrul dl
    -se va face xor intre al si dl astfel se obtine in al byte-ul decodificat
    -se muta in bl ce se afla in registrul dl si se creste pasul de incrementare
    al codificarii
    (c1 , c2 -> c1 xor c2 -> se salveaza c1 = c2, c2 -urmatorul byte din codificare)

(*) TASK4
    -am avut nevoie de doi registrii in care am pastrat pasul de incrementare
    pentru textul codificat si pentru a retine unde trebuie modificat in ecx
    cu valoarea decodificata
    -am observat ca pentru a creea octetii necesari in functie de regula base32
    trebuie sa se formeze octetul din mai multe elemente in binar
    -am citit byte cu byte din textul codificat si am verificat daca este
    litera sau cifra in functie de asta am calculat si transformat din ascii in
    binar fiecare byte al codificarii
    -fiecare byte al codificarii era reprezentat prin 5 biti in binar

    ex: 10010   10110    11100      10000     10101      01001    01010     00101 --binar
          S      W         Y          Q         V          J        K        F    --base32
    10010101  10111001   00001010   10100101   01000101                           --binar(octet)

    -in cazul acesta primul octet pe care il formam din combinarea mai multor
    elemente de cate 5 biti
    -din acest motiv am facut shiftari si operatii de or intre mai multi registrii
    lucru pe care l-am facut in 8 pasi, pe care i-am repetat pana s-a terminat
    codificarea.
    -de fiecare data cand se forma un octet din mai multi biti se rescria in ecx
    valoarea decodificata
    -daca se ajungea la '=', functia se oprea

(*) TASK5
    -am cautat cheia in functia "find_key"
    FIND_KEY:
      *am luat fiecare octet din textul codificat
      *am facut xor intre byte[ecx + edi] si 'f'
      *cheia este rezultatul dupa xor
      *am verificat daca aceasta cheie merge, verificand daca urmatoarele 4 litere
      din cuvantul "force" se decodifica cu ajutorul cheii formate anterior
      *daca nu se verifica se trece la urmatorul byte
    - in functia "bruteforce_singlebyte_xor" luam fiecare byte al codificarii
    si am facut xor intre cheia gasita anterior salvata in eax si byte-ul din
    ecx
    -se rescrire in byte[ ecx + edi ] noua valoarea dupa operatia xor


(*) TASK6
  -am folosit 2 registrii pentru a pastra pasul de incrementare pentru cheie (esi)
  si pentru codificare (edi)
  -am luat fiecre byte al codificarii
  -am verificat daca se afla intre 'a' si 'z'
  -am facut diferenta intre byte-ul din cheie si 'a', pentru a vedea
  cu cate pozitii va fi rotit un element
  -am scazut din byte-ul din codificare, rezultatul obtinut de la operiatia
  anterioara
  -am verificat daca ce am obtinut este mai mic decat 'a', atunci am aduagat 26
  daca nu era mai mic inseamna ca era tot o litera
  
