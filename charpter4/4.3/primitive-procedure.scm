(load "prime.scm")

(define (primitive-procedure? proc)
  (tagged-list? proc 'primitive))

(define (primitive-implementation proc)
  (cadr proc))

(define primitive-procedures
  (list (list 'car car)
        (list 'cdr cdr)
        (list 'cons cons)
        (list 'null? null?)

        (list '+ +)
        (list '- -)
        (list '* *)
        (list '/ /)
        (list 'abs abs)

        (list '= =)
        (list '< <)
        (list '<= <=)
        (list '> >)
        (list '>= >=)

        (list 'sqrt sqrt)
        (list 'square square)
        (list 'expt expt)

        (list 'sin sin)
        (list 'cos cos)
        (list 'tan tan)
        (list 'atan atan)

        (list 'assoc assoc)
        (list 'real-time-clock real-time-clock)
        (list 'not not)
        (list 'newline newline)
        (list 'display display)

        (list 'prime? prime?)
        ; other primitive procedures
        ))

(define (primitive-procedure-names)
  (map car primitive-procedures))

(define (primitive-procedure-objects)
  (map (lambda (proc)
         (list 'primitive (cadr proc)))
       primitive-procedures))

(define (apply-primitive-procedure proc args)
  (apply (primitive-implementation proc) args))