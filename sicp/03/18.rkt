#lang racket

(require r5rs/init)

;; ex 03.18
;; find cycle procedure
;;
;; Write a procedure that examines a list and determines whether
;; it contains a cycle, that is, whether a program that tried to
;; find the end of the list by taking successive cdr s would go
;; into an infinite loop. Exercise 3.13 constructed such lists.

(define (cycle-structure? x)
  (define counted '())
  (define (recur x)
    (cond ((null? x) #f)
          ((memq x counted) #t)
          (else (begin (set! counted (cons x counted))
                       (recur (cdr x))))))
  (recur x))
