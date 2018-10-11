#lang racket
;; ex 02.13
;; interval arithmetic simplified approximate percentage
;;
;; Show that under the assumption of small percentage tolerances
;; there is a simple formula for the approximate percentage
;; tolerance of the product of two intervals in terms of the
;; tolerances of the factors. You may simplify the problem by
;; assuming that all numbers are positive. After considerable
;; work, Alyssa P. Hacker delivers her finished system. Several
;; years later, after she has forgotten all about it, she gets a
;; frenzied call from an irate user, Lem E. Tweakit. It seems
;; that Lem has noticed that the formula for parallel resistors
;; can be written in two algebraically equivalent ways:
;;
;; $\frac{R_{1}R_{2}}{R_{1} + R_{2}}$
;; and
;; $/frac{1}{\frac{1}{R_{1}} + \frac{1}{R_{2}}}$
;;
;; He has written the following two programs, each of which
;; computes the parallel-resistors formula differently:
;;
(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
                (add-interval r1 r2)))

(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval one
                  (add-interval (div-interval one r1)
                                (div-interval one r2)))))
;;
;; Lem complains that Alyssa's program gives different answers
;; for the two ways of computing. This is a serious complaint.

;;;;
;; answer
;;;;

;; Since I am not in a mood for matemathical rigor here, my
;; results are purely based on computation experiments (repl).
;; The formula seems to be something like:
;;
;; tolerance_a + tolerance_b ~ tolerance_product_ab,
;;
;; where a and b are intervals from center and percentage
;; tolerance

(define (approximate-product-percentage a b)
  (+ (percent a) (percent b)))

(define a (make-center-percent  5.0 3.5))
(define b (make-center-percent  5.0 3.5))
(define c (mul-interval a b))
(percent c)
(approximate-product-percentage a b)

(< (abs (- (percent c)
           (approximate-product-percentage a b)))
   0.01)

;;;;
;; code from prev exercieses
;;;;
(define (make-center-percent c t)
  (make-center-width c (/ (* c t) 100)))

(define (percent i)
  (/ (* (width i) 100) (center i)))

(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))

(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))

(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

(define (make-interval a b)
  (cons a b))

(define (lower-bound interval)
  (car interval))

(define (upper-bound interval)
  (cdr interval))

(define (add-interval a b)
  (make-interval (+ (lower-bound a) (lower-bound b))
                 (+ (upper-bound a) (upper-bound b))))

(define (sub-interval a b)
  (make-interval (- (lower-bound a) (lower-bound b))
                 (- (upper-bound a) (upper-bound b))))

(define (mul-interval a b)
  (let ((p1 (* (lower-bound a) (lower-bound b)))
        (p2 (* (lower-bound a) (upper-bound b)))
        (p3 (* (upper-bound a) (lower-bound b)))
        (p4 (* (upper-bound a) (upper-bound b))))
    (make-interval (min p1 p2 p3 p4)
                   (max p1 p2 p3 p4))))

(define (div-interval a b)
  (mul-interval a
                (make-interval (/ 1.0 (upper-bound b))
                               (/ 1.0 (lower-bound b)))))
