member(Χ,[Χ|Τail]). 
member(Χ,[Head |Tail]) :- 
	member(X,Tail).

append([ ], List, List). 
append([Head|Tail],List,[Head|NewList) :-
	append(Tail,List,NewList).
 
sum([], 0).
sum([H|T], Sum):-
    sum(T, SumT),
    Sum is SumT + H.
	
length([],0). 
length([H|T],L) :-  
	length(T,L1),  
	L is L1+1. 

insert(H, [H1|T], [H,H1|T]) :-
	H =< H1.
insert(H, [H1|T], [H1|NT]) :-
	H > H1, insert(H,T,NT).
	insert(H, [ ], [H]).


/*
Διαγράφει το στοιχείο X από τη λίστα L 
και επιστρέφει τη λίστα NL που δεν το περιλαμβάνει*/
del(X, [X|T], T).
del(X, [H|T], [H|LT]) :-
	del(X, T, LT).

/*Διαγράφει όλες τις εμφανίσεις του στοιχείου X από τη λίστα L και επιστρέφει τη λίστα NL που δεν περιλαμβάνει καθόλου το Χ. */
delall(X, [], []).
delall(X, [X|T], LT) :-
	delall(X, T, LT).
delall(X, [H|T], [H|LT]) :-
	X \= H,
	delall(X, T, LT).