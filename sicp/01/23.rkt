#lang racket
;; ex 01.23
;; improve smallest-divisor procedure
;;
;; The smallest-divisor procedure shown at the start of this
;; section does lots of needless testing: After it checks to see
;; if the number is divisible by 2 there is no point in checking
;; to see if it is divisible by any larger even numbers. This
;; suggests that the values used for test-divisor should
;; not be 2, 3, 4, 5, 6, ..., but rather 2, 3, 5, 7, 9, ....
;; To implement this change, define a procedure next that returns
;; 3 if its input is equal to 2 and otherwise returns its input
;; plus 2. Modify the smallest-divisor procedure to use (next
;; test-divisor) instead of (+ test-divisor 1).
;; Withtimed-prime-test incorporating this modified version of
;; smallest-divisor, run the test for each of the 12 primes found
;; in exercise 1.22. Since this modification halves the number of
;; test steps, you should expect it to run about twice as fast.
;; Is this expectation confirmed? If not, what is the observed
;; ratio of the speeds of the two algorithms, and how do you
;; explain the fact that it is different from 2?

;;;;
;; Sicp code
;;;;
(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (square x)
  (sqr x))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (next test-divisor)))))

(define (divides? a b)
  (= (remainder b a) 0))

;;;;
;; Solution
;;;;
(define (next x)
  (if (= 2 x)
      3
      (+ x 2)))

(define (search-for-primes min max)
  (filter prime? (range min max 2 '())))

(define (range min max step lst)
  (if (< max min)
      lst
      (range min (- max step) step (cons max lst))))

(define (take n lst)
  (take-iter '() 0 n lst))

(define (take-iter taken i n lst)
  (if (or (= i n) (null? lst))
      (reverse taken)
      (take-iter (cons (car lst) taken) (+ i 1) n (cdr lst))))

(timed-prime-test 1009)
(timed-prime-test 10007)
(timed-prime-test 100003)
(timed-prime-test 1000003)
