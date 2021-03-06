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
(define (make-sum a1 . a2)
  (if (= (length a2) 1)
      (let ((a2 (car a2)))
        (cond ((=number? a1 0)
               a2)
              ((=number? a2 0)
               a1)
              ((and (number? a1)
                    (number? a2))
               (+ a1 a2))
              (else
               (list '+ a1 a2))))
      (cons '+ (cons a1 a2))))
  
(define (sum? x)
  (and (pair? x)
       (eq? (car x)
            '+)))

(define (addend s)
  (cadr s))

(define (augend s)
  (let ((a (cddr s)))
    (if (= (length a) 1)
        (car a)
        (apply make-sum a))))

;product
(define (make-product m1 . m2)
  (if (= (length m2) 1)
      (let ((m2 (car m2)))
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
               (list '* m1 m2))))
      (cons '* (cons m1 m2))))

(define (product? x)
  (and (pair? x)
       (eq? (car x)
            '*)))

(define (multiplier p)
  (cadr p))

(define (multiplicand p)
  (let ((m (cddr p)))
    (if (= (length m) 1)
        (car m)
        (apply make-product m))))

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