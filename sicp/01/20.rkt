;; ex 1.20
;; The process that a procedure generates is of course dependent
;; on the rules used by the interpreter. As an example, consider
;; the iterative gcd procedure given above. Suppose we were to
;; interpret this procedure using normal-order evaluation, as
;; discussed in section 1.1.5. (The normal-order-evaluation rule
;; for if is described in exercise 1.5.) Using the substitution
;; method (for normal order), illustrate the process generated in
;; evaluating (gcd 206 40) and indicate the remainder operations
;; that are actually performed. How many remainder operations are
;; actually performed in the normal-order evaluation of
;; (gcd 206 40)? In the applicative-order evaluation?

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

;; applicative order:
;; 206 % 40 = 6
;;  40 %  6 = 4
;;   6 %  4 = 2
;;   4 %  2 = 0
;;
;; remainder is called 4 times
;;
;; normal order:
;;
;; remainder is called
;; 1 + 2 + (1 + 2 + (1)) + (2 + (1 + 2 + 1) + (1)) + 4 = 18
