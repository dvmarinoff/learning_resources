#lang racket
;; ex 01.39
;; tangent approximation by Lambert's formula
;;
;; A continued fraction representation of the tangent function
;; was published in 1770 by the German mathematician J.H. Lambert:
;;
;; $tan x = \frac{x}{1 - \frac{x^{2}}{3 - \frac{x^{2}}{3 - \dots}}}$
;;
;; where x is in radians. Define a procedure (tan-cf x k) that
;; computes an approximation to the tangent function based on
;; Lambert's formula. K specifies the number of terms to compute,
;; as in exercise 1.37.

(tan 1)
(tan-cf 1.0 10)

(define (tan-cf x k)
  (cont-frac-iter (n-term x) d-term k))

(define (n-term x)
  (lambda (i)
    (if (= i 1)
        x
        (expt x 2))))

(define (d-term i)
  (+ i (dec i)))

(define (cont-frac-iter n d k)
  (define (iter k next)
    (if (>= 0 k)
        next
        (iter (dec k) (/ (n k)
                         (- (d k) next)))))
  (iter k 0))

;; 1 2 3 4 5  6
;; 1 3 5 7 9 11
;;
;; a_i = i + (i - 1)
