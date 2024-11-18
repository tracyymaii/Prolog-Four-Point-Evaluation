/* Add your code here */

:- dynamic square_list/1.

initialize :- 
    retractall(triangle_list(_)),
    assert(triangle_list([])).

vertical(point2d(X,_), point2d(X, _)).

horizontal(point2d(_,Y), point2d(_, Y)).

line(point2d(X,Y), point2d(X2,Y2), point2d(X3, Y3)) :-
    horizontal(point2d(X,Y), point2d(X2, Y2)),
    horizontal(point2d(X2,Y2), point2d(X3, Y3)).

line(point2d(X,Y), point2d(X2,Y2), point2d(X3, Y3)) :-
    vertical(point2d(X,Y), point2d(X2, Y2)),
    vertical(point2d(X2,Y2), point2d(X3, Y3)).

line(point2d(X,Y), point2d(X2,Y2), point2d(X3, Y3)) :-
    X2-X =\= 0,
    X3-X2 =\= 0,
    (Y2-Y)/(X2-X) =:= (Y3-Y2)/(X3-X2).

triangle(point2d(X,Y), point2d(X2,Y2), point2d(X3, Y3)) :-
    \+ line(point2d(X,Y), point2d(X2,Y2), point2d(X3, Y3)),
    store_sides(point2d(X,Y), point2d(X2,Y2), point2d(X3, Y3), _).

store_sides(point2d(X,Y), point2d(X2,Y2), point2d(X3, Y3), SortedTriList) :-

    retractall(triangle_list(_)),

    DX is X2 - X,                     
    DY is Y2 - Y,                      
    A is sqrt(DX * DX + DY * DY),


    DX2 is X3 - X2,                     
    DY2 is Y3 - Y2,                      
    B is sqrt(DX2 * DX2 + DY2 * DY2),


    DX3 is X - X3,                     
    DY3 is Y - Y3,                      
    C is sqrt(DX3 * DX3 + DY3 * DY3),
    
    msort([A, B, C], SortedTriList).

store_lengths_square(point2d(X,Y), point2d(X2,Y2), point2d(X3, Y3), point2d(X4, Y4)) :-

    retractall(square_list(_)),

    DX is X2 - X,                     
    DY is Y2 - Y,                      
    A is sqrt(DX * DX + DY * DY),

    DX2 is X3 - X2,                     
    DY2 is Y3 - Y2,                      
    B is sqrt(DX2 * DX2 + DY2 * DY2),

    DX3 is X4 - X3,                     
    DY3 is Y4 - Y3,                      
    C is sqrt(DX3 * DX3 + DY3 * DY3),

    DX4 is X - X4,                     
    DY4 is Y - Y4,                      
    D is sqrt(DX4 * DX4 + DY4 * DY4),

    DX5 is X - X3,                     
    DY5 is Y - Y3,                      
    E is sqrt(DX5 * DX5 + DY5 * DY5),

    DX6 is X2 - X4,                     
    DY6 is Y2 - Y4,                      
    F is sqrt(DX6 * DX6 + DY6 * DY6),
    
    assert(square_list([A, B, C, D, E, F])).

equilateral(point2d(X,Y), point2d(X2,Y2), point2d(X3, Y3)) :-
    triangle(point2d(X,Y), point2d(X2,Y2), point2d(X3, Y3)),
    store_sides(point2d(X, Y), point2d(X2, Y2), point2d(X3, Y3), SortedList),   
    nth0(0, SortedList, Side1),
    nth0(1, SortedList, Side2),
    nth0(2, SortedList, Side3),
    is_close(Side1,Side2),
    is_close(Side2,Side3).

scalene(point2d(X,Y), point2d(X2,Y2), point2d(X3, Y3)) :-
    triangle(point2d(X,Y), point2d(X2,Y2), point2d(X3, Y3)),
    store_sides(point2d(X, Y), point2d(X2, Y2), point2d(X3, Y3), SortedList),   
    nth0(0, SortedList, Side1),
    nth0(1, SortedList, Side2),
    nth0(2, SortedList, Side3),
    \+ is_close(Side1,Side2),
    \+ is_close(Side2,Side3),
    \+ is_close(Side1,Side3).

isosceles(point2d(X,Y), point2d(X2,Y2), point2d(X3, Y3)) :-
    triangle(point2d(X,Y), point2d(X2,Y2), point2d(X3, Y3)),
    \+ scalene(point2d(X,Y), point2d(X2,Y2), point2d(X3, Y3)).

right(point2d(X,Y), point2d(X2,Y2), point2d(X3, Y3)) :-
    triangle(point2d(X,Y), point2d(X2,Y2), point2d(X3, Y3)),
    store_sides(point2d(X, Y), point2d(X2, Y2), point2d(X3, Y3), SortedList),   
    nth0(0, SortedList, Side1),
    nth0(1, SortedList, Side2),
    nth0(2, SortedList, Side3),
    is_close(Side1^2 + Side2^2, Side3^2).

acute(point2d(X,Y), point2d(X2,Y2), point2d(X3, Y3)) :-
    triangle(point2d(X,Y), point2d(X2,Y2), point2d(X3, Y3)),
    store_sides(point2d(X, Y), point2d(X2, Y2), point2d(X3, Y3), SortedList),    
    nth0(0, SortedList, Side1),
    nth0(1, SortedList, Side2),
    nth0(2, SortedList, Side3),
    Side1^2 + Side2^2 > Side3^2,
    \+ is_close(Side1^2 + Side2^2, Side3^2).


obtuse(point2d(X,Y), point2d(X2,Y2), point2d(X3, Y3)) :-
    triangle(point2d(X,Y), point2d(X2,Y2), point2d(X3, Y3)),
    store_sides(point2d(X, Y), point2d(X2, Y2), point2d(X3, Y3), SortedList),    
    nth0(0, SortedList, Side1),
    nth0(1, SortedList, Side2),
    nth0(2, SortedList, Side3),
    Side1^2 + Side2^2 < Side3^2, 
    \+ is_close(Side1^2 + Side2^2, Side3^2).


square(point2d(X,Y), point2d(X2,Y2), point2d(X3,Y3), point2d(X4,Y4)) :-
    store_lengths_square(point2d(X,Y), point2d(X2,Y2), point2d(X3, Y3), point2d(X4, Y4)),
    square_list(SquareList),
    nth0(0, SquareList, Side1),
    nth0(1, SquareList, Side2),
    nth0(2, SquareList, Side3),
    nth0(3, SquareList, Side4),
    nth0(4, SquareList, Diagonal1),
    nth0(5, SquareList, Diagonal2),

    is_close(Side1,Side2),
    is_close(Side2,Side3),
    is_close(Side3,Side4),
    is_close(Side4,Side1),

    is_close(Diagonal1,Diagonal2).

is_close(A, B) :-
    Epsilon = 1.0e-6,
    Diff is abs(A - B),
    Diff =< Epsilon.

query(line(point2d(0,0), point2d(2,4), point2d(5,0))).
query(line(point2d(0,0), point2d(3,2), point2d(6,4))).
query(line(point2d(0,0), point2d(5,0), point2d(2.5,sqrt(18.75)))).


query(triangle(point2d(0,0), point2d(2,4), point2d(5,0))).
query(triangle(point2d(0,0), point2d(3,2), point2d(6,4))).
query(triangle(point2d(0,0), point2d(5,0), point2d(2.5,sqrt(18.75)))).


query(equilateral(point2d(0,0), point2d(2,4), point2d(5,0))).
query(isosceles(point2d(0,0), point2d(2,4), point2d(5,0))).
query(right(point2d(0,0), point2d(2,4), point2d(5,0))).
query(scalene(point2d(0,0), point2d(2,4), point2d(5,0))).
query(acute(point2d(0,0), point2d(2,4), point2d(5,0))).
query(obtuse(point2d(0,0), point2d(2,4), point2d(5,0))).

query(equilateral(point2d(0,0), point2d(5,0), point2d(2.5,sqrt(18.75)))).
query(isosceles(point2d(0,0), point2d(5,0), point2d(2.5,sqrt(18.75)))).
query(right(point2d(0,0), point2d(5,0), point2d(2.5,sqrt(18.75)))).
query(scalene(point2d(0,0), point2d(5,0), point2d(2.5,sqrt(18.75)))).
query(acute(point2d(0,0), point2d(5,0), point2d(2.5,sqrt(18.75)))).
query(obtuse(point2d(0,0), point2d(5,0), point2d(2.5,sqrt(18.75)))).

query(line(point2d(1,2), point2d(2,4), point2d(3,6))).
query(line(point2d(1,2), point2d(2,4), point2d(3,8))).
query(line(point2d(1,2), point2d(2,4), point2d(10,20))).

query(vertical(point2d(1,2), point2d(2,4))).
query(vertical(point2d(1,2), point2d(1,4))).
query(vertical(point2d(1,2), point2d(3,2))).

query(horizontal(point2d(1,2), point2d(2,4))).
query(horizontal(point2d(1,2), point2d(1,4))).
query(horizontal(point2d(1,2), point2d(3,2))).

query(triangle(point2d(1,2), point2d(2,4), point2d(3,6))).
query(triangle(point2d(1,2), point2d(2,4), point2d(3,8))).
query(triangle(point2d(1,2), point2d(2,4), point2d(10,20))).

query(triangle(point2d(2,3), point2d(6,3), point2d(4,3 + sqrt(12)))).
query(equilateral(point2d(2,3), point2d(6,3), point2d(4,3 + sqrt(12)))).
query(isosceles(point2d(2,3), point2d(6,3), point2d(4,3 + sqrt(12)))).
query(right(point2d(2,3), point2d(6,3), point2d(4,3 + sqrt(12)))).
query(scalene(point2d(2,3), point2d(6,3), point2d(4,3 + sqrt(12)))).
query(acute(point2d(2,3), point2d(6,3), point2d(4,3 + sqrt(12)))).
query(obtuse(point2d(2,3), point2d(6,3), point2d(4,3 + sqrt(12)))).

query(triangle(point2d(2,2), point2d(5,2), point2d(3.5,-2))).
query(equilateral(point2d(2,2), point2d(5,2), point2d(3.5,-2))).
query(isosceles(point2d(2,2), point2d(5,2), point2d(3.5,-2))).
query(right(point2d(2,2), point2d(5,2), point2d(3.5,-2))).
query(scalene(point2d(2,2), point2d(5,2), point2d(3.5,-2))).
query(acute(point2d(2,2), point2d(5,2), point2d(3.5,-2))).
query(obtuse(point2d(2,2), point2d(5,2), point2d(3.5,-2))).

query(triangle(point2d(0,0), point2d(-2,2), point2d(4,4))).
query(equilateral(point2d(0,0), point2d(-2,2), point2d(4,4))).
query(isosceles(point2d(0,0), point2d(-2,2), point2d(4,4))).
query(right(point2d(0,0), point2d(-2,2), point2d(4,4))).
query(scalene(point2d(0,0), point2d(-2,2), point2d(4,4))).
query(acute(point2d(0,0), point2d(-2,2), point2d(4,4))).
query(obtuse(point2d(0,0), point2d(-2,2), point2d(4,4))).

query(triangle(point2d(1,1), point2d(3,1), point2d(4,3))).
query(equilateral(point2d(1,1), point2d(3,1), point2d(4,3))).
query(isosceles(point2d(1,1), point2d(3,1), point2d(4,3))).
query(right(point2d(1,1), point2d(3,1), point2d(4,3))).
query(scalene(point2d(1,1), point2d(3,1), point2d(4,3))).
query(acute(point2d(1,1), point2d(3,1), point2d(4,3))).
query(obtuse(point2d(1,1), point2d(3,1), point2d(4,3))).

query(triangle(point2d(3,1), point2d(9,1), point2d(6,4))).
query(equilateral(point2d(3,1), point2d(9,1), point2d(6,4))).
query(isosceles(point2d(3,1), point2d(9,1), point2d(6,4))).
query(right(point2d(3,1), point2d(9,1), point2d(6,4))).
query(scalene(point2d(3,1), point2d(9,1), point2d(6,4))).
query(acute(point2d(3,1), point2d(9,1), point2d(6,4))).
query(obtuse(point2d(3,1), point2d(9,1), point2d(6,4))).

query(square(point2d(2,4),point2d(5,7),point2d(8,4),point2d(5,1))). 
query(square(point2d(2,4),point2d(5,7),point2d(8,4),point2d(5,0))). 
query(square(point2d(3,1),point2d(2,4),point2d(5,5),point2d(6,2))). 
query(square(point2d(-1,1),point2d(-1,3),point2d(1,3),point2d(1,0))). 
query(square(point2d(-1,1),point2d(-1,3),point2d(1,3),point2d(1,1))). 
query(square(point2d(5,4),point2d(5,1),point2d(2,1),point2d(2,4))). 
query(square(point2d(2,0),point2d(1,2),point2d(2,4),point2d(3,2))).


writeln(T) :- write(T), nl.

main:- forall(query(Q), Q -> (writeln('yes')) ; (writeln('no'))),
	halt.
