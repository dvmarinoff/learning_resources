#lang racket
;; ex 02.05
;; representing pairs of numbers with 2^a * 3^b
;;
;; Show that we can represent pairs of nonnegative integers using
;; only numbers and arithmetic operations if we represent the
;; pair a and b as the integer that is the product 2 a 3 b . Give
;; the corresponding definitions of the procedures cons, car, and
;; cdr.

(define (cons a b)
  (* (expt 2 a) (expt 3 b)))

(define (car p)
  (define (iter p b)
    (let ((a (guess-a p b)))
      (if (integer? a)
          (inexact->exact a)
         (iter p (inc b)))))
  (iter p 1))

(define (cdr p)
  (define (iter p b)
    (let ((a (guess-a p b)))
      (if (integer? a)
          (inexact->exact b)
         (iter p  (inc b)))))
  (iter p 1))

(define (guess-a pair-product b)
  (log (/ pair-product (expt 3.0 b)) 2))

(define (inc x)
  (+ x 1))
