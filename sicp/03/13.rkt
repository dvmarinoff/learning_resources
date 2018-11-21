#lang racket
;; ex 03.13
;; box-pointer diagram for make-cycle procedure
;;
;; Consider the following make-cycle procedure, which uses the last-pair
;; procedure defined in Exercise 3.12:
;;
;; (define (make-cycle x)
;;   (set-cdr! (last-pair x) x)
;;   x)

;; ... -> [..]->[..]->[..]->[..] -> ...
;;         a     b     c     d
;;        |
;;        z

;; Infinite recursion alert. Prepare for the C-g combination.
