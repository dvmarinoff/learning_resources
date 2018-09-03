;; BONUS ex 0.01 Count Change
;; Count all ways to make change of 1.00 given:
;; 0.50, 0.25, 0.10, 0.05, 0.01

(define (count-change amount)
  (cc amount 5))

(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
        (else (+ (cc amount (- kinds-of-coins 1))
                 (cc (- amount (first-denomination kinds-of-coins))
                     kinds-of-coins)))))

(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))

(count-change 100)

;; BONUS ex closed form fibonacii
(define phi (/ (+ 1 (sqrt 5)) 2))

(define (fib-closed-form n)
  (round (/ (expt phi n) (sqrt 5))))

(define (fib-index n)
  (round (log (+ (* n (sqrt 5)) 0.5) phi)))

(fib-index (fib-closed-form 12))

(map fib-closed-form (range 1 11 1))

;; Pascal Triangle

;; BONUS ex Count Digits

;; recursive
(define (count-digits n)
  (if (< n 10)
      1
      (+ 1 (count-digits (/ n 10)))))

;; 1 + (log n / log 10)
(define (count-digits-log n)
  (+ 1 (floor (/ (log n 2) (log 10 2)))))

