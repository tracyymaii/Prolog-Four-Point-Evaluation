# Prolog Programming 

## Motivation
Artificial Intelligence has gotten more attention in recent years. There are more AI tools available to the public than ever before: Alexa, Siri, Ericka, etc. not to mention services like Google Cloud Machine Learning, Deep Learning on AWS, IBM Cognitive, Microsoft Azure Machine Learning, etc. One of the early attempts to deal with AI was the development of “AI specific” languages. This is the case of Prolog, a declarative language that stores facts and rules (and other constructs as well), and has an interface where the user can query and make questions that Prolog’s engine will answer inferring from the facts and rules that where stored.
Another motivation for this assignment is to expose students to a completely different paradigm of programming. Up to this moment, most of the students have been working and coding with imperative and object-oriented languages, and a declarative language should pose a new challenge, as it requires a different way to think.

## Description
Writes a Prolog program that stores information about geometric objects using lists to store information about the shapes.
Constructs rules for geometric objects. 
The objects constructed are:
- 2D Point
- Triangle
- Square

The program answers the following questions:

English | Prolog
------- | ------
Is the line defined by two points vertical? |	`vertical(point2d(x,y), point2d(x,y))`
Is the line defined by two points horizontal? |	`horizontal(point2d(x,y), point2d(x,y))`
Do the given three points define a line? |	`line(point2d(x,y), point2d(x,y), point2d(x,y))`
Do the given three points define a triangle? | `triangle(point2d(x,y), point2d(x,y), point2d(x,y))`
Is the triangle isosceles? |	`isosceles(point2d(x,y), point2d(x,y), point2d(x,y))`
Is the triangle equilateral? |	`equilateral(point2d(x,y), point2d(x,y), point2d(x,y))`
Is the triangle right? |	`right(point2d(x,y), point2d(x,y), point2d(x,y))`
Is the triangle scalene? |	`scalene(point2d(x,y), point2d(x,y), point2d(x,y))`
Is the triangle acute? |	`acute(point2d(x,y), point2d(x,y), point2d(x,y))`
Is the triangle obtuse?	| `obtuse(point2d(x,y), point2d(x,y), point2d(x,y))`
Do the given four points define a square? | `square(point2d(x,y), point2d(x,y), point2d(x,y), point2d(x,y))`


## Instructions for Testing
A file named `test.pl` is provided. You will need to append this file to the end of your code, create a new file called `full.pl` that contains your code and then the code from `test.pl`, and then run Prolog from the command line:  

`swipl -q -f full.pl -t main > your-output.txt`

The command tells prolog to run quietly using the file `full.pl` and to execute target `main`. The query main will then run each of the queries. Once the process is finished, there will be a file named `your-output.txt` you can then compare this file with another file that is provided: `output.txt` to check if your results are correct. Before turning in your assignment make sure that your file `fourpoints.pl` does not have test code.


Steps to integrate the parser made in Rust:
1. Create a 4Points Language "program" call it `test.cpl`, define four points, remember to add tests.
1. Run your parser: `go run . test.cpl -p > mytest.pl`
1. Paste your generated test to your prolog program: `cat fourpoints.pl mytest.pl > full.pl`
1. Run your program to check what those point tests in `test.cpl` represent: `swipl -q -f full.pl -t main`
