(require rackunit rackunit/text-ui)

;;;;
;; 19. The Poetry of S-expressions
;;;;

;; 19.1 Trees

(struct no-parent [])
(struct child (father mother name date eyes) #:transparent)

(define NP (no-parent))

;; An FT is one of:
;; - NP
;; - (child FT FT String N String)

;; oldest
(define Carl (child NP NP "Carl" 1926 "green"))
(define Bettina (child NP NP "Bettina" 1926 "green"))

;; middle
(define Adam (child Carl Bettina "Adam" 1950 "green"))
(define Eva (child Carl Bettina "Eva" 1965 "blue"))
(define Fred (child NP NP "Fred" 1966 "pink"))

;; youngest
(define Gustav (child Fred Eva "Gustav"  1988 "brown"))

(display (child-father Gustav))

;; FT -> ?
(define (f-ft ft)
  (cond ((no-parent? ft) (.))
        (else (.    (f-ft (child-father ft))
                    (f-ft (child-mother ft))
                    (child-name ft)
                    ...
                    ))))

;; FT -> Boolean
(check-true (blue-eyed-child? (child NP NP "B" 1990 "blue")))
(check-false (blue-eyed-child? (child NP NP "G" 1991 "green")))
(check-true (blue-eyed-child? Gustav))
(define (blue-eyed-child? ft)
  (cond ((no-parent? ft) #f)
        (else (or (string=? (child-eyes ft) "blue")
                  (blue-eyed-child? (child-father ft))
                  (blue-eyed-child? (child-mother ft))))))

;; Ex. 310
;; FT -> N
(check-equal? (count-persons NP) 0)
(check-equal? (count-persons (child NP NP "A" 1990 "blue")) 1)
(check-equal? (count-persons Eva) 3)
(check-equal? (count-persons Gustav) 5)
(define (count-persons ft)
  (cond ((no-parent? ft) 0)
        (else (+ 1 (count-persons (child-father ft))
                   (count-persons (child-mother ft))))))

;; Ex. 311
;; Number FT -> Number
;; takes an year and an FT
(check-equal? (average-age 2019 (child NP NP "A" 2000 "green")) 19)
(check-equal? (ft-age 2019 (child NP NP "A" 2000 "green")) 19)
(check-equal? (average-age 2000 Eva) 61)
;; (/ (foldl + 0 (map (lambda (x) (- 2000 x)) (list 1926 1926 1965))) 3)
(define (average-age year ft)
  (/ (ft-age year ft) (count-persons ft)))

;; Number FT -> Number
(check-equal? (ft-age 2019 (child NP NP "A" 2000 "green")) 19)
(check-equal? (ft-age 2000 Eva) (+ 74 74 35))
(define (ft-age year ft)
  (cond ((no-parent? ft) 0)
        (else (+ (child-age year ft)
                 (ft-age year (child-father ft))
                 (ft-age year (child-mother ft))))))

;; Number FT -> Number
(check-equal? (child-age 2019 (child NP NP "A" 2000 "green")) 19)
(check-equal? (child-age 2019 NP) 0)
(define (child-age year ft)
  (if (no-parent? ft) 0 (- year (child-date ft))))

;; Ex. 312
;; FT -> List-of-eye-colors
;; produce a list of eye colors from FT
(check-equal? (eye-color NP) '())
(check-equal? (eye-color (child NP NP "A" 1990 "green")) (list "green"))
(check-equal? (eye-color Eva) (list "blue" "green" "green"))
(define (eye-color ft)
  (cond ((no-parent? ft) '())
        (else (append (list (child-eyes ft))
                      (eye-color (child-father ft))
                      (eye-color (child-mother ft))))))

;; Ex. 313
;; FT -> Boolean
(check-false (blue-eyed-ancestor NP))
(check-false (blue-eyed-ancestor (child NP NP "A" 1990 "blue")))
(check-true (blue-eyed-ancestor Gustav))
(define (blue-eyed-ancestor ft)
  (cond ((no-parent? ft) #f)
        (else (or (blue-eyed-parent? ft)
                  (blue-eyed-ancestor (child-father ft))
                  (blue-eyed-ancestor (child-mother ft))))))

;; FT -> Boolean
(check-true (blue-eyed-parent? Gustav))
(check-false (blue-eyed-parent? (child NP NP "A" 1990 "blue")))
(define (blue-eyed-parent? ft)
  (if (or (no-parent? ft)
          (no-parent? (child-father ft))
          (no-parent? (child-mother ft)))
      #f
      (or (string=? "blue" (child-eyes (child-father ft)))
          (string=? "blue" (child-eyes (child-mother ft))))))


;; 19.2 Forests

;; An FF is one of:
;; - '()
;; - (cons FT FF)
;; interpretation a family forest represents several
;; families (say, a town) and thier ancestor trees

(define ff1 (list Carl Bettina))
(define ff2 (list Fred Eva))
(define ff3 (list Fred Eva Carl))
(display ff3)

;; FF -> Boolean
(check-false (blue-eyed-child-in-forest? ff1))
(check-true (blue-eyed-child-in-forest? ff2))
(check-true (blue-eyed-child-in-forest? ff3))
(define (blue-eyed-child-in-forest? ff)
  (cond ((empty? ff) #f)
        (else (or (blue-eyed-child? (first ff))
                  (blue-eyed-child-in-forest? (rest ff))))))



;;;;
;; 19.3 S-expressions
;;;;

;; An S-expr is one of:
;; - Atom
;; - SL

;; An Atom is one of:
;; - Number
;; - String
;; - Symbol

;; An SL is one of:
;; - '()
;; - (cons S-expr SL)

;; Ex. 316
(check-true (atom? 1))
(check-true (atom? 1.4))
(check-true (atom? "a"))
(check-true (atom? 'a))
(check-false (atom? '()))
(check-false (atom? (list 1 1.4)))
(define (atom? a)
  (or (number? a) (string? a) (symbol? a)))

;; Data examples:
;; 'a
;; (list 'a 'a)
;; '('a ('b 'a))
;; '(('b 'a))
;; '(ul (li (a) li) ul)

;; Symbol S-expr -> N
(check-equal? (count-sexp 'a '()) 0)
(check-equal? (count-sexp 'a 'a) 1)
(check-equal? (count-sexp 'a '('a 'a)) 2)
(check-equal? (count-sexp 'a '('a ('a ('a) 'a))) 4)
(define (count-sexp s sexp)
  (cond ((atom? sexp) (count-atom s sexp))
        (else (count-sl s sexp))))

(define (count-atom s sexp) (if (equal? s sexp) 1 0))
(define (count-sl s sexp)
  (cond ((empty? sexp) 0)
        (else (+ (count-sexp s (first sexp))
                 (count-sl s (rest sexp))))))

(define (count-sexp s sexp)
  (cond ((empty? sexp) 0)
        (else (cond ((atom? sexp) (if (equal? s sexp) 1 0))
                    (else (+ (count-sexp s (first sexp))
                             (count-sexp s (rest sexp))))))))


;; Ex. 318
;; S-expr -> N
(check-equal? (depth-sexp '()) 0)
(check-equal? (depth-sexp 'a) 1)
(check-equal? (depth-sexp '('a 'b)) 2)
(check-equal? (depth-sexp '(('a 'b))) 3)
(check-equal? (depth-sexp '('a ('a ('a) 'a))) 4)
(define (depth-sexp sexp)
  (cond ((atom? sexp) (depth-atom sexp))
        (else (+ 1 (depth-sl sexp)))))

(define (depth-atom a) 1)

(check-equal? (depth-sl '(('a 'a))) 3)
(check-equal? (depth-sl '('a)) 2)
(define (depth-sl sl)
  (cond ((empty? sl) 0)
        (else (max (depth-sexp (first sl))
                   (depth-sl (rest sl))))))

;; Ex. 319
;; S-expr -> S-expr
(check-equal? (substitude 'a 'a 'a) 'a)
(check-equal? (substitude 'b 'a 'b) 'a)
(check-equal? (substitude 'b 'a '(b b)) '(a a))
(check-equal? (substitude 'b 'a '((b b))) '((a a)))
(check-equal? (substitude 'b 'a '((b b (a (b))))) '((a a (a (a)))))
(define (substitude old new sexp)
  (cond ((atom? sexp) (substitude-atom old new sexp))
        (else (substitude-sl old new sexp))))

(define (substitude-atom old new a) (if (equal? old a) new a))

(define (substitude-sl old new sl)
  (cond ((empty? sl) '())
        (else (cons (substitude old new (first sl))
                    (substitude-sl old new (rest sl))))))


;; 19.4 Designing with Intertwined Data

;; 19.5 Project BSTs

(struct no-info [])
(define NONE (no-info))

(struct node (ssn name left right) #:transparent)

;; A BT is one of:
;; - NONE
;; - (node Number Symbol BT BT)

(define bt1 (node 1 'a
                  (node 2 'b (node 5 'e NONE NONE) NONE)
                  (node 3 'c NONE
                        (node 4 'd NONE NONE))))

(define bst1 (node 1 'a
                  (node 2 'b NONE NONE)
                  (node 3 'c NONE
                        (node 4 'd NONE NONE))))

;; Ex. 322
;; Number BT -> Boolean
(check-false (contains-bt 1 NONE))
(check-true (contains-bt 1 bt1))
(check-true (contains-bt 2 bt1))
(check-true (contains-bt 3 bt1))
(check-true (contains-bt 4 bt1))
(check-true (contains-bt 5 bt1))
(define (contains-bt n bt)
  (cond ((no-info? bt) #f)
        (else (or (= n (node-ssn bt))
                  (contains-bt n (node-left bt))
                  (contains-bt n (node-right bt))))))

;; Ex. 323
;; Number BT -> (Maybe Symbol)
(check-false (search-bt 1 NONE))
(check-false (search-bt 8 bt1))
(check-equal? (search-bt 1 bt1) 'a)
(check-equal? (search-bt 2 bt1) 'b)
(check-equal? (search-bt 3 bt1) 'c)
(check-equal? (search-bt 4 bt1) 'd)
(define (search-bt n bt)
  (cond ((no-info? bt) #f)
        ((equal? n (node-ssn bt)) (node-name bt))
        (else (or (search-bt n (node-left bt))
                  (search-bt n (node-right bt))))))

;; Ex. 324
;; BT -> List-of-Numbers
(check-equal? (inorder NONE) '())
(check-equal? (inorder (node 0 'a NONE NONE)) '(0))
(check-equal? (inorder bt1) (list 1 2 5 3 4))
(check-equal? (inorder bst1) (list 1 2 3 4))
(define (inorder bt)
  (cond ((no-info? bt) '())
        (else (append (list (node-ssn bt))
                      (inorder (node-left bt))
                      (inorder (node-right bt))))))


;; Ex. 325
;; Number BST -> [Maybe Symbol]
(define (search-bst n bst) NONE)

;; Ex. 326
;; [List-of [List Number Symbol]] -> BST
;; '()
;; '(())
;; '((1 'a))
;; '((1 'a) (2 'b) (3 'c) (4 'd))
(define bt-left (node 1 'a (node 2 'b (node 3 'c (node 4 'd NONE NONE) NONE) NONE) NONE))
(define bt-right (node 1 'a NONE (node 2 'b NONE (node 3 'c NONE (node 4 'd NONE NONE)))))
(define bbt (node 2 'b (node 1 'a NONE NONE) (node 3 'c NONE NONE)))

(check-equal? (create-bst NONE 1 'a) (node 1 'a NONE NONE))
(check-equal? (create-bst (node 1 'a NONE NONE) 2 'b) (node 1 'a NONE (node 2 'b NONE NONE)))
(check-equal? (create-bst bbt 4 'd) (node 2 'b (node 1 'a NONE NONE) (node 3 'c NONE (node 4 'd NONE NONE))))

(define (create-bst bst n s)
  (cond ((no-info? bst) (node n s NONE NONE))
        (else (cond ((< n (node-ssn bst))
                     (node (node-ssn bst)
                           (node-name bst)
                           (create-bst (node-left bst) n s)
                           (node-right bst)))
                    ((> n (node-ssn bst))
                     (node (node-ssn bst)
                           (node-name bst)
                           (node-left bst)
                           (create-bst (node-right bst) n s)))))))

;; Ex. 327
;; data:
(define A-lst '((99 o) (77 l) (24 i) (10 h) (95 g) (15 d) (89 c) (29 b) (63 a)))
(define A-tree (node 63 'a (node 29 'b (node 15 'd (node 10 'h NONE NONE) (node 24 'i NONE NONE)) NONE)
                           (node 89 'c (node 77 'l NONE NONE) (node 95 'g NONE (node 99 'o NONE NONE)))))

;; [List-of [List Number Symbol]] -> BST
(check-equal? (create-bst-from-list '()) NONE)
(check-equal? (create-bst-from-list '((1 a))) (node 1 'a NONE NONE))
(check-equal? (create-bst-from-list '((1 a) (3 c) (2 b)))
              (node 2 'b (node 1 'a NONE NONE) (node 3 'c NONE NONE)))
(check-equal? (create-bst-from-list A-lst) A-tree)
(define (create-bst-from-list lst)
  (cond ((empty? lst) NONE)
        (else (create-bst (create-bst-from-list (rest lst))
                          (first (first lst))
                          (second (first lst))))))

;; 19.6 Simplifying Functions

;; S-expr Symbol Atom -> S-expr
;; replaces all occurrences of old in sexp with new

(check-equal? (substitute '() 'a 'b) '())
(check-equal? (substitute '(a) 'a 'b) '(b))
(check-equal? (substitute '((a b 8)) 'a 'b) '((b b 8)))
(check-equal? (substitute '(((world) bye) bye) 'bye '42)
              '(((world) 42) 42))

(define (substitute sexp old new)
  (cond ((atom? sexp) (if (equal? sexp old) new sexp))
        (else (map (lambda (x) (substitute x old new)) sexp))))

;; (define (substitute sexp old new)
;;   (local (;; S-expr -> S-expr
;;           (define (for-sexp sexp)
;;             (cond
;;              [(atom? sexp) (for-atom sexp)]
;;              [else (for-sl sexp)]))
;;           ;; SL -> S-expr
;;           (define (for-sl sl)
;;             (cond
;;              [(empty? sl) '()]
;;              [else (cons (for-sexp (first sl))
;;                          (for-sl (rest sl)))]))
;;           ;; Atom -> S-expr
;;           (define (for-atom at)
;;             (cond
;;              [(number? at) at]
;;              [(string? at) at]
;;              [(symbol? at) (if (equal? at old) new at)])))
;;     (for-sexp sexp)))

;;;;
;; 20 Iterative Refinement
;;;;

;; a programmer should proceed like a physicist
;; (using the scientific method)

;; 20.1 Data Analysis

;; 20.2 Refining Data Definitions

;; Model 1:

;; A Dir is one of:
;; - '()
;; - (cons File Dir)
;; - (cons Dir Dir)

;; A File is a String

;; Ex. 330:

;; Model 2:

;; A Dir is a structure:
;; - (dir String LOFD)

;; A LOFD is one of:
;; - '()
;; - (cons File LOFD)
;; - (cons Dir LOFD)

;; A File is a String

(struct dir (name content))

;; Model 3:

;; A File is a structure:
;; - (file String Number String)

;; A Dir is a structure:
;; - (dir String Dir* File*)

;; A Dir* is one of:
;; - '()
;; - (cons File Dir*)

;; A File* is one of:
;; - '()
;; - (cons File File*)

(struct file (name size contents))
(struct dir (name dirs files))

;; 20.3 Refining Functions


;;;;
;; 21 Refining Interpreters
;;;;

;; the read-eval-print loop

;; 21.1 Interpreting Expressions

;; BSL expression as BSL data

(check-equal? (add 1 3) 4)

(struct add (left right) #:transparent)
(struct mul (left right) #:transparent)

(define t 't)
(define f 'f)
(struct or-exp (left right) #:transparent)
(struct and-exp (left right) #:transparent)
(struct not-exp (bool) #:transparent)

;; (add 1 3)
;; (add 4 (add 1 3))
;; (add (mul 3 4) (mul 3 (add 1 3)))


;; Ex. 347
;; BSL-expr -> Value
(check-equal? (eval-expression (add 1 3)) 4)
(check-equal? (eval-expression (add 4 (add 1 3))) 8)
(check-equal? (eval-expression (add (mul 3 4) (mul 3 (add 1 3)))) 24)

(check-true (eval-expression (or-exp #t #f)))
(check-false (eval-expression (or-exp #f #f)))

(check-false (eval-expression (and-exp #t #f)))
(check-false (eval-expression (and-exp #f #t)))
(check-false (eval-expression (and-exp #f #f)))
(check-true (eval-expression (and-exp #t #t)))

(check-false (eval-expression (not-exp #t)))
(check-true (eval-expression (not-exp #f)))

(define (eval-expression bsl)
  (cond ((add? bsl)
         (+ (eval-expression (add-left bsl))
            (eval-expression (add-right bsl))))
        ((mul? bsl)
         (* (eval-expression (mul-left bsl))
            (eval-expression (mul-right bsl))))
        ((or-exp? bsl)
         (or (eval-expression (or-exp-left bsl))
             (eval-expression (or-exp-right bsl))))
        ((and-exp? bsl)
         (and (eval-expression (and-exp-left bsl))
              (eval-expression (and-exp-right bsl))))
        ((not-exp? bsl) (not (eval-expression (not-exp-bool bsl))))
        (else bsl)))


;; Parsers:
;; parsers bridge the gap between convenience and implementation
;; a parser checks whether some piece of data conforms to a data
;; definition and, if it does, builds a matching element from the
;; choosen class of data (parse tree) else it signals an error.

(check-equal? (parse '(+ 3 4)) (add 3 4))
(check-equal? (parse '(* 3 4)) (mul 3 4))
(check-equal? (parse '(+ (* 1 3) (* 1 4)))
              (add (mul 1 3) (mul 1 4)))

(define Wrong "Error - wrong expression!")

(define (parse s)
  (cond ((atom? s) (parse-atom s))
        (else (parse-sl s))))

;; SL -> BSL-expr
(define (parse-sl s)
  (local ((define L (length s)))
    (cond ((< L 3) (error Wrong))
          ((and (= L 3) (symbol? (first s)))
           (cond ((symbol=? (first s) '+)
                  (add (parse (second s))
                       (parse (third s))))
                 ((symbol=? (first s) '*)
                  (mul (parse (second s))
                       (parse (third s))))
                 (else (error Wrong))))
           (else (error Wrong)))))

;; Atom -> BSL-expr
(define (parse-atom s)
  (cond
   ((number? s) s)
   ((string? s) (error WRONG))
   ((symbol? s) (error WRONG))))

;; S-expr -> [Maybe Atom]
(check-equal? (interpreter-expr '(+ 3 4)) 7)
(check-equal? (interpreter-expr '(* 3 4)) 12)
(check-equal? (interpreter-expr '(+ (* 1 3) (* 1 4))) 7)
(define (interpreter-expr sexp)
  (eval-expression (parse sexp)))

;; 21.2 Interpreting Variables

;; A BSL-var-expr is one of:
;; - Number
;; - Symbol
;; (add BSL-var-expr BSL-var-expr)
;; (mul BSL-var-expr BSL-var-expr)

;; x         'x
;; (+ x 3)   (add 'x 3)
;; (* x 3)   (mul 'x 3)

;; BSL-var-expr Symbol Number -> BSL-var-expr
(check-equal? (subst 'x 'x 4) 4)
(check-equal? (subst (add 'x 3) 'x 4) (add 4 3))
(check-equal? (subst (mul 'x 3) 'x 4) (mul 4 3))
(define (subst ex x v)
  (cond ((add? ex) (add (subst (add-left ex) x v)
                        (subst (add-right ex) x v)))
        ((mul? ex) (mul (subst (mul-left ex) x v)
                        (subst (mul-right ex) x v)))
        ((equal? ex x) v)
        (else ex)))

;; BSL-var-expr -> Boolean
(check-true (numeric? 4))
(check-true (numeric? (add 3 4)))
(check-true (numeric? (mul 3 4)))
(check-true (numeric? (mul (add 1 2) 4)))
(check-false (numeric? 'x))
(check-false (numeric? (add 'x 4)))
(check-false (numeric? (mul (add 'x 2) 4)))
(define (numeric? ex)
  (cond ((add? ex) (and (numeric? (add-left ex))
                        (numeric? (add-right ex))))
        ((mul? ex) (and (numeric? (mul-left ex))
                        (numeric? (mul-right ex))))
        ((number? ex) #t)
        ((symbol? ex) #f)))

;; BSL-var-exp -> [Maybe value]
(check-equal? (eval-variable 4) 4)
(check-equal? (eval-variable (add 3 4)) 7)
(check-equal? (eval-variable (add (mul 1 3) 4)) 7)
(define (eval-variable ex)
  (cond ((numeric? ex) (eval-expression ex))
        (else (error Wrong))))

;; Asociation Lists

;; An AL is [List-of Asociation].
;; An Asociation is a list of two items:
;; - (cons Symbol (cons Number '()))

;; BSL-var-exp AL -> [Maybe value]
(define da1 '((x 1) (y 3) (z 4)))
(check-equal? (eval-variable* (add 'z (add 'y (add 'x 0))) da1) 8)
(define (eval-variable* ex da)
  (cond ((empty? da) ex)
        (else (eval-variable* (subst ex (first (first da)) (second (first da)))(rest da)))))

(define (eval-variable* ex da)
  (eval-variable
   (foldl (lambda (al expr)
            (subst expr (first al) (second al)))
          ex da)))

(define (promo p d) (- p (* p (/ d 100.0))))
