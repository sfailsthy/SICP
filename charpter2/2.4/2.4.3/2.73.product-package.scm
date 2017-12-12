(load "2.73.tag.scm")
(load "put-and-get.scm")

(define (install-product-package)
  ;internal procedures
  (define (multiplier p)
    (car p))

  (define (multiplicand p)
    (cadr p))

  (define (make-product x y)
    (cond ((or (=number? x 0)
               (=number? y 0))
           0)
          ((=number? x 1)
           y)
          ((=number? y 1)
           x)
          ((and (number? x)
                (number? y))
           (* x y))
          (else
           (attach-tag '* x y))))

  ;interface to the rest of system
  (put 'multiplier '* multiplier)
  (put 'multiplicand '* multiplicand)
  (put 'make-product '* make-product)

  (put 'deriv '*
       (lambda (exp var)
         (make-sum
          (make-product (multiplier exp)
                        (deriv (multiplicand exp) var))
          (make-product (deriv (multiplier exp) var)
                        (multiplicand exp)))))
  'done)

(define (multiplier product)
  ((get 'multiplier '*) (contents product)))

(define (multiplicand product)
  ((get 'multiplicand '*) (contents product)))

(define (make-product x y)
  ((get 'make-product '*) x y))

(define (=number? exp num)
  (and (number? exp) (= exp num)))