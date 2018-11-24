#lang racket
;; ex 03.17
;; write count-pairs that works
;;
;; Devise a correct version of the count-pairs procedure of
;; Exercise 3.16 that returns the number of distinct pairs in
;; any structure. (Hint: Traverse the structure, maintaining an
;; auxiliary data structure that is used to keep track of which
;; pairs have already been counted.)
;;
;; (define (count-pairs-naive x)
;;   (if (not (pair? x))
;;       0
;;       (+ (count-pairs-naive (car x))
;;          (count-pairs-naive (cdr x))
;;          1)))

(define a '(a))
(define b (cons 'b a))
(define c (cons a a))
(define three '(a b c))
(define four (cons b a))
(define seven (cons c c))

(define (count-pairs x)
  (define counted '())
  (define (recur x)
    (cond ((not (pair? x)) 0)
          ((memq x counted) 0)
          (else (begin (set! counted (cons x counted))
                       (+ (recur (car x))
                          (recur (cdr x))
                          1)))))
  (recur x))
