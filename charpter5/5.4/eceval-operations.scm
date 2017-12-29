(define (prompt-for-input string)
  (newline) (newline) (display string) (newline))

(define (announce-output string)
  (newline) (display string) (newline))

(define (user-print object)
  (cond ((compound-procedure? object)
         (display (list 'compound-procedure
                        (procedure-parameters object)
                        (procedure-body object))))
        (else
         (display object))))

(define (adjoin-arg arg arglist)
  (append arglist (list arg)))

(define (last-operand? ops)
    (null? (cdr ops)))

(define eceval-operations
  (list (list 'self-evaluating? self-evaluating?)
        (list 'variable? variable?)
        
        (list 'quoted? quoted?)
        (list 'text-of-quotation text-of-quotation)
        
        (list 'assignment? assignment?)
        (list 'assignment-variable assignment-variable)
        (list 'assignment-value assignment-value)
        
        (list 'definition? definition?)
        (list 'definition-variable definition-variable)
        (list 'definition-value definition-value)
        
        (list 'if? if?)
        (list 'if-predicate if-predicate)
        (list 'if-consequent if-consequent)
        (list 'if-alternative if-alternative)
        
        (list 'cond? cond?)
        (list 'cond-clauses cond-clauses)
        (list 'first-clause car)
        (list 'rest-clauses cdr)
        (list 'cond-else-clause? cond-else-clause?)
        (list 'cond-predicate cond-predicate)
        (list 'cond-actions cond-actions)
        
        (list 'lambda? lambda?)
        (list 'lambda-parameters lambda-parameters)
        (list 'lambda-body lambda-body)
        
        (list 'let? let?)
        (list 'let-vars let-vars)
        (list 'let-vals let-vals)
        (list 'let-body let-body)
          
        (list 'begin? begin?)
        (list 'begin-actions begin-actions)
        (list 'last-exp? last-exp?)
        (list 'first-exp first-exp)
        (list 'rest-exps rest-exps)
        (list 'sequence->exp sequence->exp)
          
        (list 'application? application?)
        (list 'operator operator)
        (list 'operands operands)
        (list 'no-operands? no-operands?)
        (list 'first-operand first-operand)
        (list 'rest-operands rest-operands)
        (list 'last-operand? last-operand?)
        (list 'adjoin-arg adjoin-arg)
          
        ; predicate tests
        (list 'true? true?)
        (list 'false? false?)
          
        ; procudure
        (list 'primitive-procedure? primitive-procedure?)
        (list 'apply-primitive-procedure apply-primitive-procedure)
        (list 'make-procedure make-procedure)
        (list 'compound-procedure? compound-procedure?)
        (list 'procedure-parameters procedure-parameters)
        (list 'procedure-body procedure-body)
        (list 'procedure-environment procedure-environment)
        (list 'empty-arglist (lambda () '()))
          
        ; environment procedures
        (list 'lookup-variable-value lookup-variable-value)
        (list 'set-variable-value! set-variable-value!)
        (list 'define-variable! define-variable!)
        (list 'extend-environment extend-environment)
        (list 'get-global-environment get-global-environment)
          
        ; for print
        (list 'prompt-for-input prompt-for-input)
        (list 'announce-output announce-output)
        (list 'user-print user-print)
          
        ; native procedures
        (list 'read read)
        (list 'null? null?)
        (list 'display display)
        (list 'eq? eq?)
        (list 'symbol? symbol?)
        (list '= =)
        (list '- -)
        (list '* *)
        (list '+ +)
        (list 'list list)
        (list 'cons cons)
        (list 'car car)
        (list 'cdr cdr)))