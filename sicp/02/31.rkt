#lang racket
;; ex 02.31
;; abstract tree-map procedure
;;
;; Abstract your answer to exercise 2.30 to produce a procedure
;; tree-map with the property that square-tree could be defined as
;;
;; (define (square-tree tree) (tree-map square tree))

(define (square-tree tree)
  (tree-map sqr tree))

(define (tree-map fn xs)
  (map (lambda (x)
         (if (pair? x)
             (tree-map fn x)
             (fn x)))
       xs))
