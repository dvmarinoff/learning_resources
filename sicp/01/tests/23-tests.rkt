#lang racket

(require rackunit rackunit/text-ui)

(load "../23.rkt")

(define (search-for-primes min max)
  (filter prime? (range min max 2 '())))

(define (prime? n)
  (= n (smallest-divisor n)))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (divides? a b)
  (= (remainder b a) 0))

(define (square x)
  (* x x))

(define (range min max step lst)
  (if (< max min)
      lst
      (range min (- max step) step (cons max lst))))

(define (take n lst)
  (take-iter '() 0 n lst))

(define (take-iter taken i n lst)
  (if (or (= i n) (null? lst))
      (reverse taken)
      (take-iter (cons (car lst) taken) (+ i 1) n (cdr lst))))

(define sicp-01.23-tests
  (test-suite
   "testing 01.23 improve smallest-divisor procedure"

    (check-equal? (prime? 3) #t)
    (check-equal? (prime? 4) #f)
    (check-equal? (prime? 5) #t)
    (check-equal? (prime? 6) #f)
    (check-equal? (prime? 7) #t)
    (check-equal? (prime? 8) #f)
    (check-equal? (prime? 9) #f)
    (check-equal? (prime? 10) #f)
    (check-equal? (prime? 11) #t)
    (check-equal? (prime? 12) #f)
    (check-equal? (prime? 13) #t)
    (check-equal? (prime? 14) #f)
    (check-equal? (prime? 15) #f)
    (check-equal? (prime? 16) #f)
    (check-equal? (prime? 21) #f)
    (check-equal? (prime? 31) #t)

    (check-equal? (range 1 4 1 '()) '(1 2 3 4))
    (check-equal? (range 1 1 1 '()) '(1))
    (check-equal? (range 1 -1 1 '()) '())
    (check-equal? (range 1 9 2 '()) '(1 3 5 7 9))
    (check-equal? (range 1 10 2 '()) '(2 4 6 8 10))

    (check-equal? (take 3 '(1 2 3 4 5 6 7 8 9)) '(1 2 3))
    (check-equal? (take 3 '()) '())
    (check-equal? (take 3 '(1)) '(1))
    (check-equal? (take 3 '(1 2 3)) '(1 2 3))

    (check-equal? (take 3 (search-for-primes 1000 1111))
                  '(1009 1013 1019))
    (check-equal? (take 3 (search-for-primes 10000 10111))
                  '(10007 10009 10037))
    (check-equal? (take 3 (search-for-primes 100000 100111))
                  '(100003 100019 100043))
    (check-equal? (take 3 (search-for-primes 1000000 1000111))
                  '(1000003 1000033 1000037))
))

(run-tests sicp-01.23-tests)
