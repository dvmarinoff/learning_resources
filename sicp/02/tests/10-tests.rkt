#lang racket

(require rackunit rackunit/text-ui)

(load "./10.rkt")

(define sicp-02.10-tests
  (test-suite
   "testing 02.10 interval arithmetic zero division"

   (check-exn
    exn:fail?
    (lambda ()
      (div-interval (make-interval 1.1 1.4)
                    (make-interval 0 1))))

   (check-exn
    exn:fail?
    (lambda ()
      (div-interval (make-interval 1.1 1.4)
                    (make-interval 1 0))))
))

(run-tests sicp-02.10-tests)
