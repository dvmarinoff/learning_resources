#lang racket
;; ex 03.01
;; make-accumulator procedure
;;
;; An accumulator is a procedure that is called repeatedly with a
;; single numeric argument and accumulates its arguments into a
;; sum. Each time it is called, it returns the currently
;; accumulated sum. Write a procedure make-accumulator that
;; generates accumulators, each maintaining an independent sum.
;; The input to make-accumulator should specify the initial value
;; of the sum for example

(define A (make-accumulator 5))

;; (A 10)
;; -> 15
;; (A 10)
;; -> 25

(define (make-accumulator n)
  ())

(define (withdraw account amount)
  (cond ((>= (balance account) amount) (- balance amount))
        (else "Insufficient funds")))

(define (make-account balance)
  (list balance))

(define (balance account)
  (car account))

(define bob (make-account 100))

(withdraw bob 25)
