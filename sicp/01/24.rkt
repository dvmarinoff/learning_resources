#lang racket
;; ex 01.24
;; modify timed-prime-test to use fermat test
;;
;; Modify the timed-prime-test procedure of exercise 1.22 to use
;; fast-prime? (the Fermat method), and test each of the 12 primes
;; you found in that exercise. Since the Fermat test has Theta(log n)
;; growth, how would you expect the time to test primes near 1,000,000
;; to compare with the time needed to test primes near 1000? Do your
;; data bear this out? Can you explain any discrepancy you find?

;;;;
;; Sicp code
;;;;
(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (prime? n)
      (report-prime (- (runtime) start-time))))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (square x)
  (sqr x))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder (square (expmod base (/ exp 2) m))
                    m))
        (else
         (remainder (* base (expmod base (- exp 1) m))
                    m))))

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (fast-prime? n times)
  (cond ((= times 0) true)
        ((fermat-test n) (fast-prime? n (- times 1)))
        (else false)))

;;;;
;; Solution
;;;;
(define (prime? n)
  (fast-prime? n (floor (sqrt n))))

(timed-prime-test 1009)
(timed-prime-test 10007)
(timed-prime-test 100003)
(timed-prime-test 1000003)

;; TODO: getting an error with mit-scheme:
;; -> ;Unbound variable: current-inexact-milliseconds
;; Again a problem with the (runtime) procedure

;; Otherwise a get time 0 for all tests. I don't know if this is
;; because of my code, mit-scheme or just my hardware.
