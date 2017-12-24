(define (actual-value exp env)
  (force-it (eval exp env)))