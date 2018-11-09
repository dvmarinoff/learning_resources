#lang racket
;; ex 02.73
;; data-directed deriv package
;;
;; Section 2.3.2 described a program that performs symbolic
;; differentiation:
;;
;; (define (deriv exp var)
;;   (cond ((number? exp) 0)
;;         ((variable? exp)
;;          (if (same-variable? exp var) 1 0))
;;         ((sum? exp)
;;          (make-sum (deriv (addend exp) var)
;;                    (deriv (augend exp) var)))
;;         ((product? exp)
;;          (make-sum (make-product
;;                     (multiplier exp)
;;                     (deriv (multiplicand exp) var))
;;                    (make-product
;;                     (deriv (multiplier exp) var)
;;                     (multiplicand exp))))
;;         ;; ⟨ more rules can be added here ⟩
;;         (else (error "unknown expression type: DERIV" exp))))
;;
;; We can regard this program as performing a dispatch on the
;; type of the expression to be differentiated. In this situ-
;; ation the “type tag” of the datum is the algebraic operator
;; symbol (such as + ) and the operation being performed is deriv.
;; We can transform this program into data-directed style by
;; rewriting the basic derivative procedure as:
;;
;; (define (deriv exp var)
;;   (cond ((number? exp) 0)
;;         ((variable? exp) (if (same-variable? exp var) 1 0))
;;         (else ((get 'deriv (operator exp))
;;                (operands exp) var))))
;; (define (operator exp) (car exp))
;; (define (operands exp) (cdr exp))
;;
;; a. Explain what was done above. Why can’t we assimilate the
;; predicates number? and variable? into the data-directed
;; dispatch?
;;
;; b. Write the procedures for derivatives of sums and
;; products, and the auxiliary code required to install them in
;; the table used by the program above.
;;
;; c. Choose any additional differentiation rule that you like,
;; such as the one for exponents (Exercise 2.56), and install it
;; in this data-directed system.
;;
;; d. In this simple algebraic manipulator the type of an
;; expression is the algebraic operator that binds it together.
;; Suppose, however, we indexed the procedures in the opposite
;; way, so that the dispatch line in deriv looked like:
;;
;; ((get (operator exp) 'deriv) (operands exp) var)
;;
;; What corresponding changes to the derivative system are required?

;; a. there is no operation to dispath on for number? and variable?

;; b., c.

(define (install-deriv-packege)
  (define (make-sum a1 a2) (list '+ a1 a2))
  (define (make-product a1 a2) (list '* a1 a2))
  (define (make-exponentiation a1 a2) (list '** a1 a2))

  (define (addend x) (car x))
  (define (augend x) (cdr x))
  (define (multiplier x) (car x))
  (define (multiplicand x) (cdr x))
  (define (base x) (car x))
  (define (exponent x) (cdr x))

  (define (deriv-sum exp var)
    (make-sum (deriv (addend exp) var)
              (deriv (augend exp) var)))

  (define (deriv-product exp var)
    (make-sum (make-product
               (multiplier exp)
               (deriv (multiplicand exp) var))
              (make-product
               (deriv (multiplier exp) var)
               (multiplicand exp))))

  (define (deriv-exponent exp var)
    (make-product (exponent exp)
                  (make-product
                   (make-exponential
                    (base exp) (- (exponent exp) 1))
                   (deriv (base exp) var))))

  (put 'sum '+ deriv-sum)
  (put 'product '* deriv-product)
  (put 'exponent '** deriv-exponent)
  'done)

;;;;
;; the put and get operations
;;;;
(define types-operations-mapping (make-hash))

(define (put op type item)
  (hash-set types-operations-mapping '(op type) item))

(define (get op type)
  (hash-get types-operations-mapping '(op type)))

;;;;
;; Required code
;;;;
(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        (else ((get 'deriv (operator exp))
               (operands exp) var))))

(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

;; ((get (operator exp) 'deriv) (operands exp) var)

(define (variable? x)
  (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1)
       (variable? v2)
       (eq? v1 v2)))

;; d. switching the arguments op and type of put in the
;; package will help

