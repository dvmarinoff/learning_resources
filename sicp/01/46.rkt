#lang racket
;; ex 01.46
;; iterative improve procedure
;;
;; Several of the numerical methods described in this chapter are
;; instances of an extremely general computational strategy known
;; as iterative improvement. Iterative improvement says that, to
;; compute something, we start with an initial guess for the
;; answer, test if the guess is good enough, and otherwise
;; improve the guess and continue the process using the improved
;; guess as the new guess. Write a procedure iterative-improve
;; that takes two procedures as arguments: a method for telling
;; whether a guess is good enough and a method for improving a
;; guess. Iterative-improve should return as its value a
;; procedure that takes a guess as argument and keeps improving
;; the guess until it is good enough. Rewrite the sqrt procedure
;; of section 1.1.7 and the fixed-point procedure of section
;; 1.3.3 in terms of iterative-improve.

(define (iterative-improve good-enuf? improve)
  (lambda (start-guess)
    (define (iter guess)
      (if (good-enuf? guess)
          guess
          (iter (improve guess))))
    (iter start-guess)))

(define (sqrt x)
  ((iterative-improve
    (lambda (y)
      (< (abs (- (sqr y) x))
         tolerance))
    (lambda (y)
      (average y (/ x y))))
   1.0))

(define (fixed-point f start-guess)
  ((iterative-improve
    (lambda (x) (close-enough? x (f x)))
    f)
   start-guess))

(define (close-enough? v1 v2)
  (< (abs (- v1 v2)) tolerance))

(define tolerance 0.00001)
