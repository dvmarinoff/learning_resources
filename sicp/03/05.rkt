#lang racket
;; ex 03.05
;; Monte Carlo integration - estimate-integral procedure
;;
;; Monte Carlo integration is a method of estimating definite
;; integrals by means of Monte Carlo simulation. Consider
;; computing the area of a region of space described by a
;; predicate P(x, y) that is true for points (x, y) in the region
;; and false for points not in the region. For example, the
;; region contained within a circle of radius 3 centered at (5,
;; 7) is described by the predicate that tests whether (x - 5) 2
;; + (y - 7) 2 < 3 2 . To estimate the area of the region
;; described by such a predicate, begin by choosing a rectangle
;; that contains the region. For example, a rectangle with
;; diagonally opposite corners at (2, 4) and (8, 10) contains the
;; circle above. The desired integral is the area of that portion
;; of the rectangle that lies in the region. We can estimate the
;; integral by picking, at random, points (x,y) that lie in the
;; rectangle, and testing P(x, y) for each point to determine
;; whether the point lies in the region. If we try this with many
;; points, then the fraction of points that fall in the region
;; should give an estimate of the proportion of the rectangle
;; that lies in the region. Hence, multiplying this fraction by
;; the area of the entire rectangle should produce an estimate of
;; the integral. Implement Monte Carlo integration as a procedure
;; estimate-integral that takes as arguments a predicate P, upper
;; and lower bounds x1, x2, y1, and y2 for the rectangle, and the
;; number of trials toperform in order to produce the estimate.
;; Your procedure should use the same monte-carlo procedure that
;; was used above to estimate . Use your estimate-integral to
;; produce an estimate of by measuring the area of a unit circle.
;; You will find it useful to have a procedure that returns a
;; number chosen at random from a given range. The following
;; random-in-range procedure implements this in terms of the
;; random procedure used in section 1.2.6, which returns a
;; nonnegative number less than its input.
;;
;; (define (random-in-range low high)
;;   (let ((range (- high low)))
;;     (+ low (random range))))

;;;;
;; Solution
;;;;

(define unit-circle (make-circle 1 (make-point 0 0)))
(define unit-rect (make-rect (make-point -1 -1)
                             (make-point 1 1)))

(define (estimate-pi)
  (exact->inexact
   (* (monte-carlo 100000
                   (lambda ()
                     (test-point unit-circle unit-rect)))
      (area-rect unit-rect))))

;; (estimate-pi)
;; -> 3.14904

(define (estimate-integral predicate x1 y1 x2 y2 trials)
  (monte-carlo trials (lambda () (predicate x1 y1 x2 y2))))

;;;;
;; Infrastructure
;;;;

;; I decided to use data-abstaction as in chapter 2, which
;; complicates the solution, but is good practice.
;; I am not using the estimate-integral function since it is
;; not suitable for this approach
(define (test-point circle rect)
  (let ((point (random-point-in-rect rect)))
    (inside-circle? circle point)))

(define (random-point-in-rect rect)
  (make-point (random-float (x1 rect) (x2 rect))
              (random-float (y1 rect) (y2 rect))))

(define (random-float min max)
  (/ (random-in-range (+ 1 (* 100 min)) (+ 1 (* 100 max))) 100.0))

(define (inside-circle? circle point)
  (<= (+ (sqr (- (x-coord point) (x-center circle)))
         (sqr (- (y-coord point) (y-center circle))))
      (sqr (radius circle))))

(define (make-circle r center) (cons r center))
(define (radius circle) (car circle))
(define (x-center circle) (x-coord (cdr circle)))
(define (y-center circle) (y-coord (cdr circle)))

(define (make-rect bottom-left top-right)
  (cons bottom-left top-right))
(define (bottom-left rect) (car rect))
(define (top-right rect) (cdr rect))
(define (x1 rect) (x-coord (bottom-left rect)))
(define (x2 rect) (x-coord (top-right rect)))
(define (y1 rect) (y-coord (bottom-left rect)))
(define (y2 rect) (y-coord (top-right rect)))
(define (area-rect rect)
  (* (- (x2 rect) (x1 rect))
     (- (y2 rect) (y1 rect))))

(define (make-point x y) (cons x y))
(define (x-coord point) (car point))
(define (y-coord point) (cdr point))

;;;;
;; Required code
;;;;
(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
           (/ trials-passed trials))
          ((experiment) (iter (- trials-remaining 1)
                              (+ trials-passed 1)))
          (else (iter (- trials-remaining 1)
                      trials-passed))))
  (iter trials 0))

(define (random-in-range low high)
  (let ((range (- high low)))
    (+ low (random range))))

;; (define random-init 1)
;; (define rand (let ((x random-init))
;;                (lambda ()
;;                  (set! x (random-update x))
;;                  x)))
;; (define (random-update x)
;;   x)
;; (define (estimate-pi trials)
;;   (sqrt (/ 6 (monte-carlo trials cesaro-test))))
;; (define (cesaro-test)
;;   (= (gcd (rand) (rand)) 1))
