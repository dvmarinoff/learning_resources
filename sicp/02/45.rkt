#lang racket
;; ex 02.45
;; picture language generalized split procedure
;;
;; Right-split and up-split can be expressed as instances of a
;; general splitting operation. Define a procedure split with the
;; property that evaluating
;;
;; (define right-split (split beside below))
;;
;; (define up-split (split below beside))
;;
;; produces procedures right-split and up-split with the same
;; behaviors as the ones already defined.

(require sicp-pict)

(define right-split (split beside below))

(define up-split (split below beside))

(define (split combinator1 combinator2)
  (lambda (p n)
    (define (recur painter n)
      (if (= n 0)
          painter
          (let ((smaller (recur painter (- n 1))))
            (combinator1 painter (combinator2 smaller smaller)))))
    (recur p n)))

(paint (up-split einstein 2))
(equal? (paint (right-split einstein 2))
        (paint (right-split einstein 2)))
