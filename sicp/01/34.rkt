#lang racket
;; ex 01.34
;; circular definition
;;
;; Suppose we define the procedure
(define (f g)
  (g 2))

;; Then we have

(f sqr)
;; -> 4

(f (lambda (z) (* z (+ z 1))))
;; -> 6

;; What happens if we (perversely) ask the interpreter to evaluate
;; the combination (f f)? Explain.

(f f)

;; In racket:
;; ->
;; Error: struct:exn:fail:contract

;; application: not a procedure;
;; expected a procedure that can be applied to arguments
;; given: 2
;; arguments...:
;; 2

;; at the end it is tring to evaluate (2 2)
