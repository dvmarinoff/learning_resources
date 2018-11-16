#lang racket
;; ex 02.79
;; generic equality equ?
;;
;; Define a generic equality predicate equ? that tests the
;; equality of two numbers, and install it in the generic
;; arithmetic package. This operation should work for ordinary
;; numbers, rational numbers, and complex numbers.

(define (install-equ?-package)
  (define (equ-scheme-number? a b)
    (= a b))

  (define (equ-rat-number? a b)
    (= (* (denom a) (numer b))
       (* (denom b) (numer a))))

  (define (equ-complex-number? a b)
    (and (= (real a) (real b))
         (= (imag a) (imag b))))

  (put 'equ? '(scheme-number scheme-number) equ-scheme-number?)
  (put 'equ? '(rat-number rat-number) equ-rat-number?)
  (put 'equ? '(complex-number complex-number) equ-complex-number?)
  'done)

(define (equ? a b)
  (apply-generic 'equ? a b))
