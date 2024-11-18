/* fact, where oves = predicate, and romeo and juliet = atoms/attributes*/
loves(romeo, juliet). 

/*rule, where :- = if */
/*juliet loves romeo, if romeo loves juliet */
loves(juliet, romeo) :- loves(romeo, juliet).

/* variables start w UPPERCASE, atoms start with lowercase
    so like ask terminal 
    loves(romeo, X).
    returns 
    X = juliet.
*/

/* predicates that will change needs to have dynamic in front of it, 
    and /2 = number of arguments needed*/
:- dynamic(father/2).
:- dynamic(likes/2).
:- dynamic(friend/2).
:- dynamic(stabs/3).

father(lord_montague, romeo).
father(lord_capulet, juliet).

like(mercutio, dancing).
like(benvolio, dancing).
like(romeo, dancing).
like(romeo, juliet).
like(juliet, romeo).
like(juliet, dancing).

friend(romeo, mercutio).
friend(romeo, benvolio).

/* update db

add to end of db in same area, assertz(friend(benvolio, mercutio)).
 add to beg of db in same area, asserta(friend(benvolio, mercutio)). 4
 delete --> retract(likes(mercutio, dancing)).
 delete all of something --> retractall(father(_,_)).

to delete dancing for everyone. retractall(likes(_, dancing)).

 */



/*never start atom off with _, and can use whitespace as long as use ' '*/

/* keep all predicates in one area */

male(albert).
male(bob).
male(bill).
male(carl).
male(charlie).
male(dan).
male(edward).

/* query: male(_), will return true bc it'c j checking or existance of male predicate */

/* female = functure, number of dif arguments in functure = airity,param */
female(alice).
female(betsy).
female(diana).

/* query: male(X), female(Y) = gets combo of both, 
if press ; after returned in terminal will print next combo,
can do this forever, but it will stop automatically when all combos are printed*/

happy(albert).
happy(alice).
happy(bob).
happy(bill).
with_albert(alice).

/* rules = when fact depends on another fact, :- = if */

/* so albert runs if albert is happy, 
bc in db albert is happy, will return true*/
runs(albert) :-
    happy(albert).

/* alice dances if alice is happy AND alice is with albert,
    both must be true for predicate to be considered true */
dances(alice) :-
    happy(alice),
    with_albert(alice).

/* does alice_dance (predicate) is true when the the right side is true
    which we know it is, so then program will output true, and output
    the requested write, if false then no printouts but "false" */
does_alice_dance :- dances(alice),
    write('When Alice is happy and with Albert she dances').

/*
swims(bob) :-
    happy(bob), 
    near_water(bob).
*/

/* if we don't descibe the thing in the predicate, like near_water,
    but imma do it affter this so then it runs, it fails,
    bc we are basing off of facts that don't exist */

near_water(bob).

/* seeing as how near_water is after the predicate, order doesn't tech
    matter, but prob makes more sense for us to put it before */

/* OR is really just seperate predicates so it'll return true for which
    ever works, and false if none do*/

swims(bob) :- 
    happy(bob).

swims(bob) :-
    near_water(bob).

/* vars start with UPPERCASE or _ */

/*albert is the parent of bob, bill and betsy */
/*alice is the parent of bob, bill and betsy */
/*bob is the parent of carl and charlie */

parent(albert, bob).
parent(albert, besty).
parent(albert, bill).

parent(alice, bob).
parent(alice, betsy).
parent(alice, bill).

parent(bob, carl).
parent(bob, charlie).

/*dependent query: parent(X, bob), dances(X).
                    who is the parent of bob who also dances
                    keeping the X the same ensures to return the same person that does both
                    in this case Alice 
                    
if instead do: parent(X,bob), dances(Y).
    will first return 2 diff people to qualify for it, in this case:
    X = albert, Y = alice,
    but if we press ; to try and get more combos, 
    it will then return 
    X = Y, Y = alice,
    then it'll stop bc there are no other combos
                    */


/* grandparent query: parent(Y, carl), parent(X, Y).
                        asking for someone who is a parent of carl's parent,
                        so Y is parent of carl, then, X is asking for parent
                        of Y's parent*/

/* grandchild query: parent(albert, X), parent(X, Y).
                    given parent albert, find his child x, and x's child, y*/

get_grandchild :- 
    parent(albert, X), 
    parent(X, Y),
    write("Albert's grandchild is "),
    write(Y), nl.

/* same parent query: parent(X, carl), parent(X, charlie).
    returns X = bob, and false if they weren't related */

get_grandparent :- 
    parent(X, carl),
    parent(X, charlie),
    format('~w ~s grandparent ~n', [X, "is the"]).
    /*where ~w is the variable, and ~s is the string in the list, and ~n makes it a string*/

brother(bob, bill).

/* uncle of carl: parent(X, carl), brother(X,Y).
                    get carl's parent and brother of that parent*/


/* give x = grandchild, leave y as a var
    so then it will find the parent o x first, 
    then the parent of that parent, and that will be the one returned */
grand_parent(X,Y) :-
    parent(Z, X),
    parent(Y, Z).

/*where if human true, blushes will be true,
    so pass derek into blushes will return true */
blushes(X) :- human(X).
human(derek).

/*tybalt stabs mercution with a sword, 
    and romeo hates whoever stabs mercutio with a sword */
stabs(tybalt, mercutio, sword).
stabs(romeo, tybalt, sword).

hates(romeo, X) :- stabs(X, mercutio, sword).

what_grade(5) :-
    write('Go to kindergarten').

what_grade(6) :-
    write('Go to 1st grade').

/*is = equals */

what_grade(Other) :-
    Grade is Other -5,
    format('Go to grade ~w', [Grade]).

/*STRUCTS */

/*albert owns a pet cat names olive*/
owns(albert, pet(cat, olive)).

customer(tom, smith, 20.55).
customer(sally, smith, 120.55).
/* balance query for sally: customer(sally, _, Bal)
                            _, bc we don't care about her last name
                            Bal = variable, 
                            and the number returned will be stored in that variable,
                            so output --> Bal = 120.55 */
            
/* FName, LName, starts with caps, bc they's annnoymous vars, 
    so it will need to take in user input,
    ~2f means that it will output to 2 decimals
*/            
get_cust_bal(FName, LName) :-
    customer(FName, LName, Bal),
    write(FName), tab(1),
    format('~w owes us $~2f ~n', [LName, Bal]).

/*

vertical(line(point(X,Y), point(X, Y2))).
horizontal(line(point(X, Y), point(X2, Y))).

*/

/*singleton warning bc we define, y,y2, and x,x2 but do nothing with it
    in their respective rules */

/* \+ means not, so query: \+ (alice = alber), would return true
can assign variables liek query: W = alice, will be true, and we can use later

arbitrary assignments: query: rich(money,X) = rich(Y, no_debt).
                        output: X = no_debt
                        Y = money
*/

warm_blooded(penguin).
warm_blooded(human).

produce_milk(penguin).
produce_milk(human).

have_feathers(penguin).
have_hair(human).

mammal(X) :-
    warm_blooded(X),
    produce_milk(X),
    have_hair(X).

/* trace. = prolog debugger, goes step b step really nicely */ 

say_hi :-
    write('What is your name? '),
    read(X),
    write('Hi '),
    write(X).

fav_char :-
    write('What is your fave character? '),
    get(X),
    format('The Ascii value ~w is ', [X]),
    put(X), nl.

write_to_file(File, Text) :-
    open(File, write, Stream),
    write(Stream, Text), nl,
    close(Stream).

read_file(File) :-
    open(File, read, Stream),
    get_char(Stream, Char1),
    process_stream(Char1, Stream),
    close(Stream).

process_stream(end_of_file, _) :- !.
process_stream(Char, Stream) :-
    write(Char),
    get_char(Stream, Char2),
    process_stream(Char2, Stream).

/* LISTS -- store atoms, complex terms, vars, lists
    store data with unknown # of elements

    | is the list constructor
    
    query:  write([albert| [alice, bob]]), nl.
    returns: [albert,alice,bob]
    
    query: length([1,2,3], X).
    returns X = 3

    can divide lists into head and tail parts
    query: [H|T] = [a, b, c]
    returns: H = a
            T = [b, c]
    
    query: [X1, X2, X3, X4|T] = [1, b, c, d].
    returns: T = []
            X1 = 1
            X2 = b
            X3 = c
            X4 = d
    
    w anonymous vars when we don't care about value
    query: [_, X2, _, _|T] = [a, b, c, d].
    returns: T = []
            X2 = b
    
    query: [_, _, [X|Y], _, Z|T] = [a, b, [c, d, e], f, g, h].
    returns: T = [h]
            X = c
            Y = [d,e]
            Z = g
    
    query: List1 = [a,b,c].
    
    then check is a inside:

    query: member(a, List1).
    returns: List1 = [a|_]?

    query: member(X, [a, b, c, d]).
    returns: X = a
            X = b
            X = c
            X = d
    */

    write_list([]).

    write_list([Head|Tail]) :-
        write(Head), nl,
        write_list(Tail).


    line_length((X1, Y1), (X2, Y2), Length) :-
    DX is X2 - X1,                      
    DY is Y2 - Y1,                      
    Length is sqrt(DX * DX + DY * DY).  

    print((X1, Y1), (X2, Y2), Length) :-
         line_length((X1, Y1), (X2, Y2), Length),
         write('length is '),
         write(length).

    /*
        writeln(SortedList),
    assert(side_list(SortedList)),

    nth0(0, SortedList, Element),
    writeln(Element).


equilateral(point2d(X,Y), point2d(X2,Y2), point2d(X3, Y3)) :-
    \+ line(point2d(X,Y), point2d(X2,Y2), point2d(X3, Y3)),
    store_sides(point2d(X,Y), point2d(X2,Y2), point2d(X3, Y3)),
    nth0(0, side_list, Element1),
    writeln(Element1),
    nth0(1, side_list, Element2),
    nth0(2, side_list, Element3),
    is_close(Element1,Element2),
    is_close(Element2,Element3).

is_close(A, B) :-
    Epsilon = 1.0e-6,
    Diff is abs(A - B),
    Diff =< Epsilon.
    */