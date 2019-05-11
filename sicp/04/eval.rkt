;; 00. Eval from lecture 7A part 1
;; The core of any language.

(define (eval exp env)
    (cond ((number? exp) exp)
          ((symbol? exp) (lookup exp env))
          ((eq? (car exp) 'quote) (cadr exp))
          ((eq? (car exp) 'lambda) (list 'closure (cdr exp) env))
          ((eq? (car exp) 'cond) (evcond (cdr exp) env))
          (else (apply (eval (car exp) env) (evlist (cdr exp) env)))))

(define (apply proc args)
    (cond ((primitive? proc) (apply-primop proc args))
          ((eq? (car proc) 'closure)
           (eval (cadadr proc)
                 (bind (caadr proc) args (caddr proc))))
          (else error)))

(define (evlist lst env)
  (cond ((empty? lst) '())
        (else (cons (eval (car lst) env)
                    (evlist (cdr lst) env)))))

(define (evcond clauses env)
  (cond ((empty? clauses) '())
        ((eq? (caar clauses) 'else) (eval (cadar clauses) env))
        ((false? (eval (caar clauses) env)) (evcond (cdr clauses) env))
        (else (eval (cadar clauses) env))))

(define (bind vals vars env)
  (cons (pair-up vars vals) env))

(define (pair-up vars vals)
  (cond ((empty? vars)
         (cond ((empty? vals) '())
               (else (error "TMA"))))
        ((empty? vals) (error "TFA"))
        (else (cons (cons (car vars) (car vals))
                    (pair-up (cdr vars)
                             (cdr vals))))))

(define (lookup sym env)
  (cond ((empty? env) (error "Unbound variable"))
        (else ((lambda (vcell)
                 (cond ((empty? vcell) (lookup sym (cdr env)))
                       (else (cdr vcell))))
               (assq sym (car env))))))

(define (assq sym lst)
  (cond ((empty? lst) '())
        ((eq? sym (caar lst)) (car lst))
        (else (assq sym (cdr lst)))))
