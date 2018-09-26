#lang racket
;; ex 01.33
;; filtered-accumulate procedure abstraction
;;
;; You can obtain an even more general version of
;; accumulate (exercise 1.32) by introducing the notion of a
;; filter on the terms to be combined. That is, combine only
;; those terms derived from values in the range that satisfy a
;; specified condition. The resulting filtered-accumulate
;; abstraction takes the same arguments as accumulate, together
;; with an additional predicate of one argument that specifies
;; the filter. Write filtered-accumulate as a procedure. Show how
;; to express the following using filtered-accumulate:
;;
;; a. the sum of the squares of the prime numbers in the
;; interval a to b (assuming that you have a prime? predicate
;; already written)
;;
;; b. the product of all the positive integers less than n that
;; are relatively prime to n (i.e., all positive integers i < n
;; such that GCD(i,n) = 1)


(define (filtered-accumulate pred combiner null-value term a next b)
  (cond ((> a b) null-value)
        ((pred a) (combiner (term a)
                            (filtered-accumulate pred
                                                  combiner
                                                  null-value
                                                  term
                                                  (next a)
                                                  next
                                                  b)))
        (else (filtered-accumulate pred
                                   combiner
                                   null-value
                                   term
                                   (next a)
                                   next
                                   b))))

(define (identity x) x)

(define (inc x)
  (+ x 1))

(define (filtered-sum pred term a next b)
  (filtered-accumulate pred + 0 term a next b))

(define (filtered-product pred term a next b)
  (filtered-accumulate pred * 1 term a next b))

;; a.
(define (sum-of-prime-squares a b)
  (filtered-sum prime? sqr a inc b))

;; b.
(define (product-of-positive-relative-primes n)
  (filtered-product (relative-prime? n) identity 1 inc n))

(define (relative-prime? n)
  (lambda (x)
    (= 1 (gcd n x))))
