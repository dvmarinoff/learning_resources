#lang racket
;; ex 02.56
;; add power rule

(require sicp)


;;;;
;; solution
;;;;
(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var) 1 0))
        ((sum? exp)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var)))
        ((product? exp)
         (make-sum
          (make-product (multiplier exp)
                        (deriv (multiplicand exp) var))
          (make-product (deriv (multiplier exp) var)
                        (multiplicand exp))))
        ((exponentiation? exp)
         (make-product (exponent exp)
                       (make-exponentiation
                        (base exp)
                        (dec (exponent exp)))))
        (else
         (error "unknown expression type -- DERIV" exp))))

(define (make-exponetiation base exponent)
  (list '** base exponent))

(define (exponentiation? exp)
  (and (pair? exp) (eq? (car exp) '**)))

(define (base exp) (cadr exp))

(define (exponent exp) (caddr exp))

;;;;
;; required code
;;;;
(define (variable? x) (symbol? x))

(define (same-variable? x y)
  (and (variable? x) (variable? y) (eq? x y)))

(define (make-sum x y)
  (cond ((=number? x 0) y)
        ((=number? y 0) x)
        ((and (number? x) (number? y)) (+ x y))
        (else (list '+ x y))))

(define (sum? exp)
  (and (pair? exp) (eq? (car exp) '+)))

(define (=number? exp n)
  (and (number? exp) (= exp n)))

(define (addend exp) (car (cdr exp)))

(define (augend exp) (car (cdr (cdr exp))))

(define (make-product x y)
  (cond ((or (=number? x 0) (=number? y 0)) 0)
        ((=number? x 1) y)
        ((=number? y 1) x)
        ((and (number? x) (number? y)) (* x y))
        (else (list '* x y))))

(define (product? exp)
  (and (pair? exp) (eq? (car exp) '*)))

(define (multiplier exp) (car (cdr exp)))

(define (multiplicand exp) (car (cdr (cdr exp))))
;; (deriv '(+ x 3) 'x)
;; (deriv '(* x y) 'x)
;; (deriv '(* (* x y) (+ x 3)) 'x)
