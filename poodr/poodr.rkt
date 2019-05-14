;; 2. Designing Classes with Single Responsibility

;; Gear v1
(struct gear (chainring cog) #:transparent)
;; Gear is a structure:
;;   (gear (Number Number))

;; Gear -> Number
;; calculates a gear ratio
(define (ratio g)
  (exact->inexact
   (/ (gear-chainring g)
      (gear-cog g))))

(display (ratio (gear 48 11)))
(display (ratio (gear 34 28)))

;; Gear v2
(struct gear (chainring cog rim tire) #:transparent)

;; Gear -> Number
(define (gear-inches g)
  (* (ratio g) (+ (gear-rim g) (* 2 (gear-tire g)))))

(display (gear-inches (gear 48 11 28 1.25)))
(display (gear-inches (gear 48 11 20 1.75)))
;; breaks the code using the old gear struct (v1)

;; Gear v2.1
(struct gear (chainring cog) #:transparent)
(struct wheel (rim tire) #:transparent)

(define (gear-inches g w)
  (* (ratio g) (+ (wheel-rim w) (* 2 (wheel-tire w)))))

;; simply extends the code

;; Gear v2.2
(struct gear (chainring cog))

;; Number Number -> Number
(define (cog-adjustment size adjustment)
  (if (>= 1 adjustment)
      (* size adjustment)
      size))

(gear 48 (cog-adjustment 11 1))
(gear 48 11)

;; if you need to change what cog is add a function and there is
;; still no effect on clint code (v* and v2.2 all work)


;; Revealing Reference

;; 'Data':
;; List-of [List-of Number Number]
;; Rim size and Tire size in cm
(define data1 '((622 25) (622 28) (622 32) (622 38)))

;; 'Data' -> List-of-Wheels
(define (wheelify data)
  (map (lambda(d) (wheel (first d) (second d))) data))

;; List-of-Wheels -> List-of-Diameters v1
(define (diameters wheels)
  (map (lambda(w) (+ (wheel-rim w) (* 2 (wheel-tire w)))) wheels))

(diameters (wheelify data1))

;; Isolate Extra Responsibility from Methods

;; Wheel -> Number
(define (diameter w)
  (+ (wheel-rim w) (* 2 (wheel-tire w))))

;; List-of-Wheels -> List-of-Diameters v2
(define (diameters wheels)
  (map diameter wheels))

;; Wheel -> Number
(define (circumference w)
  (* pi (diameter w)))

;; 3. Managing Dependancies

;; Understanding Dependancies



;; Recongnizing  Dependancies

;; 4. Creating Flexible Interfaces

;; Finding the Public Interface
(struct trip (date difficulty))
(struct customer ())
(struct mechanic ())
(struct bike ())

;; List-of-Trips Customer -> List-of-Trips
(define (suitable-trip lot on-date of-difficulty) lot)

;; List-of-Bikes Trip -> List-of-Bikes
(define (suiteble-bike lob trip-date route-type) lob)

;; Trip -> Trip
(define (prepare-bikes t) t)

;; Bike -> Bike
(define (clean-bike b) b)
;; Bike -> Bike
(define (pump-tires b) b)
;; Bike -> Bike
(define (lube-chain b) b)
;; Bike -> Bike
(define (check-brakes b) b)



;; Evaluation example:
(eval '(((lambda (x) (lambda (y) (+ x y))) 3) 4) <e0>)

(apply (eval '((lambda (x) (lambda (y) (+ x y))) 3) <e0>)
       (evlist '(4) <e0>))

(apply (eval '((lambda (x) (lambda (y) (+ x y))) 3) <e0>)
       (cons (eval '4 <e0>)
             (evlist '() <e0>)))

(apply (eval '((lambda (x) (lambda (y) (+ x y))) 3) <e0>)
       (cons 4 '()))

(apply (eval '((lambda (x) (lambda (y) (+ x y))) 3) <e0>)
       '(4))

(apply (apply (eval '(lambda (x) (lambda (y) (+ x y))) <e0>)
              '(3))
       '(4))

(apply (apply '(closure ((x) (lambda (y) (+ x y))) <e0>)
              '(3))
       '(4))

;; Global environment:
;; e0 -> | +: , *: , -: , /: , car: , cdr: , cons: , eq?: |
;;
;; Bind new environment:
;; e1 -> | x: 3|

(/ (+ 9.36 9.48 9.6) 3)

(require rackunit rackunit/text-ui)

(define sexp0 1)
(define sexp1 '(define inc (lambda (x) (+ x 1))))

(check-equal? (compile sexp0) "1")
(check-equal? (compile sexp1) "function inc(x) { return x + 1; }")

(define (compile sexp)
  (cond ((number? sexp) (sexp->number sexp))
        ((lambda? sexp) (sexp->function sexp))
        (else (error "compile error"))))

(check-true (lambda? '(define inc (lambda (x) (+ x 1)))))
(check-false (lambda? 0))
(define (lambda? sexp) (eq? (first (third sexp)) 'lambda))

(check-equal? (sexp->number 1) "1")
(check-equal? (sexp->number 1.4) "1.4")
(define (sexp->number sexp) (number->string sexp))

(sexp-function '(define inc (lambda (x) (+ x 1))))
(define (sexp-function sexp)
  (define name (second sexp))
  (define args (second (third sexp)))
  (define body (third (third sexp)))
  (~a name " " args " " body))

(third '(define inc (lambda (x) (+ x 1))))

;; shifters chainset fd rd cassette chain brakes
(define one '(476 716 109 227 284 257 388))
(define tiagra '(493 910 106 277 308 273 360))

(foldl + 0 (comp tiagra one))
(define (comp gs1 gs2)
  (cond ((empty? gs1) '())
        (else (cons (- (first gs1) (first gs2))
                    (comp (rest gs1) (rest gs2))))))

