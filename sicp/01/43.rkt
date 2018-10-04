#lang racket
;; ex 01.43
;; repeated applicaion procedure
;;
;; If f is a numerical function and n is a positive integer, then
;; we can form the nth repeated application of f, which is
;; defined to be the function whose value at x is
;; f(f(...(f(x))...)). For example, if f is the function x x + 1,
;; then the nth repeated application of f is the function x x +
;; n. If f is the operation of squaring a number, then the nth
;; repeated application of f is the function that raises its
;; argument to the 2 n th power. Write a procedure that takes as
;; inputs a procedure that computes f and apositive integer n and
;; returns the procedure that computes the nth repeated
;; application of f. Your procedure should be able to be used as
;; follows:
;;
;; ((repeated square 2) 5)
;; 625
;;
;; Hint: You may find it convenient to use compose from
;; exercise 1.42.

((repeated sqr 2) 5)

((repeated-compose sqr 2) 5)

(define (repeated f n)
  (lambda (x)
    (recur f n x)))

(define (recur f n x)
  (if (= 0 n)
      x
      (f (recur f (dec n) x))))

(define (repeated-compose f n)
  (if (= 1 n)
      f
      (compose f (repeated-compose f (dec n)))))

(define (compose f g)
  (lambda (x)
    (f (g x))))

(define (dec x)
  (- x 1))
