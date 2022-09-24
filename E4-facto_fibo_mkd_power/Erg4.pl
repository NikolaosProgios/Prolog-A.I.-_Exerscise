factorial(0,1).
factorial(1,1).
factorial(N,NP):-
	N>1 ,
	N1 is N-1 , 
	factorial(N1,N1P),
	NP is N * N1P .
%a
natural(0).	
natural(X):-
	X>0,
	Y is X-1 , 
	natural(Y).
%b
power(X, 0, 1).
power(X, 1, X).
/*
power(X,N,P) :-
	N > 1,
	N1 is N-1,
	power(X,N1,P1),
	P is X*P1.
*/
power(X,N,P):-
	P is X^N.

%g
fibo(1,1).
fibo(2,1).
fibo(N, Y):-
    N1 is N - 1,
    N2 is N - 2,
    fibo(N1, Y1),
    fibo(N2, Y2),
    Y is Y1 + Y2.	
%d	
mkd(N, 0, N).
mkd(N, M, X):-
    N < M,
    mkd(M, N, X).
mkd(N, M, X):-
    N >= M,
    M1 is mod(N, M),
    mkd(M, M1, X).
	
%e
run :-
	write('Dwse ton arithmo A: '),
	read(A),
	write('Dwse ton arithmo B: '),
	read(B),
	write('A^B = '),
	power(A,B,P),
	write(P), nl,
	fibo(A,F),
	write('fibonacci(A) = '),
	write(F), nl,
	mkd(A,B,M),
	write('MKD(A,B) = '),
	write(M), nl.