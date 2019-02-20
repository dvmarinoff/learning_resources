#lang racket
;; ex 02.16
;; interval arithmetic devise a better package
;;
;; Explain, in general, why equivalent algebraic expressions may
;; lead to different answers. Can you devise an
;; interval-arithmetic package that does not have this
;; shortcoming, or is this task impossible? (Warning: This
;; problem is very difficult.)

;; To minimize error we need to avoid operations producing error.
;; Maybe if our system can simplify expressions. But expressions like
;; (a + b)/(a + c), will always give the wrong answer. This approach
;; won't work. The problem is the interval arithmethic itself.
;;
;; Since the identity operation in interval arithmetic produces an error
;; we won't get right answers from it. Instead we need to divise one that
;; holds and build from there. Fields and Group theory, Monte Carlo,
;; optimization ... I'll expore it at later times since it is going
;; way out of the scope of this book.
