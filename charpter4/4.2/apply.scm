(define (applyn procedure arguments env)
  (cond ((primitive-procedure? procedure)
         (apply-primitive-procedure procedure
                                    (list-of-arg-values arguments env)))
        ((compound-procedure? procedure)
         (eval-sequence (procedure-body procedure)
                        (extend-environment (procedure-parameters procedure)
                                           (list-of-delayed-args arguments env)
                                           (procedure-environment procedure))))
        (else
         (error "Unknown procedure type -- APPLY"
                procedure))))