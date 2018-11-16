#lang racket
;; ex 02.80
;; generic =zero? predicate
;;
;; Define a generic predicate =zero? that tests if its argument
;; is zero, and install it in the generic arithmetic package.
;; This operation should work for ordinary numbers, rational
;; numbers, and complex numbers.

(define (install-=zero?-package)
  (define (=zero-scheme-number? x)
    (= x 0))

  (define (=zero?-rat-number? x)
    (= (numer x) 0))

  (define (=zero-complex-number? x)
    (and (= (real-part z) 0)
         (= (imag-part z) 0)))

  (put '=zero? '(scheme-number) =zero-scheme-number?)
  (put '=zero? '(rat-number) =zero-rat-number?)
  (put '=zero? '(complex-number) =zero-complex-number?)
  'done)

(define (=zero? x)
  (apply-generic '=zero? x))
