;; ex 1.3
;; Define a procedure that takes three numbers as arguments and
;; returns the sum of the squares of the two larger numbers

(define (square x) (* x x))

(define (do-sum f)
           (lambda (x y) (+ (f x) (f y))))

(define (do-largest fn)
  (lambda (x y z)
    (if (> x y)
         (if (> y z)
             (fn x y)
             (fn x z))
         (if (> x z)
             (fn y x)
             (fn y z)))))

(define sum-of-squares (do-sum square))

(define largest-sum-of-squares (do-largest sum-of-squares))
