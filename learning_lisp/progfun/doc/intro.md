# Introduction to progfun

Solutions in Clojure to task from the "Principals of Functional Programming in Scala" by Martin Odersky

Week 1:

task 1: Pascal’s Triangle

  Write a function that computes the elements of Pascal’s triangle
by means of a recursive process. Do this exercise by implementing
the pascal function in Main.scala, which takes a column c and a row r,
counting from 0 and returns the number at that spot in the triangle. 

For example, pascal(0,2)=1,pascal(1,2)=2 and pascal(1,3)=3.

task 2: Parentheses Balancing

  Write a recursive function which verifies the balancing of parentheses
in a string, which we represent as a List[Char] not a String.

  - (if (zero? x) max (/ 1 x))
  - I told him (that it’s not (yet) done). (But he wasn’t listening)
  - :-)
  - ())( 
  
task 3: Counting Change

  Write a recursive function that counts how many different ways you
can make change for an amount, given a list of coin denominations.
For example, there are 3 ways to give change for 4 if you have coins
with denomination 1 and 2: 1+1+1+1, 1+1+2, 2+2.

  Do this exercise by implementing the countChange function inMain.scala.
This function takes an amount to change, and a list of unique
denominations for the coins.
