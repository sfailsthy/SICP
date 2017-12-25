(define (analyze exp)
  (cond ((self-evaluating? exp)
         (analyze-self-evaluating exp))
        ((quoted? exp)
         (analyze-quoted exp))
        ((variable? exp)
         (analyze-variable exp))
        ((assignment? exp)
         (analyze-assignment exp))
        ((permanent-set? exp)
         (analyze-permanent-set exp))
        ((definition? exp)
         (analyze-definition exp))
        ((if? exp)
         (analyze-if exp))
        ((if-fail? exp)
         (analyze-if-fail exp))
        ((lambda? exp)
         (analyze-lambda exp))
        ((begin? exp)
         (analyze-sequence (begin-actions exp)))
        ((cond? exp)
         (analyze (cond->if exp)))
        ((let? exp)
         (analyze (let->combination exp)))
        ((require? exp)
         (analyze-require exp))
        ((amb? exp)
         (analyze-amb exp))
        ((ramb? exp)
         (analyze-ramb exp))
        ((application? exp)
         (analyze-application exp))
        (else
         (error "Unknown expression type -- ANALYZE"
                exp))))