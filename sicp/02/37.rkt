#lang racket
;; ex 02.37
;; matrix opperations
;;
;; Suppose we represent vectors v = (v i ) as sequences of
;; numbers, and matrices m = (m ij ) as sequences of vectors (the
;; rows of the matrix). For example, the matrix
;;
;; [ 1 2 3 4; 4 5 6 6; 6 7 8 9]
;;
;; is represented as the sequence ((1 2 3 4) (4 5 6 6) (6 7 8 9)).
;; With this representation, we can use sequence operations
;; to concisely express the basic matrix and vector operations.
;; These operations (which are described in any book on matrix
;; algebra) are the following:
;;
;; (dot-product u w)     return the sum $\sum_{i}u_{i}w_{i}$
;;
;; (matrix-*vector m v)  return the vector t, where
;;                       $t_{i} = \sum_{j} m_{ik} n_{kj}$
;;
;; (matrix-*-matrix m n) return the matrix p, where
;;                       $p_{ij} = \sum_{k} m_{ik} n_{kj}$
;;
;; (transpose m)         return the matrix n, where
;;                       $n_{ij} = m_{ji}$
;;
;; We can define the dot product as 17
;;
;; (define (dot-product v w)
;;   (accumulate + 0 (map * v w)))
;;
;; Fill in the missing expressions in the following procedures
;; for computing the other matrix operations. (The procedure
;; accumulate-n is defined in exercise 2.36.)
;;
;; (define (matrix-*-vector m v)
;;   (map <??> m))
;;
;; (define (transpose mat)
;;   (accumulate-n <??> <??> mat))
;;
;; (define (matrix-*-matrix m n)
;;   (let ((cols (transpose n)))
;;     (map <??> m)))
;;
