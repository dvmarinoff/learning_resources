#lang racket

(define (make-car brand name year battery kwh price)
  (list brand name year battery kwh price))

(define (brand vehicle)
  (car vehicle))

(define (name vehicle)
  (car (cdr vehicle)))

(define (year vehicle)
  (car (cdr (cdr vehicle))))

(define (battery vehicle)
  (car (cdr (cdr (cdr vehicle)))))

(define (kwh vehicle)
  (car (cdr (cdr (cdr (cdr vehicle))))))

(define (price vehicle)
  (car (cdr (cdr (cdr (cdr (cdr vehicle)))))))

(define e-up (make-car "vw" "e-Up" 2017 16.0 11.7 52852))
(define i3 (make-car "bmw" "i3" 2017 37.9 16.3 75950))

(define ice-small (make-car "ice-small" null 2017 null 7.0 30000))

(define night-cost-kwh 0.05429)
(define day-cost-kwh 0.1399)
(define petrol-cost-pl 2.44)

(define (min-cost-per-km vehicle)
  (/ (* (kwh vehicle) night-cost-kwh) 100))

(define (reg-cost-per-km vehicle)
  (/ (* (kwh vehicle) day-cost-kwh) 100))

(define (ice-cost vehicle)
  (/ (* (kwh vehicle) petrol-cost-pl) 100))

