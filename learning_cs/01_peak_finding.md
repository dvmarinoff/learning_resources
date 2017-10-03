# Algorithmic Thinking, Peak Finding

First Problem:

## Peak Finding

Easy, but points out the issues envolved in designing an
efficient algorithm.

### We start with a one-dimensional version.

runs on an array of numbers (positive, negative) and finds
a peak.

[a, b, c, d, e, f, g, h, i]  
 1  2  3  4  5  6  7  8  9

A peak is:
position 2 is a peak if and only if b >= a and b >= c
in case of edges position 9 is a peak if i >= h

#### Straightforward algorithm

Start from left

 1 2 ... n/2 n-1 n  
[,,,,,,,,,,,,,,,,,]

We have to precisely categorising what it's complexity
is in relation to n.

Argue that any array will always have a peak.

You want to create algorithms that are general, so if
the the problem definition changes on you, you still
have a starting point to go attack the new version.

In case it is at the middle it looks at n/2 elements

Worst-case complexity is:
Theta(n)
or linear complexity
Can we do better?

#### Divide and Conquer Strategy

If a[n/2] < a[n/2 - 1] then only consider lower part a[0, n/2 - 1]
If a[n/2] < a[n/2 + 1] then only consider upper paart a[n/2 + 1, n]
Else n/2 is the peak

Complexity:

T(n) = T(n/2) + Theta(1)

### Two-dimensional Version

|   |   |   |   |
|:-:|:-:|:-:|:-:|
| . | c | . | . |
| b | a | d | . |
| . | e | . | . |
| . | . | . | . |



a is a 2D-peak if:  
a >= b,  
a >= d,  
a >= c,  
a >= e  

Complexity:

> T(n/2) + Theta(1)

base case: T(1) = Theta(1)  
T(n) = Theta(1) + ... + Theta(1) = Theta(log2n)


* First Try: Greedy Acsend Algorithm

It picks a direction and tries to follow that direction
in order find a peak.

|      |      |      |      |
|:----:|:----:|:----:|:----:|
|   .  |   .  |   .  |   .  |
| -14- | -13- | -12- |   .  |
| -15- |  9   | 11   | 17   |
| -16- | -17- | -19- | >20  |

12 -> 13 -> 15 -> 16 -> 17 -> 19 -> 20

Complexity:

> Theta(n,m)
> Theta(n^2) if m = n

* Second Try: Divide and Conquer aproach

Attempt 1:  
Pick middle column j = m/2  
Find a 1D peak at (i,j)  
Use (i,j) as a start to find a 1D pick on row i

Complexity: just a couple of log2n steps,  
Problem: but a 2D peak may not exist on row i

Efficient but INCORECT

Attempt 2:  

Pick middle column j = m/2  
Find global max on column j at (i,j)  
Compare (i, j - 1), (i,j), (i, j + 1),  
just look to the left and right and compare
Pick left cols if (i, j - 1) > (i, j)
Similarly for the right
If (i, j) >= (i, j - 1), (i, j + 1) => (i, j) is a 2D peak
If none then I am done


Solve the new problem with half the number of cols.  
When you have a single col, find the global max <- done.

Complexity:

The recurence relation is:  
T(n,m) = T(n, m/2) + Theta(n)  

T(n,1) = Theta(n)
T(n,m) = Theta(n) + ... + Theta(n) = Theta(n log2m)  
.....................|.............................    
...........Theta(n) log2m times....................  


## Recitation

### Asymptotic Complexity

A very nice tool with which given a horrible function like

> g(x) = 1.1x^2^ + (10 + sin(x + 1.5)) * x^1.5^ + 6006

you can just say that it is equal to \theta (x^2^)

^  
|  
|f'(x) - upper bound   
|g(x) - complex function  
|f(x) = x^2^ - lower bound  
|  
+------------>

On bigger and bigger scale, as size of input grows,
you want be able to see the sine waves any more.
That is, because all the noise is in the x^1.5 term.
So as input grows x^2 grows much faster than x^1.5


The three symbols important for asymptotic complexity are:

Theta , O, Omega

If I say that g(x) = Theta(f(x)) it means two things:  
    * I have a lower bound x^2^, under g(x)  
    * I have an upper bound that also looks like x^2^,  
     but over g(x).  
     
Note: When we use Theat bounds can differ only by
a constant factor. 


A make a promise the function stays between the lower and
the upper bounds.



Example 2:

lets consider the function:

> g(x) = x * (1 + sin(x))

the graph is going to hit 0 at infinite number of values,
so the lower bound is 0, but you can be sure it is never
going to be bigger then f(x) = 2x. And we have only
upper bound to work with.In this case we say that:

> g(x) = O(f(x)) 

O - only upper bound (reads Order)


Example 3:

lets consider the function:

> f(x) = (1 + sin(x)) * x^1.5^ + x^1.4^

upper bound is:
f'(x) = 3x^1.5^

lower bound is:
f(x) = x^1.4^


Bounds differ by exponent, which is more than a constant
factor, so they don't look the same.

So in this wierd case you can only say:

> g(x) = Theta () - in this case not possible
> g(x) = Omega (x^1.4^) - lower bound
> g(x) = O(x^1.5^) - upper bound

Note: we are going to use O instead of Theta for most of
the time, because of convenience

Most recurence relations will resolve to:  

> O(1)  
> O(log n)  
> O(n)  
> O(n log n)  
> O(n^2^)  

Theta - both  
Omega - lower bound   
O - upper bound  



Note: logs

log(n^100^) = 100 log(n) -> Theta(n)

exponent can be pulled infront of

log~5~(n) = log(n) / log 5 -> Theta(lg n)



q1:

f(n) - Theta(?)

1) f(n) = 10^80^
-> Theta(1)

Note: 10^80^ is the estimated number of atoms in the
universe, so realistically any quantity that will represent
the real world, is not going to be bigger than this.
'Philosophicaly' for any algorithm in any realistic input
the running time will be Theta(1).

2) f(n) = (20n)^7^
-> Theta(n^7^)

3) f(n) = 

### Methodology for Proofs
