(define (tagged-list? exp tag)
  (if (pair? exp)
      (eq? (car exp) tag)
      false))

; predicate tests
(define (true? x) (not (eq? x false)))
(define (false? x) (eq? x false))

; procedure expression
(define (make-procedure parameters body env)
  (list 'procedure parameters body env))

;; primitive procedure
(define (primitive-procedure? proc)
  (tagged-list? proc 'primitive))

(define (primitive-implementation proc) (cadr proc))

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
        ; other primitive procedures
        ))

(define (primitive-procedure-names)
  (map car
       primitive-procedures))

(define (primitive-procedure-objects)
  (map (lambda (proc) (list 'primitive (cadr proc)))
       primitive-procedures))

(define (apply-primitive-procedure proc args)
  (apply
   (primitive-implementation proc) args))

;; compound procedure
(define (compound-procedure? p)
  (tagged-list? p 'procedure))

(define (procedure-parameters p) (cadr p))
(define (procedure-body p) (caddr p))
;(define (procedure-body p) (scan-out-defines (caddr p)))
(define (procedure-environment p) (cadddr p))

;;self-evaluating: number or string
(define (self-evaluating? exp)
  (cond ((number? exp) true)
        ((string? exp) true)
        (else false)))

;;variable
(define (variable? exp) (symbol? exp))

;;quote: (quote <text-of-quotation>)
(define (quoted? exp) (tagged-list? exp 'quote))
(define (text-of-quotation exp) (cadr exp))

;;assignment: (set! <var> <value>)
(define (assignment? exp)
  (tagged-list? exp 'set!))

(define (assignment-variable exp) (cadr exp))
(define (assignment-value exp) (caddr exp))

(define (make-assignment var val)
  (list 'set! var val))

;;definition: (define <var> <value>) or
;;            (define (<var> <parameter1> ... <parametern>)
;;              <body>))
;;which is    (define <var>
;;              (lambda (<parameter1> ... <parametern>)
;;                <body>))
(define (definition? exp)
  (tagged-list? exp 'define))

(define (definition-variable exp)
  (if (symbol? (cadr exp))
      (cadr exp)
      (caadr exp)))

(define (definition-value exp)
  (if (symbol? (cadr exp))
      (caddr exp)
      (make-lambda (cdadr exp)   ; formal parameters
                   (cddr exp)))) ; body

(define (make-definition var parameters body)
  (cons 'define (cons (cons var parameters) body)))

;;lambda: (lambda (<parameter1> ... <parametern>)
;;          <body>)
(define (lambda? exp) (tagged-list? exp 'lambda))

(define (lambda-parameters exp) (cadr exp))

(define (lambda-body exp) (cddr exp))

(define (make-lambda parameters body)
  (cons 'lambda (cons parameters body)))

;;if: (if <predicate>
;;        <consequent>
;;        (<alternative>))
(define (if? exp) (tagged-list? exp 'if))

(define (if-predicate exp) (cadr exp))
(define (if-consequent exp) (caddr exp))
(define (if-alternative exp)
  (if (not (null? (cdddr exp)))
      (cadddr exp)
      'false))

;;make-if used in cond
(define (make-if predicate consequent alternative)
  (list 'if predicate consequent alternative))

;;begin: (begin <exp1>
;;              <exp2>
;;              ...
;;              <expn>)
(define (begin? exp) (tagged-list? exp 'begin))

(define (begin-actions exp) (cdr exp))

(define (last-exp? exp) (null? (cdr exp)))
(define (first-exp exp) (car exp))
(define (rest-exps exp) (cdr exp))

(define (sequence->exp seq)
  (cond ((null? seq) seq)
        ((last-exp? seq) (first-exp seq))
        (else (make-begin seq))))

(define (make-begin seq) (cons 'begin seq))

;;process application
(define (application? exp) (pair? exp))

(define (operator exp) (car exp))
(define (operands exp) (cdr exp))

(define (no-operands? ops) (null? ops))
(define (first-operand ops) (car ops))
(define (rest-operands ops) (cdr ops))

(define (make-application proc arguments)
  (cons proc arguments))

;;cond: (cond (<predicate1> <consequent1>)
;;            ...
;;            (else <alternative>))
(define (cond? exp) (tagged-list? exp 'cond))
(define (cond-clauses exp) (cdr exp))
(define (cond-else-clause? clause)
  (eq? (cond-predicate clause) 'else))
(define (cond-predicate clause) (car clause))
(define (cond-actions clause) (cdr clause))

(define (cond->if exp)
  (expand-clauses (cond-clauses exp)))

(define (expand-clauses clauses)
  (if (null? clauses)
      'false                          ; no else clause
      (let ((first (car clauses))
            (rest (cdr clauses)))
        (if (cond-else-clause? first)
            (if (null? rest)
                (sequence->exp (cond-actions first))
                (error "ELSE clause isn't last -- COND->IF"
                       clauses))
            (make-if (cond-predicate first)
                     (sequence->exp (cond-actions first))
                     (expand-clauses rest))))))

;;let: (let ((<var1> <exp1>) ... (<varn> <expn>))
;;       <body>)
(define (let? exp)
  (tagged-list? exp 'let))

(define (let-bindings exp) (cadr exp))
(define (let-vars exp) (map car (let-bindings exp)))
(define (let-vals exp) (map cadr (let-bindings exp)))

(define (let-body exp) (cddr exp))

(define (let->combination exp)
  (let ((vars (let-vars exp)) (vals (let-vals exp)))
    (make-application (make-lambda vars
                                   (let-body exp))
                      vals)))

(define (make-let bindings body)
  (cons 'let (cons bindings body)))

;;and: (and <predicate1> <predicate2> ... <predicaten>)
(define (and? exp)
  (tagged-list? exp 'and))

(define (and-predicates exp) (cdr exp))

(define (and->if exp)
  (expand-and-predicates (and-predicates exp)))

(define (expand-and-predicates preds)
  (if (null? preds)
      'true
      (let ((first (car preds))
            (rest (cdr preds)))
        (if (null? rest)
            (make-if first first 'false)
            (make-if first
                     (expand-and-predicates rest)
                     'false)))))
  
;;or: (or <predicate1> <predicate2> ... <predicaten>)
(define (or? exp)
  (tagged-list? exp 'or))

(define (or-predicates exp) (cdr exp))

(define (or->if exp)
  (expand-or-predicates (or-predicates exp)))

(define (expand-or-predicates preds)
  (if (null? preds)
      'false
      (make-if (car preds)
               (car preds)
               (expand-or-predicates (cdr preds)))))