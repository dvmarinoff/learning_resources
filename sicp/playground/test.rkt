(define (add x y)
  (+ x y))

(define (sum-int a b)
  (if (> a b)
      0
      (+ a (sum-int (+ a 1) b))))

(sum-int 1 10)

(define (sum-sq a b)
  (if (> a b)
      0
      (+ (square a a) (sum-sq (+ a 1) b))))

(sum-sq 1 4)

(define (pi-sum a b)
  (if (> a b)
      0
      (+ (/ 1 (* a (+ a 2)))
         (pi-sum (+ 4 a) b))))

(pi-sum 1 4)



(define (sum term a next b)
  (if (> a b)
      0
      (+ (term a)
         (sum term
              (next a)
              next
              b))))

(sum (lambda (x) (* x x)) 1 (lambda (x) (+ 1 x)) 4)

(define (sum-int a b)
  (define (identity x) x)
  (sum identity a (lambda (x) (+ 1 x)) b))

(sum-int 1 4)

(define (identity x) x)
(define (square x) (* x x))
(define (inc x) (+ 1 x))

(define (sum-sq a b)
  (sum square a inc b))

(sum-sq 1 4)
