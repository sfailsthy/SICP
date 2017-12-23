(define (analyze-variable exp)
  (lambda (env) (lookup-variable-value exp env)))