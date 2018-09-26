;; ex 1.22
;; Most Lisp implementations include a primitive called runtime
;; that returns an integer that specifies the amount of time the
;; system has been running (measured, for example, in
;; microseconds). The following timed-prime-test procedure, when
;; called with an integer n, prints n and checks to see if n is
;; prime. If n is prime, the procedure prints three asterisks
;; followed by the amount of time used in performing the test.

;; Using this procedure, write a procedure search-for-primes that
;; checks the primality of consecutive odd integers in a specified
;; range. Use your procedure to find the three smallest primes
;; larger than 1000; larger than 10,000; larger than 100,000;
;; larger than 1,000,000. Note the time needed to test each prime.
;; Since the testing algorithm has order of growth of $\Theta(\sqrt n)$,
;; you should expect that testing for primes around 10,000 should
;; take about 10 times as long as testing for primes around 1000.
;; Do your timing data bear this out? How well do the data for
;; 100,000 and 1,000,000 support the n prediction? Is your result
;; compatible with the notion that programs on your machine run
;; in time proportional to the number of steps required for the
;; computation?

;; NOTE: the 'runtime' procedure is not defined in racket. While
;; there are some workarounds on the web, maybe it is cleaner to
;; just use C-c C-s to change implementation to mit
;; (e.i. mit-scheme)

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

(define (prime? n)
  (= n (smallest-divisor n)))

(define (smallest-divisor n)
  (find-divisor n 2))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))

(define (square x)
  (* x x))

(define (divides? a b)
  (= (remainder b a) 0))

;;;;
;; Solution
;;;;
(define (search-for-primes min max)
  (filter prime? (range min max 2 '())))

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

(take 3 (search-for-primes 1000 1111))
(take 3 (search-for-primes 10000 10111))
(take 3 (search-for-primes 100000 100111))
(take 3 (search-for-primes 1000000 1000111))

(timed-prime-test 1009)
(timed-prime-test 10007)
(timed-prime-test 100003)
(timed-prime-test 1000003)
