#lang racket
;; ex 03.08
;; order of evaluation with mutable state
;;
;; When we defined the evaluation model in section 1.1.3, we said
;; that the first step in evaluating an expression is to evaluate
;; its subexpressions. But we never specified the order in which
;; the subexpressions should be evaluated (e.g., left to right or
;; right to left). When we introduce assignment, the order in
;; which the arguments to a procedure are evaluated can make a
;; difference to the result. Define a simple procedure f such
;; that evaluating (+ (f 0) (f 1)) will return 0 if the arguments
;; to + are evaluated from left to right but will return 1 if the
;; arguments are evaluated from right to left.

;; (+ (f 0) (f 1))
;; -> 0
;; -> 1

;; ???? that one feels like a puzzle, how to make the most
;; complicated assaignment chain, shared state is wierd.
(define f
  (let ((last 0))
    (lambda (x)
      (let ((result last))
        (set! last x)
        result))))

;; (+ (f 0) (f 1))
;; -> 0
;; (+ (f 1) (f 0))
;; -> 1
