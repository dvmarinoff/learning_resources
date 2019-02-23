#lang racket

(require 2htdp/universe)
(require 2htdp/image)
(require 2htdp/batch-io)
(require 2htdp/itunes)
(require rackunit rackunit/text-ui)

;;;;
;; Part II: Arbitrary Large Data
;;;;

;;;;
;; 9 Designing with Self-Referential Data Definitions
;;;;

;;;;
;; 9.1 Finger Exercises: Lists
;;;;

;; List-of-names
;; - '()
;; - (cons String List-of-names)

;; List-of-names -> Boolean
;; determines whether "Flatt" is names
(define (contains-flatt? names)
  (cond ((empty? names) #f)
        ((cons? names)
         (or (string=? (first names) "Flatt")
             (contains-flatt? (rest names))))
        (else (error "contains-flatt?: takes List-of-names"))))


;; String List -> Boolean
;; determines if the String str is in the List of strings lst
(define (contains? str lst)
  (cond ((empty? lst) #f)
        ((cons? lst)
         (or (string=? str (first lst))
             (contains? str (rest lst))))
        (else (error "contains: expects a list"))))

;; A List is one of:
;; - '()
;; - (cons Any List)
;;
;; '()
;; (cons 1 '())
;; (cons 3 (cons 2 (cons 1 '())))

;; List -> Number
;; counts the number of items in the list
(define (count lst)
  (cond ((empty? lst) 0)
        ((cons? lst)
         (+ 1
            (count (rest lst))))
        (else (error "count: expects a list"))))

;; List-of-numbers is one of:
;; - '()
;; - (cons Number List-of-numbers)
;;
;; '()
;; (cons 1 '())
;; (cons 5 (cons 3 (cons 1 '())))

;; List-of-numbers -> Number
;; sums the values of a list of numbers
(define (sum lon)
  (cond ((empty? lon) 0)
        ((cons? lon)
         (+ (first lon)
            (sum (rest lon))))))


;; List-of-numbers:
;; '()
;; (cons 1 '())
;; (cons -1 '())
;; (cons 3 (cons 2 (cons 1 '())))
;; (cons 3 (cons 2 (cons -1 '())))

;; List-of-numbers -> Boolean
;; determines if all numbers in a list of numbers are positive
(define (pos-list? lon)
  (cond ((empty? lon) #t)
        ((cons? lon)
         (and (< 0 (first lon))
              (pos-list? (rest lon))))))

;; List-of-booleans is one of:
;; - '()
;; - (cons Boolean List-of-booleans)
;;
;; '()
;; (cons #t '())
;; (cons #f '())
;; (cons #t (cons #t (cons #t (cons #t '()))))
;; (cons #t (cons #f (cons #t (cons #t '()))))

;; List-of-numbers -> Number
;; sums the values in a list of numbers

(define (all-true lob)
  (cond ((empty? lob) #t)
        ((cons? lob)
         (and (first lob)
              (all-true (rest lob))))))

(define (some-true lob)
  (cond ((empty? lob) #f)
        ((cons? lob)
         (or (first lob)
             (some-true (rest lob))))))

;;;;
;; 9.2 Non-empty Lists
;;;;

;; NEList-of-temperatures is one of:
;; - (cons Temperature '())
;; - (cons Temperature NEList-of-temperatures)
;;
;; (cons 20 '())
;; (cons 40 (cons 30 (cons 20 '())))
;; (cons 40 (cons 10 (cons 30 '())))

;; NEList-of-temperatures -> Boolean
;; are the temperatures sorted in descending order
(define (sorted>? nel)
  (cond ((empty? (rest nel)) #t)
        (else (and (> (first nel) (first (rest nel)))
                   (sorted>? (rest nel)) ))))


;; NEList-of-temperatures -> Number
(cons 1 '())
(cons 2 (cons 1 '()))
(cons 3 (cons 2 (cons 1 '())))
(cons 4 (cons 3 (cons 2 (cons 1 '()))))

(check-equal? (sum-ne (cons 1 '())) 1)
(check-equal? (sum-ne (cons 2 (cons 1 '()))) 3)
(check-equal? (sum-ne (cons 3 (cons 2 (cons 1 '())))) 6)
(check-equal? (sum-ne (cons 4 (cons 3 (cons 2 (cons 1 '()))))) 10)

(define (sum-ne nel)
  (cond ((empty? (rest nel)) (first nel))
        (else (+ (first nel)
                 (sum-ne (rest nel))))))

;; NEList-of-temperatures -> Number
(check-equal? (how-many-ne (cons 1 '())) 1)
(check-equal? (how-many-ne (cons 2 (cons 1 '()))) 2)
(check-equal? (how-many-ne (cons 3 (cons 2 (cons 1 '())))) 3)
(check-equal? (how-many-ne (cons 4 (cons 3 (cons 2 (cons 1 '()))))) 4)
(define (how-many-ne nel)
  (cond ((empty? (rest nel)) 1)
        (else (+ 1
                 (how-many-ne (rest nel))))))

;; NEList-of-booleans is one of:
;; - (cons Boolean '())
;; - (cons Boolean NEList-of-booleans)

(cons #t '())
(cons #t (cons #t '()))
(cons #t (cons #t (cons #t '())))
(cons #f (cons #t (cons #t '())))
(cons #f (cons #f (cons #f '())))

;; NEList-of-temperatures -> Boolean
(check-true (all-true-ne (cons #t '())))
(check-false (some-true-ne (cons #f '())))
(check-true (all-true-ne (cons #t (cons #t '()))))
(check-true (all-true-ne (cons #t (cons #t (cons #t '())))))
(check-false (all-true-ne (cons #f (cons #t (cons #t '())))))
(check-false (all-true-ne (cons #f (cons #f (cons #f '())))))
(define (all-true-ne nel)
  (cond ((empty? (rest nel)) (first nel))
        (else (and (first nel)
                   (all-true-ne (rest nel))))))

;; NEList-of-temperatures -> Boolean
(check-true (some-true-ne (cons #t '())))
(check-false (some-true-ne (cons #f '())))
(check-true (some-true-ne (cons #t (cons #t '()))))
(check-true (some-true-ne (cons #t (cons #t (cons #t '())))))
(check-true (some-true-ne (cons #f (cons #t (cons #t '())))))
(check-false (some-true-ne (cons #f (cons #f (cons #f '())))))

(define (some-true-ne nel)
  (cond ((empty? (rest nel)) (first nel))
        (else (or (first nel)
                  (some-true-ne (rest nel))))))

;;;;
;; 9.3 Natural Numbers
;;;;

;; An N is one of:
;; - 0
;; - (add1 N)
;; interpretation represents the counting numbers

;; List-of-strings is one of:
;; - '()
;; - (cons String List-of-strings)

;; N String -> List-of-strings
(check-equal? (copier 3 "a") (cons "a" (cons "a" (cons "a" '()))))
(check-equal? (copier 2 "a") (cons "a" (cons "a" '())))
(check-equal? (copier 1 "a") (cons "a" '()))
(check-equal? (copier 0 "a") '())

(define (copier n str)
  (cond ((zero? n) '())
        ((positive? n)
         (cons str
               (copier (sub1 n) str)))))

;; N -> N
;; adds the natural number N to pi
;; (without the primitive operation +)
(check-equal? (add-to-pi 0) pi)
(check-equal? (add-to-pi 1) (+ 1 pi))
(check-equal? (add-to-pi 2) (+ 2 pi))
(check-equal? (add-to-pi 10) (+ 10 pi))

(define (add-to-pi n)
  (cond ((zero? n) pi)
        ((positive? n)
         (add1 (add-to-pi (sub1 n))))))

;; N N -> N
;; multiply n by x
;; (without the primitive operation *)
(check-equal? (multiply 0 0) (* 0 0))
(check-equal? (multiply 0 4) (* 0 4))
(check-equal? (multiply 4 0) (* 4 0))
(check-equal? (multiply 1 4) (* 1 4))
(check-equal? (multiply 2 4) (* 2 4))
(check-equal? (multiply 10 4) (* 10 4))
(check-equal? (multiply 4 10) (* 4 10))

(define (multiply n x)
  (cond ((zero? n) n)
        ((positive? n)
         (+ x (multiply (sub1 n) x)))))

(define box (square 10 "outline" "black"))

;; N -> Boolean
(define (one? n) (= n 1))

;; Row is one of:
;; - box
;; - (beside box Row)
;;
;; box
;; (beside box box)
;; (beside box (beside box (beside box box)))

;; Non-zero-N Image -> Image
;; produces a row of n copies of img
(check-equal? (row 1 box) box)
(check-equal? (row 2 box) (beside box box))
(check-equal? (row 4 box) (beside box (beside box (beside box box))))

(define (row n img)
  (cond ((one? n) img)
        ((positive? n)
         (beside img (row (sub1 n) img)))
        (else (error "row: expects a non-zero natural number"))))

;; Non-zero-N Image -> Image
;; produces a column of n copies of img
(check-equal? (col 1 box) box)
(check-equal? (col 2 box) (above box box))
(check-equal? (col 4 box) (above box (above box (above box box))))
(define (col n img)
  (cond ((one? n) img)
        ((positive? n)
         (above img (col (sub1 n) img)))
        (else (error "col: expects a non-zero natural number"))))


(define hall (overlay/xy (row 10 (col 18 box)) 0 0 (empty-scene 100 180)))
(define balloon (circle 5 "solid" "red"))

(struct pos (x y))

;; List-of-pos is one of:
;; - '()
;; - (cons pos List-of-pos)
;;
;; '()
;; (cons (pos 10 10) '())
;; (cons (pos 30 30) (cons (pos 20 20) (cons (pos 10 10) '())))

;; A Hall is one of:
;; - hall
;; - (overlay/xy ballon x y hall)
;;
;; hall
;; (overlay/xy balloon (pos-x (pos -5 -5)) (pos-y (pos -5 -5)) hall)
;; (overlay/xy balloon (pos-x (pos -15 -15)) (pos-y (pos -15 -15))
;;             (overlay/xy balloon (pos-x (pos -5 -5)) (pos-y (pos -5 -5)) hall))

;; List-of-pos -> Hall
(add-balloons '())
(add-balloons (cons (pos -5 -5) '()))
(add-balloons (cons (pos -15 -15) (cons (pos -25 -25) (cons (pos -35 -35) '()))))

(define (add-balloons positions)
  (cond ((empty? positions) hall)
        ((cons? positions)
         (overlay/xy balloon
                     (pos-x (first positions))
                     (pos-y (first positions))
                     (add-balloons (rest positions))))))

;;;;
;; 9.4 Russian Dolls
;;;;

;; Once again, we see that the template is an organization
;; schema for everything we know about the data definition,
;; but we may not need these pieces for the actual definition

;;;;
;; 9.5 Lists and World
;;;;

;; constants
(define height 100)
(define width 320)
(define xshots (/ width 2))

;; graphical constants
(define background (empty-scene width height))
(define shot (triangle 3 "solid" "red"))

;; ShotWorld -> ShotWorld
(define (main w0)
  (big-bang w0
            (on-tick tock)
            (on-key keyh)
            (to-draw to-image)))

(main '())

;; A List-of-shots is one of:
;; - '()
;; - (cons Shot List-of-shots)
;; interpretation the collection of shots fired

;; A Shot is a Number.
;; interpretation represents the shot's y-coordinate

;; A ShotWorld is List-of-numbers.
;; interpretation each number on such a list
;;   represents the y-coordinate of a shot

;; ShotWorld -> Image
;; adds the image of a shot for each y on w
;; at {MID, y} to the background image
(check-equal? (to-image (cons 9 '()))
              (place-image shot xshots 9 background))
(check-equal? (to-image (cons 18 (cons 9 '())))
              (place-image shot xshots 18
                           (place-image shot xshots 9 background)))
(define (to-image w)
  (cond ((empty? w) background)
        ((cons? w)
         (place-image shot xshots (first w) (to-image (rest w))))))

;; ShotWorld -> ShotWorld
;; moves each shot of w up by one pixel
(check-equal? (tock (cons 19 '())) (cons 18 '()))
(check-equal? (tock (cons 31 (cons 19 '())))
              (cons 30 (cons 18 '())))
(check-equal? (tock '(30 10 1 0 -1)) '(29 9 0))
(check-equal? (tock '(0)) '())
(check-equal? (tock '()) '())
(define (tock w)
  (cond ((empty? w) '())
        ((cons? w)
         (filter-off-top (sub1 (first w))
                         (tock (rest w))))))

;; Shot List-of-shots -> List-of-shots
;; add to the list of shots only if
;; the shot is still visible
(define (filter-off-top shot shot-lst)
  (if (off-top? shot) shot-lst (cons shot shot-lst)))

;; WorldObject -> Boolean
;; is this object out of the top
(define (off-top? x) (< x 0))

;; ShotWorld KeyEvent -> ShotWorld
;; adds a shot to the world
;; if the player presses the space bar
(check-equal? (keyh '() " ") (cons height '()))
(check-equal? (keyh '()  "right") '())
(define (keyh w ke)
  (cond ((key=? " " ke) (cons height w))
        (else w)))

;;;;
;; 9.6 A Note on Lists and Sets
;;;;

;; a data definition produces a name for a set of BSL values.
;; we frequently need to ask whether some element is in some given set
;; Sets and list live at different levels in our conversations:
;; - a Set is a concept (to discuss steps in the design of code)
;; - a List is a form of data

;; List-of-strings:
;; '()
;; (cons "a" '())
;; (cons "a" (cons "a" (cons "b" (cons "a" '()))))

;; List-of-string String -> N
;; determines how often s occurs in los
(check-equal? (count '() "a") 0)
(check-equal? (count (cons "a" '()) "a") 1)
(check-equal? (count (cons "a" (cons "a" (cons "b" (cons "a" '())))) "a") 3)
(define (count los s)
  (cond ((empty? los) 0)
        ((cons? los)
         (+ (if (string=? (first los) s) 1 0)
            (count (rest los) s)))))

;;;;
;; 10. More on Lists
;;;;

;;;;
;; 10.1 Functions that Produce Lists
;;;;

;; Number -> Number
;; computes the wage for h hours of work
(define (wage h) (* 12 h))

;; List-of-numbers -> List-of-numbers
;; computes the weekly wages for the weekly hours
(check-equal? (wage* '(28)) '(336))
(check-equal? (wage* '(4 2)) '(48 24))
(check-equal? (wage* '()) '())
(define (wage* whrs)
  (cond ((empty? whrs) '())
        ((cons? whrs)
         (cons (wage (first whrs))
               (wage* (rest whrs))))))

;; String String List-of-strings -> List-of-strings
(check-equal? (substitude "a" "b" '("a" "b" "b")) '("a" "a" "a"))
(check-equal? (substitude "a" "b" '("b")) '("a"))
(check-equal? (substitude "a" "b" '()) '())

(define (substitude new-s old-s los)
  (cond ((empty? los) '())
        ((cons? los)
         (cons (if (string=? old-s (first los)) new-s (first los))
               (substitude new-s old-s (rest los))))))

;; substitude v2:
;; using a predicate to enchance readability and ease testing
(define (substitude.v2 new-s old-s los)
  (cond ((empty? los) '())
        ((cons? los)
         (cons (substitude? new-s old-s (first los))
               (substitude.v2 new-s old-s (rest los))))))

;; String String String -> String
(define (substitude? new-s old-s s)
  (if (string=? old-s s) new-s s))

;;;;
;; 10.2 Structures in Lists
;;;;

(struct work (employee rate hours))
;; (work String Number Number)
;; interpretation it combines the name
;; with pay rate and work hours

;; List-of-work is one of:
;; - '()
;; - (cons Work List-of-work)
;;
;; '()
;; (cons (work "Robby" 10 40) '())
;; (cons (work "Mattew" 12 60) (cons (work "Robby" 10 40) '()))

;; List-of-work -> List-of-wages
(check-equal? (wage*.v2 '()) '())
(check-equal? (wage*.v2 (cons (work "Robby" 10 40) '())) '(400))
(check-equal? (wage*.v2 (cons (work "Mattew" 12 60)
                              (cons (work "Robby" 10 40) '())))
              (list (* 12 60) (* 10 40)))

(define (wage*.v2 low)
  (cond ((empty? low) '())
        ((cons? low)
         (cons (wage.v2 (first low))
               (wage*.v2 (rest low))))))

;; Work -> Number
(define (wage.v2 w)
  (* (work-rate w) (work-hours w)))

(struct paycheck (name amount))
;; (paycheck String Number)
;; combines employee name and pay amount

;; List-of-paychecks is one of:
;; - '()
;; - (cons Paycheck List-of-paychecks)
;;
;; '()
;; (cons (paycheck "Robby" 400) '())
;; (cons (paycheck "Matthew" 720) (cons (paycheck "Robby" 400) '()))

;; List-of-work -> List-of-paychecks
(check-equal? (wage*.v3 '()) '())
(check-equal? (paycheck-name (first (wage*.v3 (list (work "Matthew" 12 60)
                                                    (work "Robby" 10 40))))) "Matthew" )
(check-equal? (paycheck-amount (first (wage*.v3 (list (work "Matthew" 12 60)
                                                      (work "Robby" 10 40))))) 720)
(check-equal? (paycheck-name (first (wage*.v3 (list (work "Robby" 10 40))))) "Robby")
(check-equal? (paycheck-amount (first (wage*.v3 (list (work "Robby" 10 40))))) 400)

(define (wage*.v3 low)
  (cond ((empty? low) '())
        ((cons? low)
         (cons (paycheck (work-employee (first low))
                         (wage.v2 (first low)))
               (wage*.v3 (rest low))))))


(struct work.v4 (employee rate hours employee-number))
;; (work.v4 String Number Number String)

(struct paycheck.v4 (name amount employee-number))
;; (paycheck.v4 String Number Number String)

;; List-of-work -> List-of-paychecks
(check-equal? (wage*.v4 '()) '())
(check-equal? (paycheck.v4-name (first (wage*.v4 (list (work.v4 "Matthew" 12 60 "#1235a")
                                                    (work.v4 "Robby" 10 40 "#1234a"))))) "Matthew")
(check-equal? (paycheck.v4-amount (first (wage*.v4 (list (work.v4 "Matthew" 12 60 "#1235a")
                                                      (work.v4 "Robby" 10 40 "#1234a"))))) 720)
(check-equal? (paycheck.v4-employee-number (first (wage*.v4 (list (work.v4 "Matthew" 12 60 "#1235a")
                                                               (work.v4 "Robby" 10 40 "#1234a"))))) "#1235a")
(check-equal? (paycheck.v4-name (first (wage*.v4 (list (work.v4 "Robby" 10 40 "#1234a"))))) "Robby")
(check-equal? (paycheck.v4-amount (first (wage*.v4 (list (work.v4 "Robby" 10 40 "#1234a"))))) 400)
(check-equal? (paycheck.v4-employee-number (first (wage*.v4 (list (work.v4 "Robby" 10 40 "#1234a"))))) "#1234a")

(define (wage*.v4 low)
  (cond ((empty? low) '())
        ((cons? low)
         (cons (paycheck.v4 (work.v4-employee (first low))
                            (wage.v4 (first low))
                            (work.v4-employee-number (first low)))
               (wage*.v4 (rest low))))))

;; Work.v4 -> Number
(define (wage.v4 w)
  (* (work.v4-rate w) (work.v4-hours w)))

;;;;
;; 10.3 Lists in Lists, Files
;;;;

;; the racket core api:
(file->string "./ttt.txt")
(file->bytes "./ttt.txt")
(file->bytes-lines "./ttt.txt")
(file->value "./ttt.txt")
(file->lines "./ttt.txt")
(file->list "./ttt.txt")

;; the 2htdp/batch-io api:

;; String -> String
(read-file "./ttt.txt")
;; String -> List-of-string
(read-lines "./ttt.txt")
;; String -> List-of-string
(read-words "./ttt.txt")
;; String -> List-of-list-of-string
(read-words/line "./ttt.txt")

;; LS is one of:
;; - '()
;; - (cons String LS)

;; LLS is one of:
;; - '()
;; - (cons LS LLS)
;;
;; '()
;; (cons (list "a" "b") '())
;; (cons (list "a" "b") (list (list "c" "d") (list "e" "f")))

;; LLS -> List-of-numbers
;; determines the number of words on each line
(define line0 (cons "hello" (cons "world" '())))
(define line1 '())
(define lls0 '())
(define lls1 (cons line0 (cons line1 '())))
(check-equal? (words-on-line lls0) '())
(check-equal? (words-on-line lls1) '(2 0))
(check-equal? (words-on-line (read-words/line "./ttt.txt"))
              '(0 0 1 0 5 5 3 0 1 0 5 3 5 3 0 2 0))

(define (words-on-line lls)
  (cond ((empty? lls) '())
        ((cons? lls)
         (cons (words# (first lls))
               (words-on-line (rest lls))))))

;; List-of-string -> Number
(check-equal? (words# (list "a" "b")) 2)
(check-equal? (words# '()) 0)
(define (words# los)
  (cond ((empty? los) 0)
        ((cons? los)
         (+ 1 (words# (rest los))))))


;; List-of-lines is one of:
;; - '()
;; - (cons Line List-of-lines)

;; List-of-lines -> String
(define (collapse lol) "")







;; List-of-list-of-numbers is one of:
;; - '()
;; - (cons Number List-of-list-of-numbers)
;; - (cons List-of-numbers List-of-list-of-numbers)
;;
;; '()
;; (cons 1 '())
;; (cons (cons 2 '()) (cons 1 '()))
;; (cons (cons 3 (cons 2 '())) (cons 1 '()))
;; (cons (cons (cons 5 (cons 4 '())) (cons 3 (cons 2 '()))) (cons 1 '()))

;; List-of-list-of-numbers -> Number
(check-equal? (sum-tree '()) 0)
(check-equal? (sum-tree (cons 1 '())) 1)
(check-equal? (sum-tree (cons (cons 2 '()) (cons 1 '()))) 3)
(check-equal? (sum-tree (cons (cons 3 (cons 2 '())) (cons 1 '()))) 6)
(check-equal? (sum-tree (cons (cons (cons 5 (cons 4 '())) (cons 3 (cons 2 '()))) (cons 1 '()))) 15)
(define (sum-tree t)
  (cond ((empty? t) 0)
        ((cons? t)
         (+ (if (cons? (first t))
                (sum-tree (first t))
                (first t))
            (sum-tree (rest t))))))

(define (sum-tree t)
  (cond ((empty? t) 0)
        ((cons? (first t))
         (+ (sum-tree (first t))
            (sum-tree (rest t))))
        ((cons? t)
         (+ (first t)
            (sum-tree (rest t))))))


;;;;
;; 11. Design by Composition
;;;;

;;;;
;; 11.1 The list Function
;;;;

;;;;
;; 11.2 Composing Functions
;;;;

;;;;
;; 11.3 Auxiliary Functions that Recur
;;;

;; Insertion Sort

;; '()
;; (list 1)
;; (list 3 2 1)
;; (list 8 2 3 4 7 6 5 9 1)

;; List-of-numbers -> List-of-numbers
;; produces a sorted version of lon
;;
;; we need to insert one number from the unsorted list in the
;; correct place in a sorted list until the list is sorted
(check-equal? (sort< '()) '())
(check-equal? (sort< (list 1 2 3)) (list 1 2 3))
(check-equal? (sort< (list 3 2 1)) (list 1 2 3))
(check-equal? (sort< (list 8 2 3 4 7 6 5 9 1)) (list 1 2 3 4 5 6 7 8 9))

(define (sort< lon)
  (cond ((empty? lon) '())
        (else (insert (first lon)
                      (sort< (rest lon))))))
;; Number List-of-numbers -> List-of-numbers
;; inserts n into the sorted list of numbers alon
(check-equal? (insert 3 '()) '(3) "insert in empty")
(check-equal? (insert 3 '(4)) (list 3 4) "insert before")
(check-equal? (insert 3 '(2)) (list 2 3) "insert after")
(check-equal? (insert 3 '(1 2 4)) (list 1 2 3 4) "insert between")
(check-equal? (insert 3 '(1 2 3 4)) (list 1 2 3 3 4) "insert next to =")
(define (insert n slon)
  (cond ((empty? slon) (list n))
        (else (if (<= n (first slon))
                  (cons n slon)
                  (cons (first slon) (insert n (rest slon)))))))

;; Sequential Search
;; Number List-of-numbers -> Boolean
(check-false (search 4 '()))
(check-false (search 4 (list 1)))
(check-true (search 4 (list 4)))
(check-true (search 4 (list 1 2 3 4)))
(define (search n alon)
  (cond ((empty? alon) #f)
        (else (or (= n (first alon))
                  (search n (rest alon))))))

;; Number Sorted-List-of-numbers -> Boolean
(check-false (search-sorted 0 (list 1)))
(check-false (search-sorted 0 (list 1 2 3 4 5 6 7 8 9)))
(check-false (search-sorted 4 (list 1 2 3 5 6 7 8 9)))
(check-false (search-sorted 10 (list 1 2 3 5 6 7 8 9)))
(check-true (search-sorted 4 (list 1 2 3 4 5 6 7 8 9)))
(check-true (search-sorted 9 (list 1 2 3 4 5 6 7 8 9)))
(check-true (search-sorted 1 (list 1 2 3 4 5 6 7 8 9)))
(check-true (search-sorted 1 (list 1)))
(define (search-sorted-iter n slon)
  (cond ((empty? slon) #f)
        ((= n (first slon)) #t)
        ((> n (first slon)) #f)
        (else (search-sorted n (rest slon)))))

(define (search-sorted n slon)
  (cond ((empty? slon) #f)
        ((< n (first slon)) #f)
        (else (or (= n (first slon))
                  (search-sorted n (rest slon))))))

;;;;
;; 11.4 Auxiliary Functions that Generalize
;;;;

;;
;; (define ())




;;;;
;; 12 Projects: Lists
;;;;

;;;;
;; 12.1 Real-World Data: Dictionaries
;;;;

(define location "/usr/share/dict/words")

;; String -> List-of-letter-strings
(check-equal? (explode "dog") (list "d" "o" "g"))
(check-equal? (explode "a") (list "a"))
(check-equal? (explode "") '())
(define (explode str)
  (define str-len (string-length str))
  (define (recur i str)
    (cond ((= str-len i) '())
          (else (cons (~a (string-ref str i))
                      (recur (add1 i) str)))))
  (recur 0 str))

;; A Dictionary is a List-of-strings
(define as-list (read-lines location))

;; A Letter is one of the following Strings:
;; - "a"
;; - ...
;; - "z"
;; or, equivalently, a member? of this list:
(define letters
  (explode "abcdefghijklmnopqrstuvwxyz"))

;; Letter Dictionary -> Number
(check-equal? (starts-with# "a" (list "apple" "apricot" "allez" "bar" "ball")) 3)
(check-equal? (starts-with# "b" (list "apple" "apricot" "allez" "bar" "ball")) 2)
(check-equal? (starts-with# "z" (list "apple" "apricot" "allez" "bar" "ball")) 0)
(check-equal? (starts-with# "a" (list "apple")) 1)
(check-equal? (starts-with# "a" '()) 0)
(define (starts-with# letter dictionary)
  (cond ((empty? dictionary) 0)
        (else (+ (if (starts-with? letter (first dictionary)) 1 0)
                 (starts-with# letter (rest dictionary))))))

;; Letter String -> Boolean
(check-true (starts-with? "a" "apple"))
(check-false (starts-with? "a" "banana"))
(define (starts-with? letter str)
  (string=? letter (substring str 0 1)))

;; -> 3296
(starts-with# "e" as-list)
;; -> 146
(starts-with# "z" as-list)

;; Letter-Counts is one of:
;; (letter-count Letter Number)
;; combines a Letter and a Number
(struct letter-count (letter count))

;; List-of-letter-counts is one of:
;; - '()
;; - (cons letter-count List-of-letter-counts)
;;
;; (list (letter-count "a" 1) (letter-count "b" 3))
;; (list (letter-count "a" 1))
;; '()

(define llc1 (list (letter-count "a" 3)
                   (letter-count "b" 2)
                   (letter-count "e" 4)
                   (letter-count "z" 1)))
(define dict1 (list "apple" "apricot" "allez" "bar" "ball"))

;; Letters Dictionary -> Letter-Counts
(check-equal? (letter-count-count
               (first
                (count-by-letter (explode "ab") dict1))) 3)
(check-equal? (letter-count-count
               (cadr
                (count-by-letter (explode "ab") dict1))) 2)
(define (count-by-letter letters dictionary)
  (cond ((empty? letters) '())
        (else (cons (letter-count (first letters)
                                  (starts-with# (first letters) dictionary))
                    (count-by-letter (rest letters) dictionary)))))

(for-each (lambda (lc)
            (display (format "\"~a\" -> ~a \n"
                             (letter-count-letter lc)
                             (letter-count-count lc))))
          (count-by-letter letters as-list))

;; Dictionary Letters -> Letter-Count
;; the Letter-Count for the most frequent
;; first letter in dictionary
(check-equal? (letter-count-letter (most-frequent (explode "abez") dict1)) "a")
(check-equal? (letter-count-count (most-frequent (explode "abez") dict1)) 3)
(define (most-frequent letters dictionary)
  (max-letter-count (count-by-letter letters dictionary)))

;; List-of-Letter-Counts -> Letter-Count
(check-equal? (letter-count-letter (max-letter-count llc1)) "e")
(check-equal? (letter-count-count (max-letter-count llc1)) 4)
;; List-of-Letter-Counts -> Letter-Count
(define (max-letter-count llc)
  (define m (letter-count "a" 0))
  (define (recur m llc)
    (cond ((empty? llc) m)
          (else (if (> (letter-count-count (first llc))
                       (letter-count-count m))
                    (recur (first llc) (rest llc))
                    (recur m (rest llc))))))
  (recur m llc))

;; Most frequent first letter as a Letter-Count
(define mffl (most-frequent letters as-list))
(display (format "\"~a\" -> ~a "
                 (letter-count-letter mffl)
                 (letter-count-count mffl)))

;; Dictionary -> List-of-Dictionaries
;; slice the input into a list of dictionaries
;; by first letter
(define dict2 (list "apple" "apricot" "allez" "bar" "ball" "enable" "energy" "zero"))

(words-by-first-letter dict2)
(define (words-by-first-letter dictionary)
  (define (recur cfl d lod dictionary)
    (cond ((empty? dictionary) lod)
          (else (let ((fl (first-letter (first dictionary))))
                  (if (string=? cfl fl)
                      (recur cfl
                             (cons (first dictionary) d)
                             lod
                             (rest dictionary))
                      (recur fl
                             '()
                             (cons d lod)
                             (rest dictionary)))))))
  (recur "a" '() '() dictionary))

(define (words-by-first-letter dictionary)
  (define (iter cfl d lod dict)
    (cond ((empty? dict) lod)
          ((string=? cfl (first-letter (first dict)))
           (iter cfl
                 (cons (first dict) d)
                 lod
                 (rest dict)))
          (else (iter (first-letter (first dict))
                      '()
                      (cons d lod)
                      (rest dict)))))
  (iter "a" '() '() dictionary))

;; String -> Letter
(equal? (first-letter "apple") "a")
(equal? (first-letter "bar") "b")
(equal? (first-letter "zero") "z")
(define (first-letter str)
  (substring str 0 1))

;;;;
;; 12.2 Real-World Data: iTunes
;;;;

;; An LTraack is one of:
;; - '()
;; - (cons Track LTrack)

(struct track (name artist album time track# added play# played))
;; A Track is a structure:
;; (track String String String N N Date N Date)

(struct date (year month day hour minute second))
;; A date is a structure:
;; (date N N N N N N)

;;;;
;; 12.3 Word Games, Composition Illustrated
;;;;

;; Sample Problem: Given a word, find all words that are made up
;; from the same letters. For example “cat” also spells “act.”

;; Permutation -> Factorial
;; 3 letters -> (* 3 2 1)   -> 6
;; 4 letters -> (* 4 3 2 1) -> 24

;; Any List-of-any -> Boolean
(check-true (member? "cat" (list "act" "cat")))
(check-false (member? "dog" (list "act" "cat")))
(check-true (member? 1 (list 1 2 3 4)))
(check-false (member? 8 (list 1 2 3 4)))
(define (member? x lst)
  (cond ((empty? lst) #f)
        (else (or (equal? x (first lst)) (member? x (rest lst))))))

;; String -> List-of-strings
;; finds all words that use the same letters as s
(define (all-words-on-cat? w)
  (and (member? "cat" w)
       (member? "act" w)))
(check-true (all-words-on-cat? (alternative-words "cat")))

(define (alternative-words s)
  (in-dictionary
   (words->strings (arrangements (string->word s)))))

;; A Word is of:
;; - '()
;; - (cons 1String Word)
;; interpretation a Word is a list of 1Strings (letters)

;; A List-of-words is one of:
;; - '()
;; - (cons Word List-of-words)

;; List-of-words -> List-of-strings
;; turns all Words in low into Strings
(check-equal? (words->strings (list (list "b" "a" "r")
                                    (list "a" "c" "t")))
              (list "bar" "act"))
(check-equal? (words->strings  '()) '())
(define (words->strings low)
  (cond ((empty? low) '())
        (else (cons (word->string (first low))
                    (words->strings (rest low))))))

;; String -> Word
;; converts s to the chosen word representation
(check-equal? (string->word "bar") (list "b" "a" "r"))
(check-equal? (string->word "b") (list "b"))
(check-equal? (string->word "") '())
(define (string->word s)
  (cond ((string-empty? s) '())
        (else (cons (string-first s)
                    (string->word (string-rest s))))))

(check-true (string-empty? ""))
(check-false (string-empty? "bar"))
(define (string-empty? s) (string=? s ""))
(check-equal? (string-first "bar") "b")
(define (string-first s) (substring s 0 1))
(check-equal? (string-rest "bar") "ar")
(define (string-rest s) (substring s 1))

;; Word -> String
;; converts w to a string
(check-equal? (word->string (list "b" "a" "r")) "bar")
(check-equal? (word->string (list "b")) "b")
(check-equal? (word->string  '()) "")
(define (word->string w)
  (cond ((empty? w) "")
        (else (string-append (first w)
                             (word->string (rest w))))))

;; List-of-strings -> List-of-strings
;; picks out all those Strings that occur in the dictionary
(define (in-dictionary los) '())

;; Word -> List-of-words
(arrangements (list "b" "a" "r"))
(define (arrangements w)
  (cond ((empty? w) (list '()))
        (else
         (insert-everywhere/in-all-words (first w)
                                         (arrangements (rest w))))))


;; 1String List-of-words -> List-of-words
;; insert at: beginning middle end
(define low-out (list (list "b" "a" "r") (list "a" "b" "r") (list "a" "r" "b")
                      (list "b" "r" "a") (list "r" "b" "a") (list "r" "a" "b")))
(define low-in (list (list "a" "r") (list "r" "a")))
(check-equal? (insert-everywhere/in-all-words "b" low-in) low-out)
(define (insert-everywhere/in-all-words l low)
  (cond ((empty? low) '())
        (else (append (insert-everywhere/word l (first low))
                      (insert-everywhere/in-all-words l (rest low))))))

;; 1String Word -> List-of-words
(check-equal? (insert-everywhere/word "b" (list "a" "r"))
              (list (list "b" "a" "r") (list "a" "b" "r") (list "a" "r" "b")))
(define (insert-everywhere/word l w)
  (cond ((empty? w) (list (list l)))
        (else (cons (cons l w)
                    (insert-front (first w)
                                  (insert-everywhere/word l (rest w)))))))

;; 1String List-of-Word -> Word
(check-equal? (insert-front "b" '()) '())
(check-equal? (insert-front "b" (list (list "a" "r"))) (list (list "b" "a" "r")))
(check-equal? (insert-front "b" (list (list "a" "r") (list "r" "a")))
              (list (list "b" "a" "r") (list "b" "r" "a")))
(define (insert-front l low)
  (cond ((empty? low) '())
        (else (cons (cons l (first low)) (insert-front l (rest low))))))

;; Bonus:
;; Number -> Number
(check-equal? (factorial 0) 1)
(check-equal? (factorial 1) 1)
(check-equal? (factorial 2) 2)
(check-equal? (factorial 3) 6)
(check-equal? (factorial 4) 24)
(define (factorial n)
  (cond ((zero? n) 1)
        (else (* n (factorial (sub1 n))))))

(require lang/posn)

;; N -> Image
(define (unit-circle size)
  (overlay/align "middle" "middle"
                 (line 1 (* 2 size) "gray")
                 (line (* 2 size) 1 "gray")
                 (rotate 30 (line (* 2 size) 1 "white"))
                 (rotate 30 (line (* 2 size) 1 "gray"))
                 (rotate 45 (line (* 2 size) 1 "gray"))
                 (rotate 60 (line (* 2 size) 1 "gray"))
                 (rotate -60 (line (* 2 size) 1 "gray"))
                 (rotate -45 (line (* 2 size) 1 "gray"))
                 (rotate -30 (line (* 2 size) 1 "gray"))
                 (circle size "outline" "gray")
                 (empty-scene (* 3 size) (* 3 size) "white")))

(unit-circle 100)

(define (unit-circle size)
  (define origin (* 1.5 size))
  (place-images/align
   (list (line 1 (* 2 size) "gray")
         (line (* 2 size) 1 "gray")
         (circle size "outline" "gray")
         (rotate 30 (line (* 2.1 size) 1 "gray"))
         (rotate 45 (line (* 2.1 size) 1 "gray"))
         (rotate 60 (line (* 2.1 size) 1 "gray"))
         (rotate -60 (line (* 2.1 size) 1 "gray"))
         (rotate -45 (line (* 2.1 size) 1 "gray"))
         (rotate -30 (line (* 2.1 size) 1 "gray"))
         )
   (list (make-posn origin origin)
         (make-posn origin origin)
         (make-posn origin origin)
         (make-posn origin origin)
         (make-posn origin origin)
         (make-posn origin origin)
         (make-posn origin origin)
         (make-posn origin origin)
         (make-posn origin origin))
   "middle" "middle"
   (empty-scene (* 3 size) (* 3 size) "white")))

;;;;
;; 12.5 Feeding Worms
;;;;

;; 1. constants: physical and graphical
;; 2. data representation for possible states of te world
;; 3.

(define width 200)
(define height 200)
(define background (empty-scene width height "white"))


(define (cn n)
  (+ (- (expt 2 n) (* 3 n)) 5))

(foldl + 0 (map cn (range 1 11 1)))

(/ (* 100 101) 2)
(foldl + 0 (range 0 101 1))

(define (snake-main initial)
  (big-bang initial
            (stop-when? game-end?)
            (on-tick update)
            (pn-key key-handler)
            (to-draw render)))

;;;;
;; 12.6 Simple Tetris
;;;;

;;;;
;; 12.7 Full Space War
;;;;

;; Exercise 224. Use the lessons learned from the preceding two
;; sections and design the game extension slowly, adding one
;; feature of the game after another. Always use the design
;; recipe and rely on the guidelines for auxiliary functions. If
;; you like the game, add other features: show a running text;
;; equip the UFO with charges that can eliminate the tank; create
;; an entire fleet of attacking UFOs; and above all, use your
;; imagination.



;; Exercise 225. Design a fire-fighting game.
;;
;; The game is set in the western states where fires rage through
;; vast forests. It simulates an airborne fire-fighting effort.
;; Specifically, the player acts as the pilot of an airplane that
;; drops loads of water on fires on the ground. The player
;; controls the plane’s horizontal movements and the release of
;; water loads.
;;
;; Your game software starts fires at random places on the
;; ground. You may wish to limit the number of fires, making them
;; a function of how many fires are currently burning or other
;; factors. The purpose of the game is to extinguish all fires in
;; a limited amount of time. Hint Use an iterative design
;; approach as illustrated in this chapter to create this game.

;; Design by iterative refinement:
;;
;; The basic idea is that the first program implements only a
;; fraction of the desired behavior, the next one a bit more, ...

;;;;
;; 12.8 Finite State Machines
;;;;

;;;;
;; Summary
;;;;












(define 02-arbitrary-large-data
  (test-suite
   "Testing sample problem 8.3 search a list"

   (check-true (contains-flatt? (cons "Flatt" '())))
   (check-false (contains-flatt? (cons "Find" '())))

   (check-true (contains-flatt?
                (cons "A" (cons "Flatt" (cons "G" '())))))
   (check-false (contains-flatt?
                 (cons "A" (cons "Find" (cons "G" '())))))

   (check-true (contains? "a" (cons "a" '())))
   (check-false (contains? "w" (cons "a" '())))
   (check-true (contains? "d" (list "a" "b" "c" "d" "e" "f" "g")))
   (check-false (contains? "w" (list "a" "b" "c" "d" "e" "f" "g")))

   (check-equal? (count '()) 0)
   (check-equal? (count (cons 1 '())) 1)
   (check-equal? (count (cons 3 (cons 2 (cons 1 '())))) 3)

   (check-equal? (sum '()) 0)
   (check-equal? (sum (cons 1 '())) 1)
   (check-equal? (sum (cons 5 (cons 3 (cons 1 '())))) 9)

   (check-true (pos-list? '()))
   (check-true (pos-list? (cons 1 '())))
   (check-false (pos-list? (cons -1 '())))
   (check-true (pos-list? (cons 3 (cons 2 (cons 1 '())))))
   (check-false (pos-list? (cons 3 (cons 2 (cons -1 '())))))

   (check-true (all-true (cons #t '())))
   (check-false (all-true (cons #f '())))
   (check-true (all-true (cons #t (cons #t (cons #t (cons #t '()))))))
   (check-false (all-true (cons #t (cons #f (cons #t (cons #t '()))))))

   (check-true (some-true (cons #t '())))
   (check-false (some-true (cons #f '())))
   (check-true (some-true (cons #t (cons #t (cons #t (cons #t '()))))))
   (check-true (some-true (cons #t (cons #f (cons #t (cons #t '()))))))
   (check-false (some-true (cons #f (cons #f (cons #f (cons #f '()))))))

   (check-true (sorted>? (cons 20 '())))
   (check-true (sorted>? (cons 40 (cons 30 (cons 20 '())))))
   (check-true (sorted>? (cons 41 (cons 40 (cons 30 (cons 20 '()))))))
   (check-true (sorted>? (reverse (range 10 40 1))))
   (check-false (sorted>? (cons 40 (cons 10 (cons 30 '())))))
   (check-false (sorted>? (cons 40 (cons 30 (cons 31 '())))))
   (check-false (sorted>? (cons 20 (cons 30 (cons 40 '())))))
   (check-false (sorted>? (range 10 40 1)))

   ))

(run-tests 02-arbitrary-large-data)
