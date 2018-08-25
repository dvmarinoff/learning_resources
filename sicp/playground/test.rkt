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

;; 3B.1
(define (derive f)
  (lambda (x)
    (/ (- (f (+ x dx))
          (f x))
       dx)))

(define dx 0.00001)

((derive (lambda (x) (* x x))) 4)

(define (deriv exp var)
  (cond ((constant? exp var) 0)
        ((same-var? exp var) 1)
        ((sum? exp)
         (make-sum (deriv (a1 exp) var)
                   (deriv (a2 exp) var)))
        ((product? exp)
         (make-sum
          (make-product (m1 exp)
                        (deriv (m2 exp) var))
          (make-product (m2 exp)
                        (deriv (m1 exp) var))))))

(define (constant? exp var)
  (and (atom? exp)
       (not (eq? exp var))))

(define (same-var? exp var)
  (and (atom? exp)
       (eq? exp var)))

(define (sum? exp)
  (and (not (atom? exp))
       (eq? (car exp) '+)))

(define (make-sum a1 a2)
  (list '+ a1 a2))

(define a1 cadr)
(define a2 caddr)

(define (product? exp)
  (and (not (atom? exp))
       (eq? (car exp) '*)))

(define (make-product m1 m2)
  (list '* m1 m2))

(define m1 cadr)
(define m2 caddr)

(define bar '(+ (* 2 x) x))

(define foo '(+ (* 2 x) x))

(define (atom? x)
  (and (not (null? x))
       (not (pair? x))))

(deriv foo 'x)

;; 3B.2
(define (make-sum a1 a2)
  (cond ((and (number? a1)
              (number? a2))
         (+ a1 a2))
        ((and (number? a1) (= a1 0)) a2)
        ((and (number? a2) (= a2 0)) a1)
        (else (list '+ a1 a2))))

(define (make-product m1 m2)
  (cond ((and (number? m1)
              (number? m2))
         (* m1 m2))
        ((and (number? m1) (= m1 1)) m2)
        ((and (number? m2) (= m2 1)) m1)
        ((and (number? m1) (= m1 0)) 0)
        ((and (number? m2) (= m2 0)) 0)
        (else (list '* m1 m2))))

;; 4A.1
(define dsimp (simplifier deriv-rules))

(dsimp '(dd (+ x y) x))

(define deriv-rules
  '(
    ( (dd (?c c) (? v))     0)
    ( (dd (?v v) (? v))     1)
    ( (dd (?v u) (? v))     0)

    ( (dd (* (? x1) (? x2)) (? v))
      (+ (dd (: x1) (: v))
         (dd (: x2) (: v)))  )
    ;; ...
    ))

(define algebra-rules
  '(
    ( ((? op) (?c e1) (?c e2))
      (: (op e1 e2)))

    ( ((? op) (? e1) (?c e2))
       ((: op) (: e2) (: e1)))

    ( (+ 0 (? e)) (: e))

    ( (* 1 (? e)) (: e))

    ( (* 0 (? e)) 0)))
