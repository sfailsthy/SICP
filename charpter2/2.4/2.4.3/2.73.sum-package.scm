(load "2.73.tag.scm")
(load "put-and-get.scm")

(define (install-sum-package)
  ;internal procedures
  (define (addend s)
    (car s))
  
  (define (augend s)
    (cadr s))

  (define (make-sum x y)
    (cond ((=number? x 0)
           y)
          ((=number? y 0)
           x)
          ((and (number? x)
                (number? y))
           (+ x y))
          (else
           (attach-tag '+ x y))))

  ;interface to the rest of system
  (put 'addend '+ addend)
  (put 'augend '+ augend)
  (put 'make-sum '+ make-sum)

  (put 'deriv '+
       (lambda (exp var)
         (make-sum (deriv (addend exp) var)
                   (deriv (augend exp) var))))
  'done)

(define (make-sum x y)
  ((get 'make-sum '+) x Y))

(define (addend s)
  ((get 'addend '+) (contents s)))

(define (augend s)
  ((get 'augend '+) (contents s)))

(define (=number? exp num)
  (and (number? exp) (= exp num)))