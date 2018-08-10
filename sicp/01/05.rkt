;; ex 1.4

;; Don't run the code, unless you really need to warm up your lap!

;; Ben Bitdiddle has invented a test to determine whether the
;; interpreter he is faced with is using applicative-order
;; evaluation or normal-order evaluation. He defines the
;; following two procedures:

(define (p) (p))

(define (test x y)
  (if (= x 0)
      0
      y))

;; Then he evaluates the expression

(test 0 (p))

;; What behavior will Ben observe with an interpreter that uses
;; applicative-order evaluation? What behavior will he observe
;; with an interpreter that uses normal-order evaluation?
;; Explain your answer.

;; with applicative-order he will observe infinite recursion
;; since the p procedure will be calling itself until the
;; stack is full.

;; with normal-order he will get 0, since the evaluation of y,
;; which is p will be delayed until needed, which is never in
;; this case.
