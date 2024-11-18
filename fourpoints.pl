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
    A =\= 0,

    DX2 is X3 - X2,                     
    DY2 is Y3 - Y2,                      
    B is sqrt(DX2 * DX2 + DY2 * DY2),
    B =\= 0,


    DX3 is X - X3,                     
    DY3 is Y - Y3,                      
    C is sqrt(DX3 * DX3 + DY3 * DY3),        
    C =\= 0,

    
    msort([A, B, C], SortedTriList).

store_lengths_square(point2d(X,Y), point2d(X2,Y2), point2d(X3, Y3), point2d(X4, Y4)) :-

    retractall(square_list(_)),

    DX is X2 - X,                     
    DY is Y2 - Y,                      
    A is sqrt(DX * DX + DY * DY),
    A =\= 0,

    DX2 is X3 - X2,                     
    DY2 is Y3 - Y2,                      
    B is sqrt(DX2 * DX2 + DY2 * DY2),
    B =\= 0,


    DX3 is X4 - X3,                     
    DY3 is Y4 - Y3,                      
    C is sqrt(DX3 * DX3 + DY3 * DY3),
    C =\= 0,


    DX4 is X - X4,                     
    DY4 is Y - Y4,                      
    D is sqrt(DX4 * DX4 + DY4 * DY4),
    D =\= 0,


    DX5 is X - X3,                     
    DY5 is Y - Y3,                      
    E is sqrt(DX5 * DX5 + DY5 * DY5),
    E =\= 0,


    DX6 is X2 - X4,                     
    DY6 is Y2 - Y4,                      
    F is sqrt(DX6 * DX6 + DY6 * DY6),
    F =\= 0,

    
    assert(square_list([A, B, C, D, E, F])).

equilateral(point2d(X,Y), point2d(X2,Y2), point2d(X3, Y3)) :-
    \+ right(point2d(X,Y), point2d(X2,Y2), point2d(X3, Y3)),
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
    \+ equilateral(point2d(X,Y), point2d(X2,Y2), point2d(X3, Y3)),
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