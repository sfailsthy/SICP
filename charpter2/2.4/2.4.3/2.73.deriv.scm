(load "put-and-get.scm")
(load "2.73.sum-package.scm")
(load "2.73.product-package.scm")
(load "2.73.exponentiation-package.scm")

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp)
         (if (same-variable? exp var)
             1
             0))
        (else
         ((get 'deriv (operator exp)) (operands exp)
                                      var))))

(define (operator exp) (car exp))

(define (operands exp) (cdr exp))

(define (variable? x)
  (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1)
       (variable? v2)
       (eq? v1 v2)))

(install-sum-package)
(install-product-package)
(install-exponentiation-package)