%parentPetrosDimitra
parent(petros,maria).
parent(petros,akis).
parent(dimitra,maria).
parent(dimitra,akis).
%parentMariaGiorgso
parent(maria,alex).
parent(maria,giannis).
parent(maria,sofia).
parent(giorgos,alex).
parent(giorgos,giannis).
parent(giorgos,sofia).

%parentAkisEleni
parent(akis,kosta).
parent(akis,lia).
parent(eleni,kosta).
parent(eleni,lia).

male(petros).
male(akis).
male(alex).
male(giannis).
male(giorgos).

female(maria).
female(dimitra).
female(sofia).
female(lia).
female(eleni).
%Poia�inai�a�ggonia�oy�etroy
%/grandfather(petros,X)./

grandfather(X,Y):-
    parent(X,Z),
    parent(Z,Y),
    male(X).

	
%�������������������������
%/grandmother(X,sofia)./

grandmother(X,Y):-
    parent(X,Z),
    parent(Z,Y),
    female(X).	
	
%���������������Ϣ���
%/brother(X,alex)./ 
	
brother(X,Y):-
	male(X), %FameleForSister
    parent(P,X),
    parent(P,Y),
	X\=Y.

%��������������������
%/uncle(X,giannis)./ 	
uncle(X,Y):-
	male(X),
    parent(Z,Y),
    brother(X,Z),
	X\=Y. %��������������������������
    
