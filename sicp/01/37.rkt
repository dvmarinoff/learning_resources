#lang racket
;; ex 01.37
;; infinite continued fraction
;;
;; a. An infinite continued fraction is an expression of the form
;;
;; $f = \frac{N{1}}{D_{1} + \frac{N_{2}}}{D_{2} +
;; \frac{N_{3}}{D_{3} + \dots}}$
;;
;; As an example, one can show that the infinite continued
;; fraction expansion with the N i and the D i all equal to 1
;; produces 1/\phi , where \phi is the golden ratio (described
;; in section 1.2.2). One way to approximate an infinite
;; continued fraction is to truncate the expansion after a
;; given number of terms. Such a truncation -- a so-called
;; k-term finite continued fraction -- has the form
;;
;; \frac{N_{1}}{D_{1} + \frac{N_{2}}{\dots + \frac{N_{k}}{D_{k}}}}
;;
;; Suppose that n and d are procedures of one argument (the term
;; index i) that return the N i and D i of the terms of the
;; continued fraction. Define a procedure cont-frac such that
;; evaluating (cont-frac n d k) computes the value of the k-term
;; finite continued fraction. Check your procedure by
;; approximating 1/\phi using
;;
;; (cont-frac (lambda (i) 1.0)
;;            (lambda (i) 1.0)
;;            k)
;;
;; for successive values of k. How large must you make k in order
;; to get an approximation that is accurate to 4 decimal places?
;;
;; b. If your cont-frac procedure generates a recursive process,
;; write one that generates an iterative process. If it generates
;; an iterative process, write one that generates a recursive
;; process.

(cont-frac-iter (lambda (i) 1.0) (lambda (i) 1.0) 10)

(cont-frac (lambda (i) 1.0) (lambda (i) 1.0) 10)

(define (cont-frac n d k)
  (if (> 0 k)
      (/ (n k) (d k))
      (/ (n k) (+ (d k)
                  (cont-frac n d (dec k))))))

(define (cont-frac-iter n d k)
  (define (iter k next)
    (display (format "~a ~a\n" k next))
    (if (>= 0 k)
        next
        (iter (dec k) (/ (n k)
                         (+ (d k) next)))))
  (iter k 0))

(define (inc x)
  (+ x 1))

(define (dec x)
  (- x 1))

(define phi 1.6180)

(define one-over-phi (/ 1 phi))
