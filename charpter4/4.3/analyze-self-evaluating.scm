(define (analyze-self-evaluating exp)
  (lambda (env succeed fail)
    (succeed exp fail)))