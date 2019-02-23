#lang racket

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
      (+ (sqr a a) (sum-sq (+ a 1) b))))

(sum-sq 1 4)

(define (pi-sum a b)
  (if (> a b)
      0
      (+ (/ 1 (* a (+ a 2)))
         (pi-sum (+ 4 a) b))))

(pi-sum 1 4)



(define (add term a next b)
  (if (> a b)
      0
      (+ (term a)
         (add term
              (next a)
              next
              b))))

(add (lambda (x) (* x x)) 1 (lambda (x) (+ 1 x)) 4)

(define (sum-int a b)
  (define (identity x) x)
  (add identity a (lambda (x) (+ 1 x)) b))

(sum-int 1 4)

(define (identity x) x)
(define (sqr x) (* x x))
(define (inc x) (+ 1 x))

(define (sum-sq a b)
  (add sqr a inc b))

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
    (sqrt (+ (sqr dx)
             (sqr dy)))))

(define (+vect v1 v2)
  (make-vector
   (+ (xcor v1) (xcor v2))
   (+ (ycor v1) (ycor v2))))

(define A (make-vector 1 3))
(define B (make-vector 5 5))
(define D (make-vector 1 4))

;; (+vect A B)

(define AB (make-seg A B))

;; (mid-point AB)

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


;; (car 1-to-4)
;; (car (cdr 1-to-4))
;; (car (cdr (cdr 1-to-4)))

;; (scale-list 1-to-4)

(define (scale-list scaler xs)
  (if (null? xs)
      null
      (cons (* scaler (car xs))
            (scale-list scaler (cdr xs)))))

;; (scale-list 10 '(1 2 3 4))

;; 3B.1
(define (derive f)
  (lambda (x)
    (/ (- (f (+ x dx))
          (f x))
       dx)))

(define dx 0.00001)

;; ((derive (lambda (x) (* x x))) 4)

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

;; (deriv foo 'x)

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

;; (dsimp '(dd (+ x y) x))

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

(+ 1 1 (+ 1 1 1))


(define (search f neg-point pos-point)
  (let ((midpoint (average neg-point pos-point)))
    (if (close-enough? neg-point pos-point)
        midpoint
        (let ((test-value (f midpoint)))
          (cond ((positive? test-value)
                 (search f neg-point midpoint))
                ((negative? test-value)
                 (search f midpoint pos-point))
                (else midpoint))))))

(define (average x y)
  (/ (+ x y) 2.0))

(define (close-enough? x y)
  (< (abs (- x y)) 0.0001))

(define (half-interval-method f a b)
  (let ((a-value (f a))
        (b-value (f b)))
    (cond ((and (negative? a-value)
                (positive? b-value))
           (search f a b))
          ((and (negative? b-value)
                (positive? a-value))
           (search f b a))
          (else (error "Values are not of opposite sign" a b)))))

;; (half-interval-method sin 2.0 4.0)

;;;;
;; Recursion on sequances and trees
;;;;
(define (my-fold fn acc lst)
  (define (iter lst i)
    (if (null? (cdr lst))
        (fn i (car lst))
        (iter (cdr lst) (fn i (car lst)))))
  (iter lst acc))

(define (my-fold fn acc lst)
  (p lst)
  (if (null? (cdr lst))
      (car lst)
      (fn acc (my-fold fn acc (cdr lst)))))
;; (my-fold (lambda (acc x) (+ acc x)) 0 y)

(define (list-ref lst n)
  (if (= n 0)
      (car lst)
      (list-ref (cdr lst) (- n 1))))

(define (list-ref lst n)
  (if (= n 0)
      (car lst)
      (list-ref (cdr lst) (- n 1))))
;; (list-ref y 3)

(define (lst-length lst)
  (if (empty? (cdr lst))
      0
      (+ 1 (lst-length (cdr lst)))))
;; (lst-length y)

(define (tree-length x)
  (cond ((null? x) 0)
        ((not (pair? x)) 1)
        (else (+ (tree-length (car x))
                 (tree-length (cdr x))))))
;; (tree-length (list (list 1 2) (list 3 4)))

(define (lst-length lst)
  (define (iter lst l)
    (if (null? (cdr lst))
        l
        (iter (cdr lst) (+ l 1))))
  (iter lst 0))
;; (lst-length y)

;;;;
;; Recursion patterns
;;;;
(define (add xs acc)
  (cond ((null? xs) acc)
        (else (add (cdr xs) (+ (car xs) acc)))))

(define (sum-tree xs)
  (cond ((null? xs) 0)
        ((not (pair? xs)) xs)
        (else (+ (sum-tree (car xs))
                 (sum-tree (cdr xs))))))

(define (count-tree xs)
  (cond ((null? xs) 0)
        ((not (pair? xs)) 1)
        (else (+ (count-tree (car xs))
                 (count-tree (cdr xs))))))

(define (apply-tree xs f)
  (cond ((null? xs) 0)
        ((not (pair? xs)) xs)
        (else (f (apply-tree (car xs))
                 (apply-tree (cdr xs))))))

;; (sum-tree '((1 2) (3 4 (5 6 (7 8 9)))))
;; (sum-tree '(1 2 3 4))
;; (count-tree '((1 2) (3 4 (5 6 (7 8 9)))))
;; (add '(1 2 3 4) 0)

;;;;
;; Tables
;;;;
;;
;; 2.3.3 - indexed records
;; 2.4.4 - 2d tables, stored and retrieved with 2 keys

;;;;
;; Mutable Tables
;;;;

;; 3.3.3 - representing mutable tables
;;
;; table -> []
;;
;;

(define (assoc key record)
  (cond ((null? records) false)
        ((equal? key (car (car records)))
         (car records))
        (else (assoc key (cdr records)))))

;;;;
;; Abstract data
;;;;
;; (make-form-real-imag (real-part z) (imag-part z))
;; (make-from-mag-ang (magnitude z) (angle z))

(define (add-complex z1 z2)
  (make-from-real-imag (+ (real-part z1) (real-part z2))
                       (+ (imag-part z1) (imag-part z2))))

(define (sub-comlex z1 z2)
  (make-from-real-imag (- (real-part z1) (real-part z2))
                       (- (imag-part z1) (imag-part z2))))

(define (mul-complex z1 z2)
  (make-from-mag-ang (* (magnitude z1) (magnitude z2))
                     (+ (angle z1) (angle z2))))

(define (div-complex z1 z2)
  (make-from-mag-ang (/ (magnitude z1) (magnitude z2))
                     (- (angle z1) (angle z2))))

;;;;
;; Ben's implementation - rectagular form
;;;;
(define (real-part z) (car z))
(define (imag-part z) (cdr z))
(define (magnitude z)
  (sqrt (+ (sqr (real-part z))
           (sqr (imag-part z)))))

(define (angle z)
  (atan (imag-part z) (real-part z)))

(define (make-from-real-imag x y)
  (cons x y))

(define (make-from-mag-ang r a)
  (cons (* r (cos a)) (* r (sin a))))

;;;;
;; Alice's implementation - polar form
;;;;
(define (magnitude z) (car z))
(define (angle z) (cdr z))
(define (real-part z)
  (* (magnitude z) (cos (angle z))))
(define (imag-part z)
  (* (magnitude z) (sin (angle z))))

(define (make-from-real-imag x y)
  (cons (sqrt (+ (sqr x) (sqr y)))
        (atan y x)))

(define (make-from-mag-ang r a)
  (cons r a))

;;;;
;; Type tags
;;;;
(define (attach-tag type-tag contents)
  (cons type-tag contents))

(define (type-tag datum)
  (if (pair? datum)
      (car datum)
      (error "Bad tagged datum: TYPE-TAG" datum)))

(define (contents datum)
  (if  (pair? datum)
       (cdr datum)
       (error "Bad tagged datum: CONTENTS" datum)))

(define (rectangular? z)
  (eq? (type-tag z) 'rectangular))

(define (polar? z)
  (eq? (type-tag z) 'polar))

;; revised representation Bob:
(define (make-from-real-imag-rectangular x y)
  (attach-tag 'rectangular (cons x y)))

(define (make-fron-mag-ang-polar r a)
  (attach-tag 'rectangular (cons (* r (cos a))
                                 (* r (sin a)))))

;; revised Alyssa representation:
(define (make-from-real-imag-polar x y)
  (attach-tag 'polar
              (cons (sqrt (+ (sqr x) (sqr y)))
                    (atan y x))))
(define (make-from-mag-ang-polar r a)
  (attach-tag 'polar (cons r a)))

;; generic selectors
(define (real-part z)
  (cond ((rectagular? z) (real-part-rectangular (contents z)))
        ((polar? z) (real-part-polar (contants z)))
        (else (error "Unknown type: REAL-PART" z))))

(define (imag-part z)
  (cond ((rectangular? z) (imag-part-rectangular (contents z)))
        ((polar? z) (real-part-polar (contents z)))
        (else (error "Unknown type: IMAG-PART"))))

(define (magnitude z)
  (cond ((rectangular? z) (magnitude-rectangular (contents z)))
        ((polar? z) (magnitude-polar (contents z)))
        (else (error "Unknown type: MAGNITUDE" z))))

(define (angle z)
  (cond ((rectangular? z) (angle-rectangular (contents z)))
        ((polar? z) (angle-polar (contents z)))
        (else (error "Unknown type: ANGLE" z))))

;; constructors for the generic system
(define (make-from-real-imag x y)
  (make-from-real-imag-rectangular x y))

(define (make-from-mag-ang r a)
  (make-from-mag-ang-polar r a))

;;;;
;; Data-directed programming
;;;;
(define (install-rectangular-package)
  ;; internal procedures
  (define (real-part z) (car z))
  (define (imag-part z) (cadr z))
  (define (make-from-real-imag x y) (cons x y))
  (define (magnitude z)
    (sqrt (+ (sqr (real-part z))
             (sqr (imag-part z)))))
  (define (angle z)
    (atan (imag-part z) (real-part z)))
  (define (make-from-mag-ang r a)
    (cons (* r (cos a)) (* r (sin a))))

  ;; interface to rest of the system
  (define (tag x) (attach-tag 'rectangular x))
  (put 'real-part '(rectangular) real-part)
  (put 'imag-part '(rectangular) imag-part)
  (put 'magnitude '(rectangular) magnitude)
  (put 'make-from-real-imag 'rectangular
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'rectangular
       (lambda (r a) (tag (make-from-mag-ang r a))))
  'done)

(define (apply-generic op . args)
  (let ((type-tags (map type-tags args)))
    (let ((proc (get op type-tags)))
      (if proc
          (apply proc (map contants args))
          (error "No method for these types: APPLY-GENERIC"
                 (list op type-tags))))))

;;;;
;; Systems with generic operations
;;;;
(define (add x y) (apply-generic 'add x y))
(define (sub x y) (apply-generic 'sub x y))
(define (sub x y) (apply-generic 'div x y))
(define (mul x y) (apply-generic 'mul x y))

(define (install-scheme-number-package)
  (define (tag x) (attach-tag 'scheme-number x))
  (put 'add '(scheme-number scheme-number)
       (lambda (x y) (tag (+ x y))))
  (put 'sub '(scheme-number scheme-number)
       (lambda (x y) (tag (- x y))))
  (put 'mul '(scheme-number scheme-number)
       (lambda (x y) (tag (* x y))))
  (put 'div '(scheme-number scheme-number)
       (lambda (x y) (tag (/ x y))))
  (put 'make 'scheme-number (lambda (x) (tag x)))
  'done)

;; constructor ordinary scheme number
(define (make-scheme-number n)
  ((get 'make 'scheme-number) n))

(define (install-rational-package)
  ;; internal procedures
  (define (numer x) (car x))
  (define (denom x) (cdr x))
  (define (make-rat n d)
  (let ((g (gcd n d)))
    (cons (/ n g) (/ d g))))
  (define (add-rat x y)
    (make-rat (+ (* (numer x) (denom y))
                 (* (numer y) (denom x)))
                 (* (denom x) (denom y))))
  (define (sub-rat x y)
    (make-rat (- (* (numer x) (denom y))
                 (* (numer y) (denom x)))
                 (* (denom x) (denom y))))
  (define (mul-rat x y)
    (make-rat (* (numer x) (numer y))
              (* (denom x) (denom y))))
  (define (div-rat x y)
    (make-rat (* (numer x) (denom y))
              (* (denom x) (numer y))))
  ;; interface to rest of the system
  (define (tag x) (attach-tag 'rational x))

  (put 'add '(rational rational)
    (lambda (x y) (tag (add-rat x y))))
  (put 'sub '(rational rational)
    (lambda (x y) (tag (sub-rat x y))))
  (put 'mul '(rational rational)
    (lambda (x y) (tag (mul-rat x y))))
  (put 'div '(rational rational)
    (lambda (x y) (tag (div-rat x y))))
  (put 'make 'rational
    (lambda (n d) (tag (make-rat n d))))
  'done)

;; constructor rational number
(define (make-rational n d)
  ((get 'make 'rational) n d))

(define (install-complex-package)
  ;; imported procedures from rectangular and polar packages
  (define (make-from-real-imag x y)
    ((get 'make-from-real-imag 'rectangular) x y))
  (define (make-from-mag-ang r a)
    ((get 'make-from-mag-ang 'polar) r a))

  ;; internal procedures
  (define (add-complex z1 z2)
    (make-from-real-imag (+ (real-part z1) (real-part z2))
                         (+ (imag-part z1) (imag-part z2))))
  (define (sub-complex z1 z2)
    (make-from-real-imag (- (real-part z1) (real-part z2))
                         (- (imag-part z1) (imag-part z2))))
  (define (mul-complex z1 z2)
    (make-from-mag-ang (* (magnitude z1) (magnitude z2))
                       (+ (angle z1) (angle z2))))
  (define (div-complex z1 z2)
    (make-from-mag-ang (/ (magnitude z1) (magnitude z2))
                       (- (angle z1) (angle z2))))

  ;; interface to rest of the system
  (define (tag z) (attach-tag 'complex z))
  (put 'add '(complex complex)
       (lambda (z1 z2) (tag (add-complex z1 z2))))
  (put 'sub '(complex complex)
       (lambda (z1 z2) (tag (sub-complex z1 z2))))
  (put 'mul '(complex complex)
       (lambda (z1 z2) (tag (mul-complex z1 z2))))
  (put 'div '(complex complex)
       (lambda (z1 z2) (tag (div-complex z1 z2))))
  (put 'make-from-real-imag 'complex
       (lambda (x y) (tag (make-from-real-imag x y))))
  (put 'make-from-mag-ang 'complex
       (lambda (r a) (tag (make-from-mag-ang r a))))
  ;; interface to recangualr and polar packages
  (put 'real-part '(complex) real-part)
  (put 'imag-part '(complex) imag-part)
  (put 'magnitude '(complex) magnitude)
  (put 'angle '(complex) angle)
  'done)

;; constructors for complex numbers
(define (make-complex-from-real-imag x y)
  ((get 'make-from-real-imag 'complex) x y))

(define (make-complex-from-mag-ang r a)
  ((get 'make-from-mag-ang 'complex) r a))



;;;;
;; Reversi/Othello
;;;;

(define all-directions '(-11 -10 -9 -1 1 9 10 11))
(define empty 0)
(define black 1)
(define white 2)
(define outer 3)

(define piece '(integer empty outer))

(define (name-of piece)
  (char ".@0?" piece))

(define (opponent player)
  (if (eq? player black)
      white
      black))

;;;;
;; Chapter 3
;;;;
(define bank-account 100)

(define (withdraw amount)
  (let ((balance (- bank-account amount)))
    (if (>= balance 0)
        (begin (set! bank-account balance)
               balance)
        "Insufficient funds.")))

(withdraw 25)
(withdraw 125)

(display bank-account)

(define (make-bank-account balance)
  (define (withdraw amount)
    (if (>= balance amount)
        (begin (set! balance (- balance amount)) balance)
        "Insuficient funds."))
  (define (deposit amount)
    (begin (set! balance (+ balance amount))
           balance))
  (define (dispatch method)
    (cond ((eq? method 'withdraw) withdraw)
          ((eq? method 'deposit) deposit)
          (else (error "Unknown request: MAKE-ACCOUNT" method))))
  dispatch)

(define ba1 (make-bank-account 100))

((ba1 'withdraw) 25)
((ba1 'deposit) 25)

((make-bank-account) 25)


;;;;
;; Queues
;;;;
(define make-counter
  (lambda (n)
    (lambda ()
     (set! n (+ n 1)) n)))

(define c1 (make-counter 0))
(display (c1))

(define (make-queue)
  (let ((front-ptr )
        (rear-ptr )))

  (define q (cons '() '()))
  (define (insert item)
    (if (eq? q null)
        (set! q (list item))
        (set! q (cons item q))))
  (define (delete)
    (let ((first-item (car q)))
      (begin (set! q (cdr q))
             first-item)))
  (define (prn) (display q))
  (define (dispatch m)
    (cond ((eq? m 'insert) insert)
          ((eq? m 'delete) delete)
          ((eq? m 'prn) (prn))
          (else (error "Unknown operation - QUEUE" m))))
  dispatch)

(require r5rs/init)

;; (define (queue)
(define (make-queue) (cons '() '()))
(define (front-ptr queue) (car queue))
(define (rear-ptr queue) (cdr queue))
(define (set-front-ptr! queue item) (set-car! queue item))
(define (set-rear-ptr! queue item) (set-cdr! queue item))

(define (empty-queue? queue) (null? (front-ptr queue)))
(define (front-queue queue)
  (if (empty-queue? queue)
      (error "FRONT called with an empty queue" queue)
      (car (front-ptr queue))))
(define (rear-queue queue)
  (if (empty-queue? queue)
      (error "REAR called pn empty queue" queue)
      (rear-ptr queue)))

(define (insert-queue queue item)
  (let ((new-pair (cons item '())))
    (cond ((empty-queue? queue)
            (begin(set-front-ptr! queue new-pair)
            (set-rear-ptr! queue new-pair)
            queue))
          (else
            (begin (set-cdr! (rear-ptr queue) new-pair)
            (set-rear-ptr! queue new-pair)
            queue)))))
(define (delete-queue queue)
  (cond ((empty-queue? queue)
          (error "DELETE clalled with an empty queue" queue))
        (else
          (set-front-ptr! queue (cdr (front-ptr queue)))
          queue)))
(define (print-queue queue)
  (cond ((empty-queue? queue)
          (display '()))
        (else
          (display (front-ptr queue)))))

(define q1 (make-queue))
(display q1)
(insert-queue q1 'a)
(insert-queue q1 'b)
(print-queue q1)
  ;; 'done)
(display q1)

;;;;
;; Memoization
;;;;
(define (fib1 n)
  (cond ((< n 2) 1)
        (else (+ (fib (- n 1)) (fib (- n 2))))))

(define (memoize f)
  (let ((memory (make-hash)))
    (lambda (x)
      (let ((previously-computed-result (hash-has-key? memory x)))
        (or previously-computed-result
            (let ((result (f x)))
              (hash-set! memory x result)
              result))))))

(define mem-fib (memoize fib))
(mem-fib 5)
;; 0 1 1 2 3 5 8

;;;;
;; Logic programming with racklog
;;;;
(require racklog)

;; %=:= %< %=/=

;; predicates introducing facts
(define %knows
  (%rel ()
        (('Joel 'TeX))
        (('Joel 'Racket))
        (('Midge 'Tex))
        (('Midge 'Prolog))
        (('Midge 'Joel))))

(%which () (%knows 'Midge 'Prolog))
(%which () (%knows 'Midge 'Joel))
(%which () (%knows 'Joel 'Midge))

;; predicates with rules
(define %computer-literate
  (%rel (person)
        ((person)
         (%knows person 'TeX)
         (%knows person  'Racket))
        ((person)
         (%knows person 'TeX)
         (%knows person 'Prolog))))

(%which () (%computer-literate 'Joel))
(%which () (%computer-literate 'Midge))

;; solving goals
(%which (what) (%knows 'Joel what))
(%more)

;; asserting extra clauses - set!
(%assert! %knows () (('Joel 'archery)))

(define %parent %empty-rel)
(%assert! %parent () (('Abe 'Midge)))

(%which () (%parent 'Joel))
(%which () (%parent 'Abe))

;; 6A .a
(foldl (lambda(x acc)
         (if(odd? x)
            (+ acc (sqr x))
            (+ acc 0))) 0 (list 1 2 7 13 12 14))

(+ (sqr 13) (sqr 7) (sqr 1))

(cons-stream x y)
(head s)
(tail s)
'the-empty-stream

(define (map-stream proc s)
  (if (empty-stream? s)
      the-empty-stream
      (cons-stream (proc (head s))
                   (map-stream proc (tail s)))))

(define (filter-stream pred s)
  (cond ((empty-stream? s) the-empty-stream)
        ((pred (head s)) (cons-stream (head s)
                                      (filter-stream pred (tail s))))
        (else (filter-stream pred (tail s)))))

(define (accumulate-stream combiner init-val s)
  (if (empty-stream? s)
      init-val
      (combiner (head s)
                (accumulate-stream combiner init-val (tail s)))))

(define (enumerate-tree tree)
  (if (leaf-node? tree)
      (cons-stream tree the-empty-stream)
      (append-streams (enumerate-tree (left-branch tree))
                      (enumerate-tree (right-branch tree)))))

(define (append-stream s1 s2)
  (if (empty-stream? s1)
      s2
      (cons-stream (head s1)
                   (append-stream (tail s1) s2))))

(define (enum-interval low high)
  (if (> low high)
      the-empty-stream
      (cons-stream low
                   (enum-interval (+ 1 low) high))))

(define (sum-odd-squares tree)
  (accumulate + 0 (map sqr
                       (filter-stream odd?
                                      (enumerate-tree tree)))))

(define (odd-fibs n)
  (accumulate cons '() (filter odd?
                               (map fib
                                    (enum-interval 1 n)))))

;; 6A .b
(define (flatten-stream st-of-st)
  (accumulate-stream append-stream the-empty-stream st-of-st))

;; flatmaps are like nested loops
(define (flatmap f s)
  (flatten (map f s)))

;; collect is sugar for many faltmaps
(define (collect ))

(flatmap )

(define (wkg->watts wkg rider)
  (* wkg rider))

(wkg->watts 2.5 77)


(struct node (value left right))
(define xs
  (node 49
       (node 46 null null)
       (node 79
             (node 64 null null)
             (node 83 null null))))

(node-value (node-right (node-right xs)))

(node-value (node 49 (node 46 41 null) 79))
(node-left (node-left (node 49 (node 46 41 null) 79)))
(node-right (node 49 (node 46 41 null) 79))

(node-value (node 49 46 79))
(node-left (node 49 46 79))
(node-right (node 49 46 79))
