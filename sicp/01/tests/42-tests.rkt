#lang racket

(require rackunit rackunit/text-ui)

(load "./42.rkt")

(define sicp-01.42-tests
  (test-suite
   "testing 01.42 compose procedure"

   (check-equal? ((compose sqr inc) 6) 49)
))

(run-tests sicp-01.42-tests)
