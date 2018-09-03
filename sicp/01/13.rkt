;; ex 1.13
;; Prove that Fib(n) is the closest integer to:
;; frac{\phi^{n}}{\sqrt{5}}, where
;; \phi = \frac{1 + \sqrt{5}}{2}

;; Hint: Let \psi = \frac{1 - \sqrt{5}}{2}
;; Use induction and the def. of fibonacii numbers to prove:
;; Fib(n) = \frac{\phi^{n} - \psi^{n}}{\sqrt{5}}

;; Pf.: by Induction
;;
;; Basis Step: P(0)


(define phi (/ (+ 1 (sqrt 5)) 2))

(define psi (/ (- 1 (sqrt 5)) 2))

(define (fib n)
  (cond ((= 0 n) 0)
        ((= 1 n) 1)
        (else (+ (fib (- n 2))
                 (fib (- n 1))))))

(define (fib-approximation n)
  (/ (expt phi n) (sqrt 5)))

(define (fib-with-rounding n)
  (round (fib-approximation n)))

(define (fib-conjecture n)
  (/ (- (expt (/ (+ 1 (sqrt 5) 2)) n)
        (expt (/ (- 1 (sqrt 5) 2)) n))
     (sqrt 5)))

(map fib-approximation (range 10))
(map fib-with-rounding (range 10))
(map fib-conjecture (range 10))
(map fib (range 10))

(map (lambda (n) (- (fib-err n) (fib-conjecture n))) (range 10))

(define (fib-err n)
  (- (fib n) (fib-approximation n)))
