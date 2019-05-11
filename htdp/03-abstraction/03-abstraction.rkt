(require 2htdp/univese)
(require 2htdp/image)

(require plot)

(require rackunit rackunit/text-ui)

;; Any List-of-Any -> Boolean
(check-true (contains 4 (list 1 2 3 4 5 6 7 8)))
(check-false (contains 4 (list 1 2 3 5 6 7 8)))
(define (contains a lst)
  (cond ((empty? lst) #f)
        (else (or (equal? a (first lst))
                  (contains a (rest lst))))))

;; List-of-Any -> Number
(check-equal? (count (list 1 2 3 4)) 4)
(check-equal? (count (list 1)) 1)
(check-equal? (count '()) 0)
(define (count lst)
  (cond ((empty? lst) 0)
        (else (+ 1 (count (rest lst))))))

;; List-of-Numbers -> Number
(check-equal? (sum (list 1 2 3 4)) 10)
(check-equal? (sum (list 1)) 1)
(check-equal? (sum '()) 0)
(define (sum lst)
  (cond ((empty? lst) 0)
        (else (+ (first lst)
                 (sum (rest lst))))))

;; List-of-Numbers -> Boolean
(check-true (sorted>? (list 1 2 3 4)))
(check-false (sorted>? (list 4 3 2 1)))
(define (sorted>? lst)
  (cond ((empty? (rest lst)) #t)
        (else (and (< (first lst) (first (rest lst)))
                   (sorted>? (rest lst))))))

;; Tree -> Number
(check-equal? (sum-tree (list 1 (list 2 3 (list 4) 5) 6 7 (list 8 9))) 45)

(define (sum-tree t)
  (cond ((empty? t) 0)
        ((cons? (first t)))
        (+ (sum-tree (first t))
           (sum-tree (rest t)))
        ((cons? t)
         (+ (first t)
            (sum-tree (rest t))))))

;; List-of-Numbers -> List-of-Numbers
(check-equal? (sort (list 4 2 3 1)) (list 1 2 3 4))
(check-equal? (sort (list 2 1)) (list 1 2))
(check-equal? (sort (list 1)) (list 1))
(check-equal? (sort '()) '())
(define (sort lon)
  (cond ((empty? lon) '())
        (else (insert (first lon)
                      (sort (rest lon))))))

;; Number Sorted-List-of-Numbers -> Sorted-List-of-Numbers
(check-equal? (insert 4 (list 1 2 3)) (list 1 2 3 4))
(check-equal? (insert 4 (list 1 2 8)) (list 1 2 4 8))
(check-equal? (insert 4 (list 1 2 4 8)) (list 1 2 4 4 8))
(check-equal? (insert 4 '()) (list 4))
(define (insert n slon)
  (cond ((empty? slon) (list n))
        (else (if (<= n (first slon))
                  (cons n slon)
                  (cons (first slon) (insert n (rest slon)))))))

;;;;
;; III Abstraction
;;;;

;;;;
;; 14.1 Similarities in Function
;;;;

;; functions that consume the same kind of data look alike

;;;;
;; 14.2 Different Similarities
;;;;

;; functions that consume functions
;; single-point of control

;;;;
;; 14.3 Simiilarities in Data Defininition
;;;;

;; We can abstract data definitions with params to get:
;; Parametric Data Definitions
;;
;; they are a lot like functions
;; The param stands for an entire class of values.
;; The process of suppling the name of a data collection to a
;; parametric data definition is called instantiation.

;; A [List-of ITEM] is one of:
;; - '()
;; - (cons ITEM [List-of ITEM])

;; A [Maybe X] is one of:
;; - #f
;; - X

;;;;
;; 14.4 Functions are Values
;;;;

;;;;
;; 15 Designing Abstractions
;;;;

(foldl + 0 (list 1 2 3 4 5 6 7 8))
(foldl + 0 (list 8 5 3 2))
(foldl + 0 (list 7 6 4 1))

(define ())
