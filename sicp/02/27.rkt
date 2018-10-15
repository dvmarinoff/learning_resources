#lang racket
;; ex 02.27
;; deep-reverse procedure
;;
;; Modify your reverse procedure of exercise 2.18 to produce a
;; deep-reverse procedure that takes a list as argument and
;; returns as its value the list with its elements reversed and
;; with all sublists deep-reversed as well. For example,
;;
;; (define x (list (list 1 2) (list 3 4)))
;; x
;; ((1 2) (3 4))
;; (reverse x)
;; ((3 4) (1 2))
;; (deep-reverse x)
;; ((4 3) (2 1))

(define x (list (list 1 2) (list 3 4)))

(define y '((1 2 (3 4 (5 6 7 8) 9) 10)))

(deep-reverse y)
(deep-sum y)

(define deep-reverse (traverse reverse))
(define deep-sum (traverse sum-list))

(define (traverse fn)
  (lambda (xs)
    (define (recur xs)
      (if (not (list? xs))
         xs
         (fn (map recur xs))))
    (recur xs)))

(define (reverse lst)
  (foldl (lambda (a b) (cons a b)) '() lst))

(define (sum-list lst)
  (foldl + 0 lst))
