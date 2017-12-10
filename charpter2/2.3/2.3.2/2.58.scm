(define (variable? x)
  (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1)
       (variable? v2)
       (eq? v1 v2)))

(define (=number? exp num)
  (and (number? exp)
       (= exp num)))

;sum
(define (make-sum a1 a2)
  (cond ((=number? a1 0)
         a2)
        ((=number? a2 0)
         a1)
        ((and (number? a1)
              (number? a2))
         (+ a1 a2))
        (else
         (list a1 '+ a2))))

(define (sum? x)
  (and (pair? x)
       (eq? (cadr x)
            '+)))

(define (addend s)
  (car s))

(define (augend s)
  (caddr s))

;product
(define (make-product m1 m2)
  (cond ((or (=number? m1 0)
             (=number? m2 0))
         0)
        ((=number? m1 1)
         m2)
        ((=number? m2 1)
         m1)
        ((and (number? m1)
              (number? m2))
         (* m1 m2))
        (else
         (list m1 '* m2))))

(define (product? x)
  (and (pair? x)
       (eq? (cadr x)
            '*)))

(define (multiplier p)
  (car p))

(define (multiplicand p)
  (caddr p))

;exp
(define (make-exponentiation base exponent)
  (cond ((= exponent 0)
         1)
        ((= exponent 1)
         base)
        (else
         (list '** base exponent))))

(define (exponentiation? exp)
  (and (pair? exp)
       (eq? (car exp)
            '**)))

(define (base exp)
  (cadr exp))

(define (exponent exp)
  (caddr exp))