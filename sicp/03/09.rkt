#lang racket

(require racket/trace)

;; ex 03.09
;; environment structures - evaluating recursion and iteration
;;
;; In section 1.2.1 we used the substitution model to analyze two
;; procedures for computing factorials, a recursive version

(define (factorial n)
  (if (= n 1)
      1
      (* n (factorial (- n 1)))))

;; and an iterative version

(define (factorial n)
  (fact-iter 1 1 n))

(define (fact-iter product counter max-count)
  (if (> counter max-count)
      product
      (fact-iter (* counter product)
                 (+ counter 1)
                 max-count)))

;; Show the environment structures created by evaluating
;; (factorial 6) using each version of the factorial procedure.

;;;;
;; recursive factorial
;;;;

;; (trace factorial)
(factorial 4)
;; >(factorial 4)
;; > (factorial 3)
;; > >(factorial 2)
;; > > (factorial 1)
;; < < 1
;; < <2
;; < 6
;; <24
;;
;; the frames
;; [n: 4] [n: 3] [n: 2] [n: 1]

;;;;
;; iterative factorial
;;;;

;; the frames:
;; [factorial-iter: fact-iter:]
;;
;; [n: 4]
;;
;; [product: 1 counter: 1 max-count: 4]
;; [product: 1 counter: 2 max-count: 4]
;; [product: 2 counter: 3 max-count: 4]
;; [product: 6 counter: 4 max-count: 4]
;; [product: 24 counter: 5 max-count: 4]
