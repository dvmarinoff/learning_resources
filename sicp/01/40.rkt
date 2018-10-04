#lang racket
;; ex 01.40
;; cubic for newton's method
;;
;; Define a procedure cubic that can be used together with the
;; newtons-method procedure in expressions of the form
;; (newtons-method (cubic a b c) 1) to approximate zeros of the
;; cubic:
;;
;; $x^{3} + ax^{2} + bx + c$

(newtons-method (cubic 1 2 3) 1)

(define (cubic a b c)
  (lambda (x)
    (+ (cube x)
       (* a (sqr x))
       (* b x)
       c)))

(define (cube x)
  (* x x x))

(define (newtons-method g guess)
  (fixed-point (newton-transform g) guess))

(define (newton-transform g)
  (lambda (x)
    (- x (/ (g x) ((deriv g) x)))))

(define (deriv g)
  (lambda (x)
    (/ (- (g (+ x dx)) (g x))
       dx)))

(define dx 0.00001)

(define (fixed-point f first-guess)
  (define (try guess)
    (let ((next (f guess)))
      (if (close-enough? guess next)
          next
          (try next))))
  (try first-guess))

(define (close-enough? x y)
  (< (abs (- x y)) 0.00001))
