(load "2.73.tag.scm")
(load "put-and-get.scm")
(load "2.73.product-package.scm")

(define (install-exponentiation-package)
  ;internal prodecures
  (define (base exp)
    (car exp))

  (define (exponent exp)
    (cadr exp))

  (define (make-exponentiation base exponent)
    (cond ((= exponent 0)
           1)
          ((= exponent 1)
           base)
          (else
           (attach-tag '** base exponent))))

  ;interface to the rest of system
  (put 'base '** base)
  (put 'exponent '** exponent)
  (put 'make-exponentiation '** make-exponentiation)

  (put 'deriv '**
       (lambda (exp var)
         (let ((u (base exp))
               (n (exponent exp)))
           (make-product n
                         (make-product
                          (make-exponentiation u
                                              (- n 1))
                          (deriv u var))))))
  'done)

(define (make-expoentiation base exponent)
  ((get 'make-exponentiation '**) base exponent))

(define (base exp)
  ((get 'base '**) (contents exp)))

(define (exponent exp)
  ((get 'exponent '**) (contents exp)))