#lang racket

(require rackunit rackunit/text-ui)

(load "../03.rkt")

(define sicp-03.03-tests
  (test-suite
   "testing 03.03 add password to make-account"

   ;; (check-equal? (make-account 100 'secret-password) null)
   (check-equal? ((acc 'secret-password 'withdraw) 40) 60)
   (check-equal? ((acc 'some-other-password 'deposit) 50)
                 "Incorrect password")
))

(run-tests sicp-03.03-tests)
