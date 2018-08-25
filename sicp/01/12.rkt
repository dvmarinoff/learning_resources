;; ex 1.12
;; The following pattern of numbers is called Pascal's triangle
;; The numbers at the edge of the triangle are all 1, and each
;; number inside the triangle is the sum of the two numbers
;; above it. Write a procedure that computes elements of
;; Pascal's triangle by means of a recursive process.
;;     1
;;    1 1
;;   1 2 1
;;  1 3 3 1
;; 1 4 6 4 1

(define (pascal j i)
  (cond ((> i j) 0)
        ((or (< i 1) (< j 0)) 0)
        ((or (= i 1) (= j 1)) 1)
        (else (+ (pascal (- j 1) (- i 1)) (pascal (- j 1) i)))))

;; \frac{n!}{(n - k)! * k!}
;; n choose k is with zero based index, we need to correct for it
(define (pascal-closed a b)
  (define n (- a 1))
  (define k (- b 1))
  (/ (fact n) (* (fact (- n k)) (fact k))))

(define (fact n)
  (if (= 0 n)
      1
      (* n (fact (- n 1)))))
