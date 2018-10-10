#lang racket
;; ex 02.08
;; interval arithmetic sub-interval procedure
;;
;; Using reasoning analogous to Alyssa's, describe how the
;; difference of two intervals may be computed. Define a
;; corresponding subtraction procedure, called sub-interval.

(define (sub-interval a b)
  (make-interval (- (lower-bound a) (lower-bound b))
                 (- (upper-bound a) (upper-bound b))))


(define (make-interval a b)
  (cons a b))

(define (lower-bound interval)
  (car interval))

(define (upper-bound interval)
  (cdr interval))
