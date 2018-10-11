#lang racket
;; ex 02.15
;; interval arithmetic is par1 better than par2
;;
;; Eva Lu Ator, another user, has also noticed the different
;; intervals computed by different but algebraically equivalent
;; expressions. She says that a formula to compute with intervals
;; using Alyssa's system will produce tighter error bounds if it
;; can be written in such a form that no variable that represents
;; an uncertain number is repeated. Thus, she says, par2 is a
;; ``better'' program for parallel resistances than par1. Is she
;; right? Why?

(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
                (add-interval r1 r2)))

(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval one
                  (add-interval (div-interval one r1)
                                (div-interval one r2)))))

;; yes she is right. This is because dividing interval by itself
;; produces not 1 but an approximation (ex. 2.14).
