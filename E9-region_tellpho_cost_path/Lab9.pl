% LAB 9
region(r1, 2110, [1,2]).
region(r2, 2210, [4,5,8]).
region(r3, 2310, [3,6]).
region(r4, 2410, [7,10,11,15]).
region(r5, 2510, [9, 12]).
region(r6, 2610, [13,14]).

next_to(1,2).
next_to(1,4).
next_to(3,5).
next_to(3,6).
next_to(4,5).
next_to(4,8).
next_to(5,8).
next_to(5,9).
next_to(6,7).
next_to(7,10).
next_to(8,9).
next_to(9,12).
next_to(10,11).
next_to(10,15).
next_to(12,15).
next_to(13,14).

connect(X,Y) :-
	next_to(X,Y).
connect(X,Y) :-
	next_to(Y,X).

telephone(2310-6-64221, name(andriopoulos, nikos)).
telephone(2110-2-49037, name(papadakis, giwrgos)).
telephone(2410-11-5829, name(georgiou, evaggelos)).
telephone(2510-12-4234, name(papantoniou, kiki)).
telephone(2610-14-7270, name(antoniou, eleni)).
%2
which_sector_area(Code-Area-_, Sector, Area) :-
	region(Sector, Code, AreaList),
	member(Area, AreaList).
%3
same_sector(Area1, Area2) :-
	region(_, _, AreaList),
	member(Area1, AreaList),
	member(Area2, AreaList).

/*4 can_call(Name1, Name2, Route) */

pathloop(AreaStart, AreaEnd, _, Path) :-
	connect(AreaStart, AreaEnd),
	Path = [AreaStart, AreaEnd].
pathloop(AreaStart, AreaEnd, Visited, Path) :-
	connect(AreaStart, AreaMid),
	not(member(AreaMid, Visited)),
	pathloop(AreaMid, AreaEnd, [AreaMid|Visited], PathMidEnd),
	Path = [AreaStart | PathMidEnd].

can_call(Name1, Name2, Route) :-
	telephone(_-Area1-_, name(Name1,_)),
	telephone(_-Area2-_, name(Name2,_)),
	pathloop(Area1, Area2, [Area1,Area2], Route).

/*5 pathloopcost(AreaStart, AreaEnd, _, Path, Cost)*/

% 1η λύση

/*είναι στο ίδιο sector*/
pathloopcost(AreaStart, AreaEnd, _, Path, Cost) :-
	connect(AreaStart, AreaEnd),
	Path = [AreaStart, AreaEnd],
	/*Βρες σε ποια sectors ειναι τα δύο areas*/
	which_sector_area(_, SectorStart, AreaStart),
	which_sector_area(_, SectorEnd, AreaEnd),
	/*είναι στο ίδιο sector*/
	SectorStart = SectorEnd,
	Cost = 0.
/*είναι σε διπλανά sectors*/
pathloopcost(AreaStart, AreaEnd, _, Path, Cost) :-
	connect(AreaStart, AreaEnd),
	Path = [AreaStart, AreaEnd],
	/*Βρες σε ποια sectors ειναι τα δύο areas*/
	which_sector_area(_, SectorStart, AreaStart),
	which_sector_area(_, SectorEnd, AreaEnd),
	/*είναι σε διπλανά sectors*/
	SectorStart \= SectorEnd,
	Cost = 1.
/*
είναι στο ίδιο sector αλλα να μην ξανα περασει απο το ιδιο
*/
pathloopcost(AreaStart, AreaEnd, Visited, Path, Cost) :-
	connect(AreaStart, AreaMid),
	not(member(AreaMid, Visited)),
	pathloopcost(AreaMid, AreaEnd, [AreaMid|Visited], PathMidEnd, CostMidEnd),
	Path = [AreaStart | PathMidEnd],
	/*Βρες σε ποια sectors ειναι τα δύο areas*/
	which_sector_area(_, SectorStart, AreaStart),
	which_sector_area(_, SectorMid, AreaMid),
	/*είναι στο ίδιο sector*/
	SectorStart = SectorMid,
	Cost = CostMidEnd.
/*
είναι στο διπλανά sectors αλλα να μην ξανα περασει απο το ιδιο
*/
pathloopcost(AreaStart, AreaEnd, Visited, Path, Cost) :-
	connect(AreaStart, AreaMid),
	not(member(AreaMid, Visited)),
	pathloopcost(AreaMid, AreaEnd, [AreaMid|Visited], PathMidEnd, CostMidEnd),
	Path = [AreaStart | PathMidEnd],
	/*Βρες σε ποια sectors ειναι τα δύο areas*/
	which_sector_area(_, SectorStart, AreaStart),
	which_sector_area(_, SectorMid, AreaMid),
	/*είναι στο διπλανά sectors*/
	SectorStart \= SectorMid,
	Cost is CostMidEnd + 1.

/* 2η λύση (με αρχική εκτέλεση του pathloop)
pathloopcost(AreaStart, AreaEnd, Path, Cost) :-
	pathloop(AreaStart, AreaEnd, [AreaStart], Path),
	findcost(Path,Cost).
findcost([Area],0).
findcost([AreaStart,AreaNext|RestAreas],Cost):-
	cost(AreaStart,AreaNext,C1),
	findcost([AreaNext|RestAreas],C2),
	Cost is C1+C2.
cost(Area1,Area2,0):-
	same_sector(Area1, Area2).	
cost(Area1,Area2,1):-
	not(same_sector(Area1, Area2)). % Θα βρίσκονται σε διπλανά sectors
*/
can_call(Name1, Name2, Route, Cost) :-
	telephone(_-Area1-_, name(Name1,_)),
	telephone(_-Area2-_, name(Name2,_)),
	pathloopcost(Area1, Area2, [Area1,Area2], Route, Cost).


ateitalk :-
	write('Welcome to ATEITALK'), nl,
	write('Choose one of the following operations:'), nl,
	write('1. Verify Connection of Two Areas.'), nl,
	write('2. Find Sector and Area of a Telephone Number'), nl,
	write('3. Find Route and Cost of a specific call'), nl,
	write('4. Exit.'), nl,
	read(Choice),
	write('Choice -> '), write(Choice), nl,
	execute(Choice).

execute(1) :-
	write('Give Area 1 --> '),
	read(Area1),
	write('Give Area 2 --> '),
	read(Area2),
	connect(Area1, Area2),
	write('Areas are Connected.'), nl,
	ateitalk.
execute(2) :-
	write('Give phone number --> '),
	read(Code-Area-_),
	which_sector_area(Code-Area-_, Sector, Area),
	write('Sector: '), write(Sector), nl,
	write('Area: '), write(Area), nl,
	ateitalk.
execute(3) :-
	write('Give Name1: '),
	read(Name1),
	write('Give Name2: '),
	read(Name2),
	can_call(Name1, Name2, Route, Cost),
	write('Route: '), write(Route), nl,
	write('Cost: '), write(Cost), write('euros'), nl,
	ateitalk.
execute(4). % stop succesfully and exit