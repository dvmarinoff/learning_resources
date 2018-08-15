;; ex 1.11
;; A function f is defined by the rule that

;; f(n) = n                                  if n <3
;; f(n) = f(n - 1) + 2f(n - 2) + 3f(n - 3)   if n > 3.

;; Write a procedure that computes f by means of a recursive
;; process. Write a procedure that computes f by means of an
;; iterative process.

(define (fib-recur n)
  (if (< n 3)
      n
      (+ (fib-recur (- n 1))
         (* 2 (fib-recur (- n 2)))
         (* 3 (fib-recur (- n 3))))))

(define (fib-iter n)
  (iter 2 1 0 n))

(define (iter a b c n)
  (if (= n 0)
      c
      (iter (+ a (* 2 b) (* 3 c)) a b (- n 1))))

;; f(n) = f(n - 1) + 2f(n - 2) + 3f(n - 3)
;; 0 1 2 4 11 25
;; a_{1} = 0
;; a_{2} = 1
;; a_{3} = 2
;; a_{4} = a_{3} + 2 * a_{2} + 3 * a_{1} = 2+(2*1)+(3*0) = 4
;; a_{5} = a_{4} + 2 * a_{3} + 3 * a_{2} = 4+(2*2)+(3*1) = 11
;;
;; a = a_{i}, b = a_{i-1}, c = a_{i-2}
;; a_{i} = a+2b+3c
;; a_{4} -> a=2, b=1, c=0
;; a_{5} -> a=4, b=2, c=1

;; fib(n) = fib(n - 1) + fib(n - 2)
;; 0 1 1 2 3 5 8 13
;; a_{4} = a_{3} + a_{2}
;; a_{5} = a_{4} + a_{3}
;;
;; a_{i} = a_{i-1} + a_{i-2}
;; a = a_{i-1}, b = a_{i-2}
;; a_{i} = a + b
