#lang racket

(require rackunit rackunit/text-ui)

(load "./45.rkt")

(define sicp-01.45-tests
  (test-suite
   "testing 01.45 compute n-th roots with average-damp procedure"

    (check-= (nth-root 2 4) 2 0.000001)
    (check-= (nth-root 3 8) 2 0.000001)
    (check-= (nth-root 4 16) 2 0.000001)
    (check-= (nth-root 5 32) 2 0.000001)
    (check-= (nth-root 6 64) 2 0.000001)
    (check-= (nth-root 7 128) 2 0.000001)
    (check-= (nth-root 8 256) 2 0.000001)
    (check-= (nth-root 9 512) 2 0.000001)
    (check-= (nth-root 10 1024)2 0.000001)
    (check-= (nth-root 16 65536) 2 0.000001)
    (check-= (nth-root 17 131072) 2 0.000001)
    (check-= (nth-root 32 4294967296) 2 0.000001)
))

(run-tests sicp-01.45-tests)
