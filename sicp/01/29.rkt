#lang racket
;; ex 01.29
;; Simpson's rule

(simpsons-method cube 1.0 4.0 100)

(define (simpsons-method f a b n)
  (define h (h-value a b n))
  (* (/ h 3)
     (sum (y-term f a n h) a inc n)))

(define (h-value a b n)
  (/ (- b a) n))

(define (y-term f a n h)
  (lambda (k)
    (* (y-coefficient n k) (y f a h k))))

(define (y-coefficient n k)
  (cond ((= k 0) 1)
        ((= k n) 1)
        ((even? k) 2)
        (else 4)))

(define (y f a h k)
  (f (+ a (* k h))))

(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a) (sum term (next a) next b))))

(define (inc x)
  (+ x 1))

(define (cube x)
  (* x x x))

(define (identity x) x)

;;;;
;; Regular definite integral to check the answer
;;;;
(definite-integral 1.0 4.0 anti-deriv-cube)

(define (definite-integral a b antideriv)
  (- (antideriv b) (antideriv a)))

(define (anti-deriv-cube x)
  (/ (expt x 4.0) 4.0))

;;;;
;; Sicp integral for comparison
;;;;
(define (integral f a b dx)
  (define (add-dx x) (+ x dx))
  (* (sum f (+ a (/ dx 2.0)) add-dx b)
     dx))

(integral cube 1.0 4.0 0.01)
(integral cube 1.0 4.0 0.001)
(integral cube 1.0 4.0 0.0001)
(integral cube 1.0 4.0 0.00001)
(integral cube 1.0 4.0 0.000001)

(simpsons-method cube 1.0 4.0 100)
(simpsons-method cube 1.0 4.0 1000)
(simpsons-method cube 1.0 4.0 10000)
(simpsons-method cube 1.0 4.0 100000)
(simpsons-method cube 1.0 4.0 1000000)
(simpsons-method cube 1.0 4.0 10000000)
;; evaluating smaller dx is not a good idea on a 2014 laptop
;; (simpsons-method cube 1.0 4.0 100000000)
;; will consume 8GB of ram and over 4GB of swap

;; comparison
;;| n      | integral           | simpson           |
;;|--------+--------------------+-------------------|
;;| 100    | 63.749812499998654 | 63.74000000000004 |
;;| 1000   | 63.74999812498594  | 63.749            |
;;| 10000  | 63.74999998138662  | 63.74989999999975 |
;;| 1*10^5 | 63.75000000065056  | 63.74998999999972 |
;;| 1*10^6 | 63.75000000455022  | 63.74999899999974 |
;;| 1*10^7 |                    | 63.749999899988396|
;;
;; integral moves towards 63.750, while simpson moves towards
;; 63.749999, integral makes larger steps and osciliates around
;; the value, while simpson is still impoving precision

(> (- 63.75 63.75000000065056)
   (- 63.75 63.749999899988396))
