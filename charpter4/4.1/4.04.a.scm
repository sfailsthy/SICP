; and
(define (and? exp)
  (tagged-list? exp 'and))

(define (and-exps exp)
  (cdr exp))

(define (eval-and exps env)
  (let ((first (eval (first-exp exps) env)))
    (cond ((last-exp? exps)
           (if first
               first
               #f))
          (else
           (if first
               (eval-and (rest-exps exps) env)
               #f)))))

; or
(define (or? exp)
  (tagged-list? exp 'or))

(define (or-exps exp)
  (cdr exp))

(define (eval-or exps env)
  (let ((first (eval (first-exp exps) env)))
    (cond ((last-exp? exps)
           (if first
               first
               #f))
          (else
           (if first
               first
               (eval-or (rest-exps exps) env))))))