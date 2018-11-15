#lang racket

(require rackunit rackunit/text-ui)

(load "./75.rkt")

(define sicp-02.75-tests
  (test-suite
   "testing 02.75 message-passing style make-from-mag-ang"

    (check-equal? ((make-from-mag-ang 10 45) 'magnitude) 10)
    (check-equal? ((make-from-mag-ang 10 45) 'angle) 45)
    (check-equal? ((make-from-mag-ang 10 45) 'real-part)
                  5.253219888177298)
    (check-equal? ((make-from-mag-ang 10 45) 'imag-part)
                  8.509035245341185)
))

(run-tests sicp-02.75-tests)
