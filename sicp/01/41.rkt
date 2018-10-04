#lang racket
;; ex 01.41
;; double apply

(define (double f)
  (lambda (x)
    (f (f x))))

((double inc) 1)

(((double (double double)) inc) 5)
