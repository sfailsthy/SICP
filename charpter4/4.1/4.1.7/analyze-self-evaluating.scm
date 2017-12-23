(define (analyze-self-evaluating exp)
  (lambda (env) exp))