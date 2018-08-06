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

(define (average x y)
  (/ (+ x y) 2))

;; points in a plane
(define (make-vector x y)
  (cons x y))

(define (xcor p) (car p))

(define (ycor p) (cdr p))

;; line segments
(define (make-seg p q)
  (cons p q))

(define (seg-start s) (car s))

(define (seg-end s) (cdr s))

(define (mid-point s)
  (let ((a (seg-start s))
        (b (seg-end s)))
    (make-vector
      (average (xcor a) (xcor b))
      (average (ycor a) (ycor b)))))

(define (seg-length s)
  (let
      ((dx (- (xcor (seg-end s))
              (xcor (seg-start s))))
       (dy (- (ycor (seg-end s))
              (ycor (seg-start s)))))
    (sqrt (+ (square dx)
             (square dy)))))

(define (+vect v1 v2)
  (make-vector
   (+ (xcor v1) (xcor v2))
   (+ (ycor v1) (ycor v2))))

(define A (make-vector 1 3))
(define B (make-vector 5 5))
(define D (make-vector 1 4))

(+vect A B)

(define AB (make-seg A B))

(mid-point AB)

;; (define (cons a b)
;;   (lambda (pick)
;;     (cond ((= pick 1) a)
;;           ((= pick 2) b))))

;; (define (car x) (x 1))

;; (define (cdr x) (x 2))

;; (define p (cons 1 3))
;; (car p)
;; (cdr p)
(define 1-to-4 (list 1 2 3 4))


(car 1-to-4)
(car (cdr 1-to-4))
(car (cdr (cdr 1-to-4)))

(scale-list 1-to-4)

(define (scale-list scaler xs)
  (if (null? xs)
      null
      (cons (* scaler (car xs))
            (scale-list scaler (cdr xs)))))

(scale-list 10 '(1 2 3 4))
