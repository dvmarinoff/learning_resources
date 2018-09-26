;;;;
;; original
;;;;

(load "pmatch.scm")

;;;;
;; the most beautiful program ever written
;;;;
(define eval-expr
  (lambda (expr env)
    (pmatch expr
[,x (guard (symbol? x))
    (env x)]
[(lambda (,x) ,body)
 (lambda (arg)
   (eval-expr body (lambda (y)
                     (if (eq? x y)
                         arg
                         (env y)))))]
[(,rator ,rand)
 ((eval-expr rator env)
  (eval-expr rand env))]
)))

(define eval-expr
  (lambda (expr env)
    (pmatch expr
      [,n (guard (number? n)) n]
      [(zero? ,e)
       (zero? (eval-expr e env))]
      [(add1 ,e)
       (add1 (eval-expr e))]
      [(sub1 ,e)
       (sub1 (eval-expr e))]
      [(* ,e1 ,e2)
       (* (eval-expr e1)
          (eval-expr e2))]
      [(if ,t ,c ,a)
       (if (eval-expr t)
           (eval-expr c)
           (eval-expr a))]
      ;; the 3 x 5 card interpreter, the above is garbidge
      ;; turing-complete, uses env instead of beta-reduction,
      ;; the call-by-value lambda calculus, environment passing
      [,x (guard (symbol? x))
          (env x)]
      [(lambda (,x) ,body)
       (lambda (arg)
         (eval-expr body (lambda (y)
                           (if (eq? x y)
                               arg
                               (env y)))))]
      [(,rator ,rand)
       ((eval-expr rator env)
        (eval-expr rand env))]
      )))

(eval-expr '(((lambda (x) x) (lambda (y) y)) 5)
           (lambda (y)
             (error 'lookup "unbound")))

;; factorial with y combinator
(((lambda (!)
    (lambda (n)
      ((! !) n)))
  (lambda (!)
    (lambda (n)
      (if (zero? n)
          1
          (* n ((! !) (sub1 n)))))))
 5)

;; -> 120

;; (require racket/match)

;; (define (eval-expr expr)
;;   (match expr
;;     ;; [number? expr]
;;     [list? expr]))

;; (define (id x) x)
;; (define (inc x) (add1 x))

;; (eval-expr '(+ 1 3))
;; (number? 1)
