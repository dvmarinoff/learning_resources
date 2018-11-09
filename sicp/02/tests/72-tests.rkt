#lang racket

(require rackunit rackunit/text-ui)

(load "../72.rkt")

(define sicp-02.72-tests
  (test-suite
   "testing 02.72 Huffman encoding time complexity"

    (check-equal? (main 0) 0)
))

(run-tests sicp-02.72-tests)
