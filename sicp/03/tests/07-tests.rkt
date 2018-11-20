#lang racket

(require rackunit rackunit/text-ui)

(load "../07.rkt")


(define sicp-03.07-tests
  (test-suite
   "testing 03.07 make-joint account procedure"

    (test-begin
     (let* ((peter-acc (make-account 100 'open-sesame))
            (paul-acc (make-joint peter-acc 'open-sesame 'rosebud)))
       ((peter-acc 'rosebud 'deposit) 10)
       ((paul-acc 'rosebud 'deposit) 10)
       ((peter-acc 'rosebud 'withdraw) 10)
       (check-equal? ((peter-acc 'open-sesame 'deposit) 0) 110)))
))

(run-tests sicp-03.07-tests)
